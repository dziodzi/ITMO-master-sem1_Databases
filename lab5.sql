# Найти для каждого чека его номер, количество категорий и подкатегорий, товары из которых есть в чеке

WITH 
    ReceiptItemsWithCategories AS (
        SELECT 
            soh.SalesOrderId AS ReceiptID, 
            psc.ProductCategoryID AS CategoryID, 
            p.ProductSubcategoryID AS SubcategoryID
        FROM 
            [AdventureWorks2017].[Sales].[SalesOrderHeader] AS soh
        JOIN 
            [AdventureWorks2017].[Sales].[SalesOrderDetail] AS sod 
            ON soh.SalesOrderId = sod.SalesOrderId
        JOIN 
            [AdventureWorks2017].[Production].[Product] AS p 
            ON sod.ProductID = p.ProductID
        JOIN 
            [AdventureWorks2017].[Production].[ProductSubcategory] AS psc 
            ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    )

SELECT 
    ReceiptID,
    COUNT(DISTINCT CategoryID) AS CategoryCount,
    COUNT(DISTINCT SubcategoryID) AS SubcategoryCount
FROM 
    ReceiptItemsWithCategories
GROUP BY 
    ReceiptID
ORDER BY 
    ReceiptID;
