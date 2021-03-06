
/*This utulizes 3 reference tables for this to function properly. 
1. LIBRARY_BRANCH (Repository for the books), 
2. BOOK (The physical content exchanged),
3. BORROWER (patron taking books from the institution)  
*/


  /*CREATING LIBRARY DATABASE*/
USE MASTER
GO

IF  EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'dbLibrarySA')
DROP DATABASE [dbLibrarySA]
GO

CREATE DATABASE [dbLibrarySA]
GO

USE dbLibrarySA
GO 


  /* CREATING TABLES AND INDEXING PRIMARY-FOREIGN KEY RELATIONSHIPS*/


CREATE TABLE BOOK
(
BookID int NOT NULL PRIMARY KEY,
Title varchar (50) NOT NULL,
PublisherID int NOT NULL
)
GO


CREATE TABLE LIBRARY_BRANCH
(
BranchID int NOT NULL PRIMARY KEY,
BranchName varchar (50) NOT NULL,
LBAddress varchar (100) NOT NULL
)
GO


CREATE TABLE BORROWER 
(
CardNo int NOT NULL PRIMARY KEY,
LastName varchar (50) NOT NULL,
FirstName varchar (50) NOT NULL,
BrAddress varchar (100) NOT NULL,
BrPhone varchar (25) NOT NULL
)
GO


			CREATE TABLE PUBLISHER 
			(
			PublisherID int NOT NULL PRIMARY KEY, 
			PublisherName varchar (50) NOT NULL,  
			PubAddress varchar (100) NOT NULL,
			PubPhone varchar (25) NOT NULL
			)
			GO

	ALTER TABLE BOOK 
	ADD CONSTRAINT fk_PerBOOK
	FOREIGN KEY (PublisherID) REFERENCES PUBLISHER(PublisherID) 


		CREATE TABLE BOOK_AUTHORS 
		(
		BookID int NOT NULL,   
		AuthorLastName varchar (50) NOT NULL, 
		AuthorFirstName varchar (50) NOT NULL,
		CONSTRAINT fk_PerBOOK_AUTHORS 
		FOREIGN KEY (BookID) REFERENCES BOOK(BookID) 
		)
		GO


		CREATE TABLE BOOK_COPIES 
		(						 
		BookID int NOT NULL, 
		BranchID int NOT NULL,			 
		No_of_Copies int NOT NULL,
		CONSTRAINT fk_PerBOOK_COPIES		
	    FOREIGN KEY (BookID) REFERENCES BOOK(BookID), 
		FOREIGN KEY (BranchID) REFERENCES LIBRARY_BRANCH(BranchID) 
		)
		GO

		
		CREATE TABLE BOOK_LOANS(						
		BookID int NOT NULL, 
		BranchID int NOT NULL,			 
		CardNo int NOT NULL,
		DateOut date NOT NULL,
		DueDate date NOT NULL,
		CONSTRAINT fk_PerBOOK_LOANS	  
		FOREIGN KEY (BookID) REFERENCES BOOK(BookID), 
		FOREIGN KEY (BranchID) REFERENCES LIBRARY_BRANCH(BranchID), 
		FOREIGN KEY (CardNo) REFERENCES BORROWER(CardNo)
		)
		GO
			

USE dbLibrarySA
GO


INSERT INTO PUBLISHER /*PublisherID, PublisherName, PubAddress, PubPhone*/
VALUES 
(1, 'Penguin Publishing', '12 N Westmincer', '945-425-4789'),
(2, 'Tribiski House', '5124 E Library Lane', '519-475-3582'),
(3, 'Coheed and Cambree', '618 N Craig Rd', '489-851-1582'),
(4, 'Amon Amarth Publishing', '1235 Flag St', '479-498-7894'),
(5, 'Ragnarok P.', '41 Metallica St', '265-489-4785'),
(6, 'Wayne Foundation', '3524 Profile Rd', '784-448-6852'),
(7, 'Master Roshi Publishing', '498 Titan Lane', '498-4558-7896')
GO

INSERT INTO BOOK /*BookID, Title, PublisherID*/
VALUES 

(1, 'A Scanner Darkly', 5),	 
(2, 'Shall not Perish', 1),	
(3, 'The Skull Beneath the Skin', 7),
(4, 'The Soldiers Art', 3),	  
(5, 'Master and Commander', 4),
(6, 'Gotcha', 5),
(7, 'Lolita', 2),
(8, 'Haha', 1),
(9, 'Antitrust and American Business Abroad', 6),
(10, 'Carrie', 3),
(11, 'The Lost Tribe', 7),
(12, 'The Lost World', 5),
(13, 'The Shining', 3),
(14, 'IT', 3),
(15, 'A Game of Thrones', 2),
(16, 'A Storm of Swords', 2),
(17, 'A Feast of Crows', 2),
(18, 'A Dance of Dragons', 2),
(19, 'A Clash of Kings', 2),
(20, 'Heart of Darkness', 4) 
GO

INSERT INTO BOOK_AUTHORS 
VALUES 
(1, 'Dick', 'Philip'),
(2, 'Faulkner', 'William '),
(3, 'James', 'Phyllis D.'),
(4, 'Powell', 'Anthony'),
(5, 'OBrian', 'Patrick'),
(6, 'Talor', 'Eldon'),
(7, 'Nabokov', 'Vladimir'),
(8, 'King', 'David'),
(9, 'Fiebig', 'Andre'),
(10, 'King', 'Stephen'),
(11, 'Mann', 'Michael'),
(12, 'Doyle', 'Conan'),
(13, 'King', 'Stephen'),
(14, 'King', 'Stephen'), 
(15, 'Martin', 'George RR'),
(16, 'Martin', 'George RR'),
(17, 'Martin', 'George RR'),
(18, 'Martin', 'George RR'),
(19, 'Martin', 'George RR'),
(20, 'Conrad', 'Joseph') 
GO

INSERT INTO LIBRARY_BRANCH /*BranchID, BranchName, LBAddress*/
VALUES 
(1, 'Sharpstown', '512 N Fellows'),
(2, 'Central', '724 E Bertergrounds ST'),
(3, 'Thomas', '4951 S Davenport Rd'),
(4, 'Grand', '5314 E Rob Lane')
GO

INSERT INTO BORROWER /*CardNo, LastName, FirstName, BrAddress, BrPhone*/
VALUES 
(1, 'Ramsey', 'Geoff', '198 Achieve St', '498-165-4815'),
(2, 'Free', 'Gavin', '954 Hunter Rd', '495-569-4523'),
(3, 'Burns', 'Burnie', '498 Funhaus Rd', '784-951-4785'),
(4, 'Serola', 'Gus', '1955 Rooster St', '854-458-5258'),
(5, 'Doole', 'Jeremy', '4622 Yellow Rd', '485-254-7852'),
(6, 'Green', 'Bruce', '703 Blue St', '365-485-4789'),
(7, 'Jones', 'Michael', '523 Red Lane', '485-456-7159'),
(8, 'Pattilo', 'Jack', '541 Number St', '962-485-6472'),
(9, 'Jones', 'Lindsey', '6123 Left Rd', '498-654-4687'),
(10, 'Dunklmen', 'Barbra', '932 Right St', '489-298-4678')
GO


INSERT INTO BOOK_COPIES /*BookID, BranchID, No_of_Copies*/
VALUES 
(1, 1, 2),
(1, 2, 2),
(1, 3, 2),
(1, 4, 2),
(2, 1, 2),
(2, 2, 2),
(2, 3, 2),
(2, 4, 2),
(3, 1, 2),
(3, 2, 2),
(3, 3, 2),
(3, 4, 2),
(4, 1, 2),
(4, 2, 2),
(4, 3, 2),
(4, 4, 2),
(5, 1, 2),
(5, 2, 2),
(5, 3, 2),
(5, 4, 2),
(6, 1, 2),
(6, 2, 2),
(6, 3, 2),
(6, 4, 2),
(7, 1, 2),
(7, 2, 2),
(7, 3, 2),
(7, 4, 2),
(8, 1, 2),
(8, 2, 2),
(8, 3, 2),
(8, 4, 2),
(9, 1, 2),
(9, 2, 2),
(9, 3, 2),
(9, 4, 2),
(10, 1, 2),
(10, 2, 2),
(10, 3, 2),
(10, 4, 2),
(11, 1, 2),
(11, 2, 2),
(11, 3, 2),
(11, 4, 2),
(12, 1, 2),
(12, 2, 2),
(12, 3, 2),
(12, 4, 2),
(13, 1, 2),
(13, 2, 2),
(13, 3, 2),
(13, 4, 2),
(14, 1, 2),
(14, 2, 2),
(14, 3, 2),
(14, 4, 2),
(15, 1, 2),
(15, 2, 2),
(15, 3, 2),
(15, 4, 2),
(16, 1, 2),
(16, 2, 2),
(16, 3, 2),
(16, 4, 2),
(17, 1, 2),
(17, 2, 2),
(17, 3, 2),
(17, 4, 2),
(18, 1, 2),
(18, 2, 2),
(18, 3, 2),
(18, 4, 2),
(19, 1, 2),
(19, 2, 2),
(19, 3, 2),
(19, 4, 2),
(20, 1, 2),
(20, 2, 2),
(20, 3, 2),
(20, 4, 2) 
GO	


INSERT INTO BOOK_LOANS /*BookID, BranchID, CardNo, DateOut, DueDate*/
VALUES 

(1, 1, 1, '12/31/2018', '1/26/2019'),
(2, 1, 1, '12/12/2018', '1/27/2019'),
(3, 1, 1, '12/1/2018', '1/24/2019'),
(4, 1, 1, '12/21/2018', '1/22/2019'),
(5, 1, 1, '12/13/2018', '1/21/2019'),
(6, 1, 1, '12/3/2018', '1/24/2019'),
(7, 1, 2, '12/13/2018', '1/16/2019'),
(8, 1, 2, '12/12/2018', '1/27/2019'),
(9, 1, 2, '12/16/2018', '1/12/2019'),
(10, 1, 2, '12/17/2018', '1/24/2019'),
(1, 2, 4, '12/19/2018', '1/28/2019'),
(2, 2, 4, '12/20/2018', '1/21/2019'),
(3, 2, 4, '12/24/2018', '1/17/2019'),
(4, 2, 4, '12/26/2018', '1/12/2019'),
(5, 2, 4, '12/28/2018', '1/12/2019'),
(6, 2, 4, '12/25/2018', '1/2/2019'),
(7, 2, 5, '12/29/2018', '1/17/2019'),
(8, 2, 5, '12/30/2018', '1/18/2019'),
(9, 2, 5, '12/31/2018', '1/27/2019'),
(10, 2, 5, '12/10/2018', '1/26/2019'),
(1, 3, 6, '12/16/2018', '1/18/2019'),
(2, 3, 6, '12/29/2018', '1/19/2019'),
(3, 3, 6, '12/28/2018', '1/12/2019'),
(4, 3, 6, '12/24/2018', '1/19/2019'),
(5, 3, 6, '12/26/2018', '1/16/2019'),
(6, 3, 6, '12/4/2018', '1/3/2019'),
(7, 3, 7, '12/6/2018', '1/7/2019'),
(8, 3, 7, '12/23/2018', '1/13/2019'),
(9, 3, 7, '12/14/2018', '1/29/2019'),
(10, 3, 7, '12/12/2018', '1/11/2019'),
(11, 1, 1, '12/15/2018', '1/16/2019'),
(12, 1, 1, '12/19/2018', '1/19/2019'),
(13, 1, 1, '12/20/2018', '1/20/2019'),
(14, 1, 1, '12/23/2018', '1/23/2019'),
(15, 1, 1, '12/25/2018', '1/25/2019'),
(16, 2, 4, '12/27/2018', '1/27/2019'),
(17, 2, 4, '12/22/2018', '1/22/2019'),
(18, 2, 4, '12/13/2018', '1/13/2019'),
(19, 2, 4, '12/12/2018', '1/12/2019'),
(20, 2, 4, '12/11/2018', '1/11/2019'),
(11, 3, 6, '12/9/2018', '1/9/2019'),
(12, 3, 6, '12/1/2018', '1/1/2019'),
(13, 4, 6, '12/3/2018', '1/2/2019'),
(14, 4, 6, '12/18/2018', '1/18/2019'),
(15, 4, 6, '12/14/2018', '1/14/2019'),
(16, 4, 7, '12/17/2018', '1/17/2019'),
(17, 4, 7, '12/13/2018', '1/13/2019'),
(18, 3, 7, '12/6/2018', '1/6/2019'),
(19, 3, 7, '12/9/2018', '1/9/2019'),
(20, 3, 7, '12/2/2018', '1/2/2019')
GO



SELECT BC.BranchID, LB.BranchName, BC.No_of_Copies
FROM BOOK AS B
FULL JOIN BOOK_COPIES AS BC ON B.BookID = BC.BookID
FULL JOIN LIBRARY_BRANCH AS LB ON BC.BranchID = LB.BranchID
WHERE B.Title = 'The Lost Tribe' AND LB.BranchName = 'Sharpstown'


SELECT BC.BranchID, LB.BranchName, BC.No_of_Copies
FROM BOOK AS B
FULL JOIN BOOK_COPIES AS BC ON B.BookID = BC.BookID
FULL JOIN LIBRARY_BRANCH AS LB ON BC.BranchID = LB.BranchID
WHERE B.Title = 'The Lost Tribe' 


SELECT Br.CardNo, Br.LastName, Br.FirstName  
FROM BORROWER AS Br
FULL JOIN BOOK_LOANS AS BL ON Br.CardNo = BL.CardNo
WHERE BL.DueDate IS NULL  


SELECT B.Title, Br.LastName, Br.FirstName, BrAddress, DueDate 
FROM BOOK_LOANS AS BL
FULL JOIN BOOK AS B ON BL.BookID = B.BookID
FULL JOIN LIBRARY_BRANCH AS LB ON BL.BranchID = LB.BranchID
FULL JOIN BORROWER AS Br ON BL.CardNo = Br.CardNo
WHERE LB.BranchName = 'Sharpstown' AND BL.DueDate = CONVERT (date,GETDATE())


SELECT LB.BranchName, COUNT(BL.BookID) AS TotalBooksLoanedOut  
FROM BOOK_LOANS AS BL 
FULL JOIN LIBRARY_BRANCH AS LB ON BL.BranchID = LB.BranchID
WHERE BL.DueDate IS NOT NULL  
GROUP BY LB.BranchName
 


SELECT Br.LastName, Br.FirstName, Br.BrAddress, COUNT(BL.BookID) AS TotalBookLoans 
FROM BOOK_LOANS AS BL
FULL JOIN BORROWER AS Br ON BL.CardNo = Br.CardNo
WHERE BL.DueDate IS NOT NULL
GROUP BY Br.LastName, Br.FirstName, Br.BrAddress
HAVING COUNT(BL.BookID) > 5 


SELECT B.Title, BC.No_of_Copies 
FROM BOOK AS B
FULL JOIN BOOK_COPIES AS BC ON BC.BookID = B.BookID
FULL JOIN BOOK_AUTHORS AS BA ON B.BookID = BA.BookID
FULL JOIN LIBRARY_BRANCH AS LB ON BC.BranchID = LB.BranchID
WHERE LB.BranchName = 'Central' AND BA.AuthorLastName = 'King' AND BA.AuthorFirstName = 'Stephen'
GO


USE dbLibrarySA  
GO  
IF OBJECT_ID('uspGetLoans', 'P') IS NOT NULL  
    DROP PROCEDURE uspGetLoans  
GO 

CREATE PROCEDURE uspGetLoans @LastName varchar(30) = NULL
AS
SELECT Br.LastName, Br.FirstName, Br.BrAddress, COUNT(BL.BookID) AS TotalBookLoans 
FROM BOOK_LOANS AS BL
FULL JOIN BORROWER AS Br ON BL.CardNo = Br.CardNo
WHERE LastName LIKE '%' + ISNULL(@LastName,LastName) + '%'
GROUP BY Br.LastName, Br.FirstName, Br.BrAddress, Br.BrPhone
GO

EXEC uspGetLoans 
GO

