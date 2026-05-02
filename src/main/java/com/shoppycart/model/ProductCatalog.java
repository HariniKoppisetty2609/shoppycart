package com.shoppycart.model;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class ProductCatalog {

    private static final List<Product> PRODUCTS = Arrays.asList(
        new Product(1, "Wireless Headphones", 2499, "Noise cancelling · 30hr battery",  "🎧", "Electronics"),
        new Product(2, "Smart Watch",          3999, "Fitness tracker · AMOLED display",  "⌚", "Wearables"),
        new Product(3, "Cotton T-Shirt",        799, "Premium cotton · Round neck",        "👕", "Clothing"),
        new Product(4, "Backpack",             1499, "Waterproof · Laptop sleeve",         "🎒", "Accessories"),
        new Product(5, "Bluetooth Speaker",    1899, "Portable · Deep bass",               "🔊", "Electronics"),
        new Product(6, "Sneakers",             2999, "Running shoes · Cushion sole",       "👟", "Footwear"),
        new Product(7, "Coffee Mug",            349, "Ceramic · 350ml",                    "☕", "Home"),
        new Product(8, "Desk Lamp",            1199, "LED · Adjustable brightness",        "💡", "Home")
    );

    public static List<Product> getAll() {
        return PRODUCTS;
    }

    public static Optional<Product> findById(int id) {
        return PRODUCTS.stream().filter(p -> p.getId() == id).findFirst();
    }
}
