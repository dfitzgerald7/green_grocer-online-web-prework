require "pry"
def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hash|
    #binding.pry
    if new_hash[hash.keys[0]] == nil 
      
      new_hash[hash.keys[0]] = hash.values[0]
      new_hash[hash.keys[0]][:count] = 1 
    else 
      new_hash[hash.keys[0]][:count] += 1
    end
  end 
  new_hash
end

def apply_coupons(cart, coupons)
  coupon_count = {}
  coupons.each do |coupon_hash|
    #binding.pry
    if cart.keys.include?(coupon_hash[:item])
      cart[coupon_hash[:item]][:count] -= coupon_hash[:num]
      #binding.pry
      if coupon_count[coupon_hash[:item]] == nil 
        coupon_count[coupon_hash[:item]] = 1
      else 
        coupon_count[coupon_hash[:item]] += 1
      end 
      cart["#{coupon_hash[:item]} W/COUPON"] = {price: coupon_hash[:cost], clearance: cart[coupon_hash[:item]][:clearance], count: coupon_count[coupon_hash[:item]]}
    end 
  end 
  #binding.pry
  cart 

end

def apply_clearance(cart)
  cart.collect do |item|
    #binding.pry
    if item[1][:clearance] == true 
      item[1][:price] = (item[1][:price]*0.8).round(1)
    end 
  end 
  cart
end

def checkout(cart, coupons)
  
  cart2 = consolidate_cart(cart)
  binding.pry
  cart3 = apply_coupons(cart2, coupons)
  final_cart = apply_clearance(cart3)
  final_price = 0
  
  final_cart.each do |item, hash|
    final_price += hash[:price]
  end 

  if final_price > 100 
    return final_price * 0.9 
  end 
  final_price
end
