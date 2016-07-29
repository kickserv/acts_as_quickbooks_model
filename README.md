# ActsAsQuickbooksModel

[![Build Status](https://travis-ci.org/kickserv/acts_as_quickbooks_model.svg?branch=master)](https://travis-ci.org/kickserv/acts_as_quickbooks_model)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_quickbooks_model'
```

And then execute:

    `$ bundle`

Or install it yourself as:

    `$ gem install acts_as_quickbooks_model`

## Usage

### Introduction ###

This plugin simplifies the parsing of qbXML messages into ActiveRecord model attributes.

### Usage ###

```ruby
    class Customer < ActiveRecord::Base
      acts_as_quickbooks_model
    end

    xml = <<-XML
    <CustomerRet>
      <ListID>150000-933272658</ListID>
      <Name>Abercrombie, Kristy</Name>
      <BillAddress>
        <Addr1>Kristy Abercrombie</Addr1>
        <Addr2>5647 Cypress Hill Rd</Addr2>
        <City>Bayshore</City>
        <State>CA</State>
        <PostalCode>94326</PostalCode>
      </BillAddress>
    </CustomerRet>
    XML

    customer = Customer.new(:qbxml => xml)
    customer.list_id # => "150000-933272658"
    customer.name # => "Abercrombie, Kristy"
    customer.bill_address_city # => "Bayshore"
    ...

### Auto-builds has_many associations ###

    class Invoice < ActiveRecord::Base
      acts_as_quickbooks_model
      has_many :invoice_lines
      has_many :invoice_line_groups
    end
    class InvoiceLine < ActiveRecord::Base
      acts_as_quickbooks_model
      belongs_to :invoice
    end
    class InvoiceLineGroup < ActiveRecord::Base
      acts_as_quickbooks_model
      belongs_to :invoice
    end

    xml = <<-XML
    <InvoiceRet>
      <TxnID>123</TxnID>
      <InvoiceLineRet>
        <TxnLineID>456</TxnLineID>
        <ItemRef>
          <ListID>789</ListID>
        </ItemRef>
      </InvoiceLineRet>
      <InvoiceLineRet>
        <TxnLineID>012</TxnLineID>
        <ItemRef>
          <ListID>567</ListID>
        </ItemRef>
      </InvoiceLineRet>
      <InvoiceLineGroupRet>
        <TxnLineID>321</TxnLineID>
        <ItemGroupRef>
          <ListID>987</ListID>
        </ItemGroupRef>
      </InvoiceLineGroupRet>
    </InvoiceRet>
    XML

    invoice = Invoice.create(:qbxml => xml)
    invoice.txn_id # => "123"
    invoice.invoice_lines.count # => 2
    invoice.invoice_line_groups.count # => 1
    invoice.invoice_lines.first.txn_line_id # => "456"
    invoice.invoice_line_groups.first.txn_line_id # => "321"
    ...
```

### Tested Ruby Versions ###

* 1.8.6
* 1.8.7
* 1.9.1
* 2.3.1

### References ###

[QuickBooks SDK Reference](http://developer.intuit.com/qbsdk-current/Common/newOSR/index.html)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/acts_as_quickbooks_model.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
