class Customer < ActiveRecord::Base
  acts_as_quickbooks_model
  has_many :notes
  alias_attribute :is_active, :active
end

class Note < ActiveRecord::Base
  belongs_to :customer
end

class Payment < ActiveRecord::Base
  acts_as_quickbooks_model 'ReceivePayment'
end

class Invoice < ActiveRecord::Base
  acts_as_quickbooks_model
  has_many :invoice_lines
  has_many :invoice_line_groups
end

class InvoiceLine < ActiveRecord::Base
  acts_as_quickbooks_model
  belongs_to :invoice
  belongs_to :invoice_line_group
end

class InvoiceLineGroup < ActiveRecord::Base
  acts_as_quickbooks_model
  belongs_to :invoice
  has_many :lines, class_name: 'InvoiceLine'
end

class Product < ActiveRecord::Base
  acts_as_quickbooks_model 'ItemInventory', 'ItemNonInventory', 'ItemOtherCharge'
end

class Item < ActiveRecord::Base
  acts_as_quickbooks_model 'ItemSalesTaxGroup'
  has_many :linked_items
  has_many :item_sales_taxs, class_name: 'LinkedItem'
end

class LinkedItem < ActiveRecord::Base
  acts_as_quickbooks_model 'ItemSalesTax'
  belongs_to :item
end
