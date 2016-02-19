class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# what is wrong with changing attr_reader to attr_accessor for quantity?

# the methods will work the same, but it will affect how the data can be changed
# you will be able to change the quantity by calling instance.quantity,
# instead of using the intended instance.update_quantity method
# if there are intended safeguards, they can be circumvented