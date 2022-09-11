/*
2.	������ �� ���� ������ AdventureWorks2017 ��������� ������ (��� ������ ������ ����� ������������ ����� �� ). 

a)	������� ������ ��� � ���� ���������� �����������, ����������� �� ��������� ��� ��� ��������:
a.	StandardCost ����� 0 ��� �� ��������� � �Not for sale�  
b.	StandardCost ������ 0, �� ������ 100 � �<$100� 
c.	StandardCost ������ ��� ����� 100, �� ������ 500 - � <$500' 
d.	����� - � >= $500'
������� ��� �������� � ����� ���� PriceRange.
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


/*b)	����� ProductID, BusinessEntityID � ��� ���������� ��������� �� Purchasing.ProductVendor � Purchasing.Vendor, ��� StandardPrice ������ $10. 
����� � ����� ������� ������ �������������� (��� ����������� �� ���������) ����� X ��� ��� ������ ���������� �� ����� N.
�����:
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
c)	����� ����� ���� ��������, ��������� ������� �� ����������� �� �� �����. ���������� ������������ ��������� ����� ���������� ������ Purchasing.ProductVendor � Purchasing.Vendor:

*/
	USE AdventureWorks2017
	SELECT v.Name
	FROM Purchasing.Vendor v 
	LEFT JOIN  Purchasing.ProductVendor pv
	ON v.BusinessEntityID = pv.BusinessEntityID
	WHERE pv.BusinessEntityID IS NULL

/*
1.	������ �� ���� ������ AdventureWorks2017 ��������� ������. 

a)	�������� �������� ��������� � �� ����, ������ ������� ���������� �� �LL�. ������� [Production].[ProductModel] � [Production].[Product].

*/
	USE AdventureWorks2017
	SELECT p.Name, p.ListPrice
	FROM [Production].[Product] p
	LEFT JOIN [Production].[ProductModel] m
	ON p.ProductModelID = m.ProductModelID
	WHERE m.Name LIKE 'LL%'
	

-- b)	�������� ����� ���� �������� [Purchasing].[Vendor] � ����� ��������� [Sales].[Store] ����� ������� � ��������������� ������� �� �������� � ��� ����������.

	USE AdventureWorks2017
	SELECT Name
	FROM [Purchasing].[Vendor]
	UNION
	SELECT Name
	FROM [Sales].[Store]
	ORDER BY Name

-- c)	������� ����� ���������, �� ������� ����������� ������, ��� 1 ����������� �����������. ������� [Sales].[SpecialOffer], [Sales].[SpecialOfferProduct], [Production].[Product].

	USE AdventureWorks2017
	SELECT pp.Name, COUNT(SpecialOfferID) AS 'cnt SpecialOffer'
	FROM [Sales].[SpecialOfferProduct] so
	LEFT JOIN [Production].[Product] pp
	ON pp.ProductID = so.ProductID 
	GROUP BY Name
	HAVING COUNT(SpecialOfferID)>1
	

