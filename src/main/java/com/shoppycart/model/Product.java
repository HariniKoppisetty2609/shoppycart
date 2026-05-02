package com.shoppycart.model;

public class Product {
    private int id;
    private String name;
    private int price;
    private String description;
    private String icon;
    private String category;

    public Product(int id, String name, int price, String description, String icon, String category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.icon = icon;
        this.category = category;
    }

    public int getId()           { return id; }
    public String getName()      { return name; }
    public int getPrice()        { return price; }
    public String getDescription(){ return description; }
    public String getIcon()      { return icon; }
    public String getCategory()  { return category; }

    public String getFormattedPrice() {
        return String.format("₹%,d", price);
    }
}
