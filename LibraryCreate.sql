
USE MASTER
GO

IF  EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'dbLibrarySA')
DROP DATABASE [dbLibrarySA]
GO

CREATE DATABASE [dbLibrarySA]
GO

USE dbLibrarySA
GO 

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

		
		CREATE TABLE BOOK_LOANS 
		(						
		BookID int NOT NULL, 
		BranchID int NOT NULL,			 
		CardNo int NOT NULL,
		DateOut date NOT NULL, 
		DueDate date NOT NULL,
		CONSTRAINT fk_PerBOOK_LOANS	  
		FOREIGN KEY (BookID) REFERENCES BOOK(BookID), 
		FOREIGN KEY (BranchID) REFERENCES LIBRARY_BRANCH(BranchID), -
		FOREIGN KEY (CardNo) REFERENCES BORROWER(CardNo)
		)
		GO

