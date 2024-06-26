<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    use HasFactory;

    protected $fillable = [
        'link',
        'product_id'
    ];

    const UPDATED_AT = null;

    public function image()
    {
        return [
            $this->hasOne(Product::class),
        ];
    }
}
