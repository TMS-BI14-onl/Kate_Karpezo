/*
2.	Решите на базе данных AdventureWorks2017 следующие задачи (для поиска ключей можно использовать схему БД ). 

a)	Вывести список цен в виде текстового комментария, основанного на диапазоне цен для продукта:
a.	StandardCost равен 0 или не определен – ‘Not for sale’  
b.	StandardCost больше 0, но меньше 100 – ‘<$100’ 
c.	StandardCost больше или равно 100, но меньше 500 - ‘ <$500' 
d.	Иначе - ‘ >= $500'
Вывести имя продукта и новое поле PriceRange.
*/

	USE AdventureWorks2017
	SELECT Name,
	CASE
		WHEN [StandardCost] = 0 OR [StandardCost] IS NULL THEN 'Not for sale'
		WHEN [StandardCost] > 0 AND [StandardCost] <100 THEN '<$100'
		WHEN [StandardCost] >=100 AND [StandardCost] <500 THEN '<$500'
		ELSE '>= $500'
		END AS PriceRange
	FROM [Production].[Product]


/*b)	Найти ProductID, BusinessEntityID и имя поставщика продукции из Purchasing.ProductVendor и Purchasing.Vendor, где StandardPrice больше $10. 
Также в имени вендора должна присутствовать (вне зависимости от положения) буква X или имя должно начинаться на букву N.
Ответ:
*/
	USE AdventureWorks2017
	SELECT pv.ProductID, pv.BusinessEntityID, v.Name
	FROM Purchasing.ProductVendor pv 
	LEFT JOIN  Purchasing.Vendor v
	ON pv.BusinessEntityID = v.BusinessEntityID
	WHERE StandardPrice >10 
	AND Name LIKE '%X%' 
	OR Name LIKE 'n%'

/*
c)	Найти имена всех вендоров, продукция которых не продавалась за всё время. Необходимо использовать следующую схему соединения таблиц Purchasing.ProductVendor и Purchasing.Vendor:

*/
	USE AdventureWorks2017
	SELECT v.Name
	FROM Purchasing.Vendor v 
	LEFT JOIN  Purchasing.ProductVendor pv
	ON v.BusinessEntityID = pv.BusinessEntityID
	WHERE pv.BusinessEntityID IS NULL

/*
1.	Решите на базе данных AdventureWorks2017 следующие задачи. 

a)	Выведите названия продуктов и их цену, модель которых начинается на ‘LL’. Таблицы [Production].[ProductModel] и [Production].[Product].

*/
	USE AdventureWorks2017
	SELECT p.Name, p.ListPrice
	FROM [Production].[Product] p
	LEFT JOIN [Production].[ProductModel] m
	ON p.ProductModelID = m.ProductModelID
	WHERE m.Name LIKE 'LL%'
	

-- b)	Выведите имена всех вендоров [Purchasing].[Vendor] и имена магазинов [Sales].[Store] одним списком в отсортированном порядке по алфавиту и без дубликатов.

	USE AdventureWorks2017
	SELECT Name
	FROM [Purchasing].[Vendor]
	UNION
	SELECT Name
	FROM [Sales].[Store]
	ORDER BY Name

-- c)	Найдите имена продуктов, на которых действовало больше, чем 1 специальное предложение. Таблицы [Sales].[SpecialOffer], [Sales].[SpecialOfferProduct], [Production].[Product].

	USE AdventureWorks2017
	SELECT pp.Name, COUNT(SpecialOfferID) AS 'cnt SpecialOffer'
	FROM [Sales].[SpecialOfferProduct] so
	LEFT JOIN [Production].[Product] pp
	ON pp.ProductID = so.ProductID 
	GROUP BY Name
	HAVING COUNT(SpecialOfferID)>1
	

