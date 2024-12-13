-- Tạo CSDL
CREATE DATABASE BKShop

-- Sử dụng CSDL
USE BKShop

-- Tạo bảng
CREATE TABLE Customers (
	CustomerID int identity(1, 1) PRIMARY KEY,
	Name varchar(50) not null,
	Gender bit null,
	Phone varchar(12) null,
	[Address] varchar(100)
)

CREATE TABLE Category (
	CategoryID int identity(1, 1) PRIMARY KEY,
	CategoryName varchar(30) not null,
)

CREATE TABLE Product (
	ProductID int identity(1, 1),
	ProductName varchar(100),
	CategoryID int,
	UnitPrice float,
	UnitsInStock int,
	UnitsOnOrder int,
	ReorderLevel int,
	PRIMARY KEY (ProductID),
	CONSTRAINT fk_CategoryProduct FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID)
)

CREATE TABLE Orders (
	OrderID int identity(1, 1),
	CustomerID int,
	OrderDate date,
	ShippedDate date,
	ShipName varchar(50),
	ShipPhone varchar(12),
	ShipAddress varchar(100),
	PRIMARY KEY (OrderID),
	CONSTRAINT fk_CustomerOrder FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderDetails (
	OrderDetailID int identity(1, 1),
	OrderID int,
	ProductID int,
	UnitPrice float,
	Quantity int,
	Discount float
)


CREATE TABLE Shipment (
	ShipmentID int identity(1, 1),
	OrderID int,
	ShipName varchar(50),
	ShipmentDate date
)

-- Thêm ràng buộc khóa chính và khóa ngoại cho bảng OrderDetails
ALTER TABLE OrderDetails
ADD PRIMARY KEY (OrderDetailID)

ALTER TABLE OrderDetails
ADD CONSTRAINT fk_orderdetail FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)

ALTER TABLE OrderDetails
ADD CONSTRAINT fk_productdetail FOREIGN KEY (ProductID) REFERENCES Product(ProductID)

-- Thêm ràng buộc khóa chính và khóa ngoại cho bảng Shipment
ALTER TABLE Shipment
ADD CONSTRAINT pk_shipment PRIMARY KEY (ShipmentID)

ALTER TABLE Shipment
ADD CONSTRAINT fk_ordership FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)

-- Xóa ràng buộc
ALTER TABLE Shipment
DROP CONSTRAINT fk_ordership

-- Sửa cột tên sản phẩm thành không được để trống
ALTER TABLE Product
ALTER COLUMN ProductName varchar(50) not null

-- Thêm cột vào bảng
ALTER TABLE Orders 
ADD [status] tinyint

-- Xóa cột trong bảng
ALTER TABLE Orders 
DROP COLUMN ShippedDate

-- Xóa bảng
DROP TABLE Category -- không xóa được do có bảng tham chiếu tới FK
DROP TABLE Shipment -- xóa được

-- Xóa CSDL
DROP DATABASE BKShop