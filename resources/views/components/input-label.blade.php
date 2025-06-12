@props(['valor', 'for' => null])

<label
    @if ($for) for="{{ $for }}" @endif
    {{ $attributes->merge(['class' => 'block text-sm font-medium text-gray-700 dark:text-gray-300']) }}
>
    {{ $valor ?? $slot }}
</label>
