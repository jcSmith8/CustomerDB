-- 	Params: Check if there is stock available
--		Check membership status
--		set shippedDate -> NULL
--		Each item references a CustOrder.orderID

DROP PROCEDURE createOrderLineItem;
CREATE PROCEDURE createOrderLineItem (
	custOrderID int, 
	this_itemID int,
       	customerID int,
       	quantityOrdered int )
AS
	customerType Customer.CustType%type;
	copyStock StoreItem.numCopies%type;
	itemCost StoreItem.price%type;
BEGIN
	SELECT custType into customerType FROM Customer WHERE Customer.custID = customerID;
	SELECT numCopies INTO copyStock FROM StoreItem WHERE StoreItem.itemID = this_itemID;
	SELECT price INTO itemCost FROM StoreItem WHERE StoreItem.itemID = this_itemID;
	-- Check Stock from StoreItem and update numCopies accordingly
	IF quantityOrdered > copyStock THEN
		dbms_output.put_line('Not enough copies');
		RETURN;
	ELSE
		UPDATE StoreItem
			SET StoreItem.numCopies = copyStock - quantityOrdered WHERE StoreItem.itemID = this_itemID;
	END IF;
	IF customerType = 'Gold' THEN
		UPDATE CustOrder
			SET CustOrder.shippingFee = '0.00' WHERE CustOrder.orderID = custOrderID;
	ELSE
		UPDATE CustOrder
			SET CustOrder.shippingFee = '10.00' WHERE CustOrder.orderID = custOrderID;
	END IF;
	-- Check custType from Customer and update shippingFee
	INSERT INTO OrderLineItem(lineID, orderID, itemID, quantity, lineprice) VALUES (line_seq.nextval, custOrderID, this_itemID, quantityOrdered, (quantityOrdered * itemCost));
END;
/
