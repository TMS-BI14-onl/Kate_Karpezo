/*
1.	������ �� ���� ������ AdventureWorks2017 ��������� ������:
a)	������� ��� ������� �� ������� Sales.SalesTerritory.
*/
	USE AdventureWorks2017
	SELECT *
	FROM Sales.SalesTerritory


-- b)	������� ������� TerritoryID � Name �� ������� Sales.SalesTerritory.
	
	USE AdventureWorks2017
	SELECT TerritoryID, Name
	FROM Sales.SalesTerritory

-- c)	������� ��� ������, ������� ���������� ��� ����� �� Person.Person � LastName = �Norman�.

	USE AdventureWorks2017
	SELECT *
	FROM Person.Person
	WHERE LastName = 'Norman'


-- d)	������� ��� ������ �� Person.Person, ��� EmailPromotion �� ����� 2. 

	USE AdventureWorks2017
	SELECT *
	FROM Person.Person
	WHERE EmailPromotion != 2

/*
3. ����� ��� ���������� ������� ���������� � ����� T-SQL? ��������� ��������� ��������.
�����:
/APPROX_COUNT_DISTINCT - ���������� ��������������� ���������� ���������� ��������� �������� � ������;
/CHECKSUM_AGG - ���������� ����������� ����� �������� � ������;
/COUNT_BIG - ���������� ���������� ���������, ��������� � ������;
/GROUPING - ���������, �������� �� ��������� ��������� ������� � ������ GROUP BY �������������� ��� ���;
/STDEV - ���������� �������������� ����������� ����������;
/VAR - ���������� �������������� ��������� ���� ��������. 
*/

/*
4.	������ �� ���� ������ AdventureWorks2017 ��������� ������:
a)	������� ���������� PersonType ���������� ��� ����� �� Person.Person � LastName ������������ � ����� � ��� �� ���������� 1 � EmailPromotion.
�����: 6
*/
	USE AdventureWorks2017
	SELECT  COUNT(DISTINCT PersonType) AS DistinctCountPersonType
	FROM Person.Person
	WHERE LastName LIKE 'M%' OR EmailPromotion NOT LIKE '%1%'

-- b)	������� ������ 3 ����������� ����������� �� Sales.SpecialOffer � ����������� DiscountPct, ������� �������� ����������� � 2013-01-01 �� 2014-01-01

	USE AdventureWorks2017
	SELECT TOP 3 *
	FROM Sales.SpecialOffer
	WHERE ModifiedDate BETWEEN '2013-01-01' AND '2014-01-01'
	ORDER BY DiscountPct DESC

/*
c)	����� ����� ����������� ��� � ����� ������������ ������ �������� �� Production.Product.
�����: min ��� 2.12; max ������ XL; ������� � ����������� ����� � ������������ �������� 2.12/44 
*/

	USE AdventureWorks2017
	SELECT MIN(Weight) AS Weight
	FROM Production.Product

	USE AdventureWorks2017
	SELECT MAX(Size) AS Size
	FROM Production.Product

	USE AdventureWorks2017
	SELECT TOP 1 Weight, Size
	FROM Production.Product
	WHERE Weight IS NOT NULL AND Size IS NOT NULL	
	ORDER BY Weight ASC, Size DESC						-- ��������� ���� ���������� 2 �������, ���� ������ ������ ��� ����� :)


/*
d)	����� ����� ����������� ��� � ����� ������������ ������ �������� ��� ������ ������������ ProductSubcategoryID �� Production.Product. 
*/

	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MIN(Weight) AS 'Weight'
	FROM Production.Product
	GROUP BY ProductSubcategoryID

	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MAX(Size) AS 'Size'
	FROM Production.Product
	GROUP BY ProductSubcategoryID


/*
e)	����� ����� ����������� ��� � ����� ������������ ������ �������� ��� ������ ������������ ProductSubcategoryID �� Production.Product, ��� ���� �������� ���������(Color).
*/

	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MIN(Weight) AS 'Weight'
	FROM Production.Product
	WHERE Color IS NOT NULL	
	GROUP BY ProductSubcategoryID


	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MAX(Size) AS 'Size'
	FROM Production.Product
	WHERE Color IS NOT NULL	
	GROUP BY ProductSubcategoryID

