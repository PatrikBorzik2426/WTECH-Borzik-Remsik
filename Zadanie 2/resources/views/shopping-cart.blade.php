<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    @vite('resources/css/app.css')
</head>

<body class=" text-manrope bg-gradient-to-b from-dark-purple to-black h-screen max-sm:h-full font-manrope min-w-80">
    <header>
        <x-navbar />
    </header>
    <main
        class="flex justify-center items-start gap-x-32 mx-auto pt-20 max-sm:pt-10 max-lg:gap-x-10 max-sm:flex-col max-sm:h-full">
        <div class="w-5/12 text-light-green max-sm:w-10/12 max-sm:mx-auto mb-12">
            <h2 class="text-4xl font-bold mb-10">Nákupný košík</h2>
            <div class="grid grid-cols-3 gap-y-4">
                <h3 class="text-lg font-medium">Názov</h3>
                <h3 class="text-lg font-medium text-center">Kusy</h3>
                <h3 class="text-lg font-medium text-right">Cena (ks)</h3>

                @auth
                    @foreach ($product_names as $index => $product_name)
                        <input type="number" name="cartItemId{{ $index }}" id="cartItemId{{ $index }}"
                            value={{ $cart_items[$index] }} class="hidden">
                        <p class="font-light">{{ $product_name }}</p>
                        <div class="mx-auto my-auto">
                            <button id="decrementQuantity{{ $index }}" type="button"
                                class="bg-light-green text-dark-purple font-bold w-6 rounded-l-2xl -mr-[0.15rem]">-</button>
                            <input type="number" name="quantity{{ $index }}" id="quantity{{ $index }}"
                                min="1" max="100" value="{{ $product_quantities[$index] }}"
                                class=" appearance-none bg-transparent text-center focus:outline-none">
                            <button id="incrementQuantity{{ $index }}" type="button"
                                class="bg-light-green text-dark-purple font-bold w-6 rounded-r-2xl -ml-[1.15rem]">+</button>
                        </div>
                        <p class="text-right font-bold my-auto">
                            {{ ucfirst(number_format($product_prices[$index], 2, ',', ' ')) }} €</p>
                    @endforeach
                @endauth
            </div>
        </div>
        <aside
            class=" h-10/12 text-light-green shadow-custom shadow-light-purple rounded-3xl p-10 max-sm:mb-16 max-sm:mx-auto">
            <form action="/process-order" method="get" id="processForm">
                @csrf
                <h2 class="text-3xl text-center font-semibold mb-4">
                    Prepočet ceny
                </h2>
                <div class="grid grid-cols-2">
                    <p id="taxLessPrice">Cena bez DPH</p>
                    <p class="text-right">{{ number_format($total_price, 2, ',', ' ') }} €</p>
                    <p>Cena s DPH</p>
                    <p class="text-right" id="preTotalPrice">{{ number_format($total_price_taxed, 2, ',', ' ') }} €</p>
                    <p>Doprava</p>
                    <p class="text-right" id="transportPrice">0 €</p>

                </div>
                <hr class="mt-8 mb-4">
                <div class="grid grid-cols-2 font-bold mb-4">
                    <p>Spolu</p>
                    <p class="text-right" id="finalPrice">0 €</p>
                </div>
                <input class="hidden" name="taxLessPriceInput" value="{{ $total_price }}" id="taxLessPriceInput">
                <input class="hidden" name="totalPriceInputFinal" value="" id="totalPriceInputFinal">
                <input class="hidden" name="totalTaxedPriceInput" value="{{ $total_price_taxed }}">
                <div>
                    <h2 class="text-3xl text-center font-semibold my-4">
                        Doprava
                    </h2>
                    @error('pickUp')
                        <p
                            class="animate-custom_pulse text-center animate-once font-light text-red-600 px-2 mb-2 rounded-xl">
                            {{ $message }}</p>
                    @enderror
                    <div class="flex items-center justify-between additionalPaymentDiv">
                        <input type="radio" name="pickUp" id="transport1" value="transport1"
                            class="radio-input appearance-none w-3 h-3 rounded-full bg-light-green checked:bg-dark-purple checked:border-light-green checked:border-2">
                        <label for="localPickup" class="text-light">Osobný odber</label>
                    </div>
                    <div class="flex items-center justify-between additionalPaymentDiv">
                        <input type="radio" name="pickUp" id="transport2" value="transport2"
                            class="radio-input appearance-none w-3 h-3 rounded-full bg-light-green checked:bg-dark-purple checked:border-light-green checked:border-2">
                        <label name="skPost" class="text-light">Slovenská pošta</label>
                    </div>
                    <div class="flex items-center justify-between additionalPaymentDiv">
                        <input type="radio" name="pickUp" id="transport3" value="transport3"
                            class="radio-input appearance-none w-3 h-3 rounded-full bg-light-green checked:bg-dark-purple checked:border-light-green checked:border-2">
                        <label name="packeta" class="text-light">Packeta</label>
                    </div>

                    <h2 class="text-3xl text-center font-semibold my-4">
                        Platba
                    </h2>
                    @error('pickUpPayment')
                        <p
                            class="animate-custom_pulse text-center animate-once font-light text-red-600 px-2 mb-2 rounded-xl">
                            {{ $message }}</p>
                    @enderror
                    <div class="flex items-center justify-between additionalPaymentDiv">
                        <input type="radio" name="pickUpPayment" id="payment1" value="payment1"
                            class="radio-input appearance-none w-3 h-3 rounded-full bg-light-green checked:bg-dark-purple checked:border-light-green checked:border-2">
                        <label for="pickUpPayment" class="text-light">Dobierka</label>
                    </div>
                    <div class="flex items-center justify-between additionalPaymentDiv">
                        <input type="radio" name="pickUpPayment" id="payment2" value="payment2"
                            class="radio-input appearance-none w-3 h-3 rounded-full bg-light-green checked:bg-dark-purple checked:border-light-green checked:border-2">
                        <label name="store2" class="text-light">Kartou online</label>
                    </div>
                </div>
                <button type="submit" form="processForm"
                    class=" w-full py-2 mt-10 bg-light-purple text-center rounded-full hover:bg-light-green hover:text-dark-purple hover:font-bold">
                    Pokračovať
                </button>
            </form>
        </aside>
    </main>
</body>
<script src="{{ asset('js/quantity_change_shop.js') }}"></script>
<script src="{{ asset('js/update_shopping_items_number.js') }}"></script>

</html>