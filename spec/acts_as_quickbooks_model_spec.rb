require 'spec_helper'

describe ActsAsQuickbooksModel do
  it 'has a version number' do
    expect(ActsAsQuickbooksModel::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end

# class ActsAsQuickBooksModelTest < Test::Unit::TestCase
#   def test_assign_attributes_from_qbxml_if_matching_attributes_exist_on_model
#     customer = Customer.new(qbxml: CUSTOMER_RET, foo: 'bar')
#     assert_equal '123', customer.list_id
#     assert_equal 'Foo', customer.name
#     assert_equal '456', customer.parent_ref_list_id
#     assert_equal 'bar', customer.foo
#   end
#
#   def test_support_alias_attributes_on_model
#     customer = Customer.new(qbxml: CUSTOMER_RET)
#     assert customer.active?
#   end
#
#   def test_support_overriding_default_model_type
#     payment = Payment.create!(qbxml: PAYMENT_RET)
#     assert_equal '123', payment.txn_id
#   end
#
#   def test_build_has_many_associations_by_has_many_class_name
#     invoice = Invoice.create!(qbxml: INVOICE_RET)
#     assert_equal '123', invoice.txn_id
#
#     # invoice_lines
#     assert_equal 2, invoice.invoice_lines.count
#
#     line = invoice.invoice_lines[0]
#     assert_equal invoice.id,  line.invoice_id
#     assert_equal '456', line.txn_line_id
#     assert_equal '789', line.item_ref_list_id
#
#     line = invoice.invoice_lines[1]
#     assert_equal invoice.id, line.invoice_id
#     assert_equal '012', line.txn_line_id
#     assert_equal '567', line.item_ref_list_id
#
#     # invoice_line_groups
#     group = invoice.invoice_line_groups[0]
#     assert_equal 1, invoice.invoice_line_groups.count
#     assert_equal invoice.id, group.invoice_id
#     assert_equal '321', group.txn_line_id
#     assert_equal '987', group.item_group_ref_list_id
#
#     # invoice_line_group invoice_lines
#     assert_equal 1, invoice.invoice_line_groups[0].lines.count
#     group_line = invoice.invoice_line_groups[0].lines[0]
#     assert_equal '345', group_line.txn_line_id
#     assert_equal '789', group_line.item_ref_list_id
#   end
#
#   def test_should_build_has_many_associations_by_has_many_name
#     tax1 = Item.create! list_id: '8000002A-1189440679'
#     tax2 = Item.create! list_id: '80000029-1189440679'
#
#     sales_tax_group = Item.create!(qbxml: SALES_TAX_GROUP_RET)
#     assert_equal '80000030-1189440679', sales_tax_group.list_id
#
#     linked_item1 = sales_tax_group.linked_items[0]
#     linked_item2 = sales_tax_group.linked_items[1]
#
#     assert_equal '8000002A-1189440679', linked_item1.list_id
#     assert_equal '80000029-1189440679', linked_item2.list_id
#   end
#
#   def should_allow_polymorphic_support_for_models_that_declare_support_for_multiple_qb_model_types
#     inventory_product = Product.create!(qbxml: ITEM_INVENTORY_RET)
#     assert_equal '123', inventory_product.list_id
#     assert_equal 1, inventory_product.purchase_cost
#
#     non_inventory_product = Product.create!(qbxml: ITEM_NON_INVENTORY_RET)
#     assert_equal '234', non_inventory_product.list_id
#     assert_equal '2', non_inventory_product.manufacturer_part_number
#
#     other_charge_product = Product.create!(qbxml: ITEM_OTHER_CHARGE_RET)
#     assert_equal '345', other_charge_product.list_id
#     assert_equal 'foo', other_charge_product.special_item_type
#   end
#
#   def test_not_attempt_to_assign_a_has_many_if_an_identical_node_appears_as_a_QB_element
#     # Example: Customer has_many notes
#     # CustomerRet sends back <Notes> node
#     customer = Customer.create!(qbxml: CUSTOMER_RET)
#     assert customer.notes.empty?
#   end
#
#   def test_convert_xml_entities
#     qbxml = <<-XML
#       <CustomerRet>
#         <ListID>123</ListID>
#         <Name>foo &amp; bar</Name>
#         <IsActive>true</IsActive>
#         <ParentRef>
#           <ListID>456</ListID>
#         </ParentRef>
#         <Contact>1&quot; foo</Contact>
#       </CustomerRet>
#     XML
#     customer = Customer.create!(qbxml: qbxml)
#     assert_equal 'foo & bar', customer.name
#     assert_equal '1" foo', customer.contact
#   end
# end
