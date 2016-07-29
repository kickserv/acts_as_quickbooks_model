CUSTOMER_RET = <<-XML
<CustomerRet>
  <ListID>123</ListID>
  <Name>Foo</Name>
  <IsActive>true</IsActive>
  <ParentRef>
    <ListID>456</ListID>
  </ParentRef>
  <Notes>foo bar</Notes>
</CustomerRet>
XML

PAYMENT_RET = <<-XML
<ReceivePaymentRet>
  <TxnID>123</TxnID>
</ReceivePaymentRet>
XML

INVOICE_RET = <<-XML
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
		<InvoiceLineRet>
      <TxnLineID>345</TxnLineID>
      <ItemRef>
        <ListID>789</ListID>
      </ItemRef>
    </InvoiceLineRet>
	</InvoiceLineGroupRet>
</InvoiceRet>
XML

ITEM_INVENTORY_RET = <<-XML
<ItemInventoryRet>
  <ListID>123</ListID>
  <PurchaseCost>1</PurchaseCost>
</ItemInventoryRet>
XML

ITEM_NON_INVENTORY_RET = <<-XML
<ItemNonInventoryRet>
  <ListID>234</ListID>
  <ManufacturerPartNumber>2</ManufacturerPartNumber>
</ItemNonInventoryRet>
XML

ITEM_OTHER_CHARGE_RET = <<-XML
<ItemOtherChargeRet>
  <ListID>345</ListID>
  <SpecialItemType>foo</SpecialItemType>
</ItemOtherChargeRet>
XML

SALES_TAX_GROUP_RET = <<-XML
<ItemSalesTaxGroupRet>
  <ListID>80000030-1189440679</ListID>
  <TimeCreated>2007-09-10T09:11:19-08:00</TimeCreated>
  <TimeModified>2007-09-10T09:11:19-08:00</TimeModified>
  <EditSequence>1189440679</EditSequence>
  <Name>San Thomas Group</Name>
  <IsActive>true</IsActive>
  <ItemDesc>Sales Tax - San Thomas County</ItemDesc>
  <ItemSalesTaxRef>
    <ListID>8000002A-1189440679</ListID>
    <FullName>County, San Thomas</FullName>
  </ItemSalesTaxRef>
  <ItemSalesTaxRef>
    <ListID>80000029-1189440679</ListID>
    <FullName>Assessment</FullName>
  </ItemSalesTaxRef>
</ItemSalesTaxGroupRet>
XML
