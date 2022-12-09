-- 2g
-- Customer details: custid, name, phone, address
-- Order details: orderid, line items
-- Payment details: total for all order line items, tax, shipping fee, discount, grand total
DROP PROCEDURE showItemOrders;
CREATE PROCEDURE showItemOrders(
	custOrderID int )
AS
	running_total CustOrder.grandTotal%type;
BEGIN
	running_total := computeTotal(@custOrderID);
	UPDATE CustOrder
		SET grandTotal = running_total + shippingFee WHERE CustOrder.orderID = @custOrderID;
	SELECT * FROM OrderLineItem WHERE OrderLineItem.orderID = @custOrderID;
	SELECT grandTotal FROM CustOrder WHERE CustOrder.orderID = @custOrderID;
END;
/
