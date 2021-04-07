require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They add a product to cart and cart increases by one" do
    visit root_path
    find('.product', match: :first).click_button('Add')

    # DEBUG
    # save_screenshot
    expect(page).to have_text 'My Cart (1)', count: 1
  end
end 