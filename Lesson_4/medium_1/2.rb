# class InvoiceEntry
#   attr_reader :quantity, :product_name

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count)
#     # prevent negative quantities from being set
#     quantity = updated_count if updated_count >= 0
#   end
# end

# where is the mistake?
# there is no setter method for quantity

# can do 2 things
# 1) reference the @quantity instance variable in the update_quanitiy method

class InvoiceEntry
  attr_reader :product_name, :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0 
  end
end

purchase = InvoiceEntry.new('acme', 3)
p purchase.quantity

purchase.update_quantity(5)
p purchase.quantity

# 2) add attr_accessor for quantity and reference self.quantity in the update_quanitiy method

class InvoiceEntry
  attr_reader :product_name
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0 
  end
end

purchase = InvoiceEntry.new('acme', 3)
p purchase.quantity

purchase.update_quantity(5)
p purchase.quantity

