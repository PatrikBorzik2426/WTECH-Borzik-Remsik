<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CartItem extends Model
{
    use HasFactory;

    const UPDATED_AT = null;


    public function cartItem()
    {
        return [
            $this->hasOne(Product::class),
            $this->hasOne(ShoppingSession::class),
        ];
    }
}