class Want < ActiveRecord::Base

  belongs_to :user
  has_many :products

  def self.checking
    puts "Checking shopstyle from model!"

    # Loop through the list of wants
    wants = Want.all
    wants.each do |want|
       # For each want, call the api for the specific product - HTTParty.get(API URL)
      client = HTTParty.get("http://api.shopstyle.com/api/v2/products/#{want.product_id}?pid=uid5001-30368749-95")
      # create variable to store current price on shopstyle
      # Find the current Shopstyle API price for the product
      currentShopstylePrice = client["priceLabel"]
      if (currentShopstylePrice == "Sold Out")
        p "this item is sold out"
      elsif (currentShopstylePrice.to_i < want.max_price)
        p "BUY BUY BUY"
        want.fulfilled = true
        p "Fulfilled by checking method"
      else
        p "were working on it"
      end


      p "Product id: " + want.product_id.to_s
      p "Max price: " + want.max_price.to_s
      p "Fulfilled: " + want.fulfilled.to_s
      p "*" * 100
    end

  # Checking the shopstyle API

  ### Loop through the list of wants
  ### For each want, call the api for the specific product
  ### HTTParty.get(API URL)
  # Find the current Shopstyle API price for the product
  # If the current Shopstyle price is less than the max_price for the want
  # then update the want below_max to true



  def notifications

  end

  end
end
