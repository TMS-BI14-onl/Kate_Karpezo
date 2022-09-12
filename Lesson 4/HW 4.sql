/*
3. ��� ����� ��������� ������� ������� Row Number, Rank � Dense Rank ������ ���������� ���������?
�����: ���������� �������� ����� � 1-� ������
		OVER (ORDER BY ��������� ����)

4.	������ �� ���� ������ AdventureWorks2017 ��������� ������. 

a)	������� ������ � ������� Production.UnitMeasure. ���������, ���� �� ����� UnitMeasureCode, ������������ �� ����� �Ғ. 
�����: ���

*/
	SELECT *
	FROM Production.UnitMeasure
	WHERE UnitMeasureCode LIKE 'T%'

/*
������� ����� ��������� ����� ����� ����? 
�����: 38
*/
	SELECT COUNT (
					DISTINCT (UnitMeasureCode) )
	FROM Production.UnitMeasure
	
/*
�������� ��������� ����� ������ � �������:
�	TT1, Test 1, 9 �������� 2020
�	TT2, Test 2, getdate()

��������� ������, ���� �� ����� UnitMeasureCode, ������������ �� ����� �Ғ. 
�����: 2 ������
*/
	INSERT INTO Production.UnitMeasure ([UnitMeasureCode], [Name], [ModifiedDate])
	VALUES 
	('TT1', 'Test 1', CAST('2020-09-09' AS datetime)),
	('TT2', 'Test 2', getdate())
			

/*
b)	������ ��������� ����������� ����� � �����, �� ������������ ������� Production.UnitMeasureTest. ��������� ���� ���������� �� Production.UnitMeasure �� UnitMeasureCode = �CAN�. 
���������� ��������� � ��������������� ���� �� ����. 
*/
	SELECT [UnitMeasureCode], [Name], [ModifiedDate]
	INTO Production.UnitMeasureTest
	FROM Production.UnitMeasure
	WHERE UnitMeasureCode LIKE 'T%'

	INSERT INTO Production.UnitMeasureTest ([UnitMeasureCode], [Name], [ModifiedDate])
	SELECT [UnitMeasureCode], [Name], [ModifiedDate]
	FROM Production.UnitMeasure
	WHERE UnitMeasureCode = 'CAN'

	SELECT *
	FROM Production.UnitMeasureTest
	ORDER BY UnitMeasureCode


--c)	�������� UnitMeasureCode ��� ����� ������ �� Production.UnitMeasureTest �� �TTT�.

	UPDATE Production.UnitMeasureTest
	SET UnitMeasureCode = 'TTT'
	

--d)	������� ��� ������ �� Production.UnitMeasureTest.

	DELETE
	FROM Production.UnitMeasureTest

--e)	������� ���������� �� Sales.SalesOrderDetail �� ������� 43659,43664.  � ������� ������� ������� MAX, MIN, AVG ������ �������� �� LineTotal ��� ������� SalesOrderID.

	SELECT *,
	MAX(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Max", 
	MIN(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Min", 
	AVG(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Avg"
	FROM Sales.SalesOrderDetail
	WHERE SalesOrderID IN (43659, 43664)
/*
f)	������� ������ � ������� Sales.vSalesPerson. �������� ������� c���� ��������� �� ������ ������� ������ SalesYTD, ��������� ����������� ������� �������. 
�������� ���� Login, ��������� �� 3 ������ ���� ������� � ������� �������� + �login� + TerritoryGroup (Null �������� �� ������ ��������). 
��� ����������� �������? � ��� ���������� ������� � ������� ���� (SalesLastYear). 
�����: YTD best seller Linds Mitchel; LY - Ranjit Varkey Chudukatil
*/
	
	SELECT CONCAT( UPPER(LEFT(LastName,3)), 'login', ISNULL(TerritoryGroup,'')) AS 'Login',
	BusinessEntityID, FirstName, LastName, JobTitle, City,SalesYTD, SalesLastYear,
	DENSE_RANK () OVER (ORDER BY SalesYTD DESC) AS 'Best Seller',
	DENSE_RANK () OVER (ORDER BY SalesLastYear DESC) AS 'Best Seller LY'
	FROM Sales.vSalesPerson
	ORDER BY SalesYTD DESC

--g)	������� ������ ������ ���� ������ (FROM �� ����������). ����� ����������� ��� �� ��� �������.


	SELECT  
	MONTH(GETDATE()) as the_month,
	CASE
		WHEN DATEPART(WEEKDAY, 
	DATEADD(day, 1, EOMONTH(DATEADD(month, -1, GETDATE())))
	)  = 6 
		THEN DATEADD(mm, DATEDIFF(MM, 0, GETDATE()), 0) + 2 
		WHEN DATEPART(WEEKDAY, 
	DATEADD(day, 1, EOMONTH(DATEADD(month, -1, GETDATE())))
	)  = 7 
		THEN DATEADD(mm, DATEDIFF(MM, 0, GETDATE()), 0) + 1
    ELSE DATEADD(mm, DATEDIFF(MM, 0, GETDATE()), 0)
	END as first_weekday
	
	


/*
5.	 ������� ��� ��� ����������� � ������� ��������� ������� count. ������� �������� count(1), count(name), count(id), count(*) ��� ��������� �������:
Id(PK)	Name		DepName
1		null		A
2		null		null
3		A			C
4		B			C
�����: 
count(1)=4
count(name)=2
count(id)=4
count(*)=4

*/
	