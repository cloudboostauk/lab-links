-- Check the order
SELECT * FROM Orders;

-- Check order details
SELECT 
    o.OrderID,
    c.CustomerName,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- Check updated stock
SELECT ProductName, StockQuantity FROM Products;