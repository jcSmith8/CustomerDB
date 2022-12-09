-- 2e
-- updates shippingDate within CustOrder table
DROP PROCEDURE setShippingDate;
CREATE PROCEDURE setShippingDate (
	this_orderID int,
	this_shippedDate CustOrder.shippedDate%type )
IS
BEGIN
	UPDATE CustOrder
		SET CustOrder.shippedDate = this_shippedDate WHERE CustOrder.orderID = this_orderID;
END;
/
