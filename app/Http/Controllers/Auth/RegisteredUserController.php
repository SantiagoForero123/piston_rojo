<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\View\View;

class RegisteredUserController extends Controller
{
    //  Constantes para evitar repetición y mejorar mantenibilidad
    private const MAX_NOMBRE = 100;
    private const MAX_CORREO = 191;
    private const MAX_TIPO_DOCUMENTO = 30;
    private const MAX_NUMERO_DOCUMENTO = 50;
    private const MAX_TELEFONO = 20;

    /**
     * Mostrar el formulario de registro.
     */
    public function create(): View
    {
        return view('auth.register');
    }

    /**
     * Manejar el registro del usuario.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request): RedirectResponse
    {
        $request->validate([
            'name' => ['required', 'string', 'max:' . self::MAX_NOMBRE],
            'apellido' => ['required', 'string', 'max:' . self::MAX_NOMBRE],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:' . self::MAX_CORREO, 'unique:users'],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
            'tipo_documento' => ['required', 'string', 'max:' . self::MAX_TIPO_DOCUMENTO],
            'numero_documento' => ['required', 'string', 'max:' . self::MAX_NUMERO_DOCUMENTO, 'unique:users,numero_documento'],
            'fecha_nacimiento' => ['nullable', 'date'],
            'telefono' => ['nullable', 'string', 'max:' . self::MAX_TELEFONO],
        ]);

        $user = User::create([
            'name' => $request->name,
            'apellido' => $request->apellido,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 'cliente',
            'tipo_documento' => $request->tipo_documento,
            'numero_documento' => $request->numero_documento,
            'fecha_nacimiento' => $request->fecha_nacimiento,
            'telefono' => $request->telefono,
        ]);

        event(new Registered($user));

        return redirect('/login');
    }
}