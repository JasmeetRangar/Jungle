require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it "saves successfully given a product with all fields filled" do
      category = Category.new(name: 'Music')
      product = Product.new(name: 'Guitar', price: 209.49, quantity: 5, category: category)
      expect{product.save}.to change{Product.count}.by(1)
    end 

    it "returns missing name error if the name field is nil" do
      category = Category.new(name: 'Music')
      product = Product.new(price: 29.99, quantity: 5, category: category)
      product.save
      expect(product).to_not be_valid
      expect(product.errors.messages[:name]).to eq ["can't be blank"]
    end

    it "returns missing price error if the price field is nil" do
      category = Category.new(name: 'Music')
      product = Product.new(name: 'Guitar', quantity: 5, category: category)
      product.save
      expect(product).to_not be_valid
      expect(product.errors.messages[:price]).to eq ["is not a number", "can't be blank"]
    end

    it "returns missing quantity error if the quantity field is nil" do
      category = Category.new(name: 'Music')
      product = Product.new(name: 'Guitar', price: 29.99, category: category)
      product.save
      expect(product).to_not be_valid
      expect(product.errors.messages[:quantity]).to eq ["can't be blank"]
    end

    it "returns missing category error if the category field is nil" do
      product = Product.new(name: 'guitar', price: 29.99, quantity: 5)
      product.save
      expect(product).to_not be_valid
      expect(product.errors.messages[:category]).to eq ["can't be blank"]
    end

  end

end