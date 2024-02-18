<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    use HasFactory;

    const UPDATED_AT = null;

    public function user()
    {
        return [
            $this->belongsToMany(Order::class),
            $this->belongsTo(ShoppingSession::class),
        ];
    }
}