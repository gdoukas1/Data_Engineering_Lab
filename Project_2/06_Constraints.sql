USE CataschevasticaDW
GO

--Create relationships between Dimension Tables and Fact Table

ALTER TABLE FactSales
ADD CONSTRAINT FK_employee FOREIGN KEY(EmployeeKey) REFERENCES DimEmployee(EmployeeKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_customer FOREIGN KEY(CustomerKey) REFERENCES DimCustomer(CustomerKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_product FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey)


--These ones require the creation of the DimDate table before being executed

ALTER TABLE FactSales
ADD CONSTRAINT FK_orderDate FOREIGN KEY(OrderDateKey) REFERENCES DimDate(DateKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_shippedDate FOREIGN KEY(ShippedDateKey) REFERENCES DimDate(DateKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_recievedDate FOREIGN KEY(RecievedDateKey) REFERENCES DimDate(DateKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_cancellationDate FOREIGN KEY(CancellationDateKey) REFERENCES DimDate(DateKey)
--------------------------------------------------


ALTER TABLE TempFactSales
ADD CONSTRAINT FK_employeeTemp FOREIGN KEY(EmployeeKey) REFERENCES DimEmployee(EmployeeKey)

ALTER TABLE TempFactSales
ADD CONSTRAINT FK_customerTemp FOREIGN KEY(CustomerKey) REFERENCES DimCustomer(CustomerKey)

ALTER TABLE TempFactSales
ADD CONSTRAINT FK_productTemp FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey)


--These ones require the creation of the DimDate table before being executed

ALTER TABLE TempFactSales
ADD CONSTRAINT FK_orderDateTemp FOREIGN KEY(OrderDateKey) REFERENCES DimDate(DateKey)


---------------------------------------------

ALTER TABLE FactProduction
ADD CONSTRAINT FK_employeeProd FOREIGN KEY(EmployeeKey) REFERENCES DimEmployee(EmployeeKey)

ALTER TABLE FactProduction
ADD CONSTRAINT FK_materialProd FOREIGN KEY(MaterialKey) REFERENCES DimMaterial(MaterialKey)

ALTER TABLE FactProduction
ADD CONSTRAINT FK_productProd FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey)


--These ones require the creation of the DimDate table before being executed

ALTER TABLE FactProduction
ADD CONSTRAINT FK_productionStartedDate FOREIGN KEY(ProductionStartDateKey) REFERENCES DimDate(DateKey)

ALTER TABLE FactProduction
ADD CONSTRAINT FK_productionEndDate FOREIGN KEY(ProductionEndDateKey) REFERENCES DimDate(DateKey)


