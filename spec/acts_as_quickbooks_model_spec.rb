require 'spec_helper'

describe ActsAsQuickbooksModel do
  it 'has a version number' do
    expect(ActsAsQuickbooksModel::VERSION).not_to be nil
  end

  describe ".configure" do
    context "given options" do
      let(:config) { described_class.configuration }

      it "sets the options" do
        described_class.configure do |c|
          c.doc_path = 'foo'
          c.migrations_path = 'bar'
        end

        expect(config.doc_path).to eq('foo')
        expect(config.migrations_path).to eq('bar')
      end
    end
  end

  let(:customer) { Customer.new(qbxml: CUSTOMER_RET, foo: 'bar') }
  let(:payment) { Payment.create!(qbxml: PAYMENT_RET) }
  let(:invoice) { Invoice.create!(qbxml: INVOICE_RET) }

  describe 'qbxml=' do
    it 'assigns if matching attrs exist on model' do
      expect(customer.list_id).to eq('123')
      expect(customer.name).to eq('Foo')
      expect(customer.parent_ref_list_id).to eq('456')
      expect(customer.foo).to eq('bar')
    end

    it 'aliases bool attributes on model' do
      expect(customer).to be_active
    end

    it 'allows overriding default model type' do
      expect(payment.txn_id).to eq('123')
    end

    it 'builds has_many associations by class name' do
      expect(invoice.txn_id).to eq('123')

      expect(invoice.invoice_lines.count).to eq(2)

      invoice.invoice_lines[0].tap do |line|
        expect(line.invoice_id).to eq(invoice.id)
        expect(line.txn_line_id).to eq('456')
        expect(line.item_ref_list_id).to eq('789')
      end

      invoice.invoice_lines[1].tap do |line|
        expect(line.invoice_id).to eq(invoice.id)
        expect(line.txn_line_id).to eq('012')
        expect(line.item_ref_list_id).to eq('567')
      end

      expect(invoice.invoice_line_groups.count).to eq(1)

      invoice.invoice_line_groups[0].tap do |group|
        expect(group.invoice_id).to eq(invoice.id)
        expect(group.txn_line_id).to eq('321')
        expect(group.item_group_ref_list_id).to eq('987')

        expect(group.lines.count).to eq(1)

        invoice.invoice_line_groups[0].lines[0].tap do |group_line|
          expect(group_line.txn_line_id).to eq('345')
          expect(group_line.item_ref_list_id).to eq('789')
        end
      end
    end

    it 'builds has_many associations by association name' do
      tax1 = Item.create! list_id: '8000002A-1189440679'
      tax2 = Item.create! list_id: '80000029-1189440679'
      sales_tax_group = Item.create!(qbxml: SALES_TAX_GROUP_RET)

      expect(sales_tax_group.list_id).to eq('80000030-1189440679')

      linked_item1 = sales_tax_group.linked_items[0]
      linked_item2 = sales_tax_group.linked_items[1]

      expect(linked_item1.list_id).to eq('8000002A-1189440679')
      expect(linked_item2.list_id).to eq('80000029-1189440679')
    end

    it 'supports polymorphic model mappings' do
      Product.create!(qbxml: ITEM_INVENTORY_RET).tap do |inventory_product|
        expect(inventory_product.list_id).to eq('123')
        expect(inventory_product.purchase_cost).to eq(1)
      end

      Product.create!(qbxml: ITEM_NON_INVENTORY_RET).tap do |non_inventory_product|
        expect(non_inventory_product.list_id).to eq('234')
        expect(non_inventory_product.manufacturer_part_number).to eq('2')
      end

      Product.create!(qbxml: ITEM_OTHER_CHARGE_RET).tap do |other_charge_product|
        expect(other_charge_product.list_id).to eq('345')
        expect(other_charge_product.special_item_type).to eq('foo')
      end
    end

    it 'will not assign a single attribute value to a has_many' do
      # Example: Customer has_many notes
      # CustomerRet sends back <Notes> node
      expect(customer.notes).to be_empty
    end

    it 'translates XML entities' do
      qbxml = <<-XML
        <CustomerRet>
          <ListID>123</ListID>
          <Name>foo &amp; bar</Name>
          <IsActive>true</IsActive>
          <ParentRef>
            <ListID>456</ListID>
          </ParentRef>
          <Contact>1&quot; foo</Contact>
        </CustomerRet>
      XML

      customer = Customer.create!(qbxml: qbxml)
      expect(customer.name).to eq('foo & bar')
      expect(customer.contact).to eq('1" foo')
    end
  end
end
