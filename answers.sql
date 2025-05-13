CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Populate the new table from the original table, splitting the Products column.
INSERT INTO OrderProducts_1NF (OrderID, CustomerName, Product)
SELECT
    OrderID,
    CustomerName,
    TRIM(value) AS Product  -- Trim to remove leading/trailing spaces
FROM Orders  -- Assuming the original table is named "Orders"
CROSS APPLY STRING_SPLIT(Products, ',');

-- Drop the original table (optional, if you want to replace it).
-- DROP TABLE Orders;

-- If you want to rename the new table to the original table name
-- RENAME TABLE OrderProducts_1NF TO Orders;

-- Select all data from the new table to show the result
SELECT * FROM OrderProducts_1NF;

# Question 2

-- Create a new table for Orders (OrderID, CustomerName)
CREATE TABLE Orders2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Populate the Orders table with distinct OrderID and CustomerName pairs
INSERT INTO Orders2NF (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create a new table for OrderProducts (OrderID, Product, Quantity)
CREATE TABLE OrderProducts2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),  -- Composite primary key
    FOREIGN KEY (OrderID) REFERENCES Orders2NF(OrderID) -- Foreign key referencing Orders2NF
);

-- Populate the OrderProducts table
INSERT INTO OrderProducts2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Drop the original table (optional)
-- DROP TABLE OrderDetails;

-- Optional: Rename tables
-- RENAME TABLE Orders2NF TO Orders;
-- RENAME TABLE OrderProducts2NF TO OrderDetails;

-- Select all data from the new tables to show the result
SELECT * FROM Orders2NF;
SELECT * FROM OrderProducts2NF;

