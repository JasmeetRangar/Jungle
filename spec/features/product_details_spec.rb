require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name: Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They click on a product and navigates them to the detail page" do
    visit root_path
    find('.product', match: :first).find_link('Details »').click

    expect(page).to have_css 'section.products-show', count: 1
    
    # DEGUB
    # save_screenshot
    # puts page.html
  end

end