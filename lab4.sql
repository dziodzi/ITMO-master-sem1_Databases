# Найти номер покупателя и чек с наибольшим количеством товаров (по наименованию) для каждого покупателя

WITH OrderItemCount AS (
    SELECT
        sod.SalesOrderID,
        soh.CustomerID,
        COUNT(sod.SalesOrderDetailID) AS ItemCount
    FROM 
        Sales.SalesOrderDetail sod
    JOIN 
        Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
    GROUP BY 
        sod.SalesOrderID, soh.CustomerID
)
SELECT 
    oic.CustomerID,
    oic.SalesOrderID,
    oic.ItemCount
FROM 
    OrderItemCount oic
WHERE 
    oic.ItemCount = (
        SELECT MAX(ItemCount)
        FROM OrderItemCount oic2
        WHERE oic2.CustomerID = oic.CustomerID
    );
