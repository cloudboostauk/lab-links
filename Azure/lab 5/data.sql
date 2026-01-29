-- Add sample customers
INSERT INTO Customers (CustomerName, Email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Bob Johnson', 'bob@example.com');

-- Add sample products
INSERT INTO Products (ProductName, Price, StockQuantity) VALUES
('Laptop', 999.99, 50),
('Mouse', 29.99, 200),
('Keyboard', 79.99, 150),
('Monitor', 299.99, 75);

-- Verify data
SELECT * FROM Customers;
SELECT * FROM Products;