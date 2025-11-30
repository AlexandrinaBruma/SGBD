CREATE DATABASE Companie_IT;

USE Companie_IT;

CREATE TABLE Departamente
(
    IdDepartament int PRIMARY KEY,
    Nume_Dep varchar(20),
    Manager_Id int
);


create table Angajati
(
    IdAngajat int PRIMARY KEY,
    IdDepartament int references Departamente(IdDepartament),
    Supervizor_Id int,
    Nume varchar(50),
    Prenume varchar(50),
    CNP int,
    Strada varchar(50),
    Numar int,
    Oras char(30),
    Judet char(20),
    Sex varchar(1)CHECK(Sex='M' OR Sex='F'),
    Data_n date,
    Salariu int
);

CREATE TABLE Proiecte
(
    IdProiect int NOT NULL PRIMARY KEY,
    Nume_Proiect varchar(30),
    Buget int,
    Termen_lim date,
    IdDepartament int references Departamente(IdDepartament)
);

CREATE TABLE AngProiect
(
    IdAng_Proiect int Primary key,
    IdProiect int NOT NULL references Proiecte(IdProiect),
    IdAngajat int NOT NULL references Angajati(IdAngajat),
    NrOreSap int
);


SELECT *
FROM Departamente
insert into Departamente
values
    (1, 'WEB', 1),
    (2, 'Grafica', 2),
    (3, 'Mecanica', 3),
    (4, 'Design', 4),
    (5, 'Tester1', 5);

SELECT *
FROM Angajati
insert into Angajati
values
    (1, 1, 1, 'Bachinshi', 'Catalin', 02938473, 'Ismail', 34, 'Chisinau', 'Centru', 'M', '2000-01-02', 6000),
    (2, 1, 2, 'Godoroja', 'Marin', 02938473, 'Tighina', 34, 'Chisinau', 'Botanica', 'M', '2001-02-03', 4700),
    (3, 2, 3, 'Borzin', 'Alexandru', 02938473, 'Bulgara', 34, 'Chisinau', 'Buiucani', 'M', '2002-03-05', 3500),
    (4, 2, 4, 'Volosciuc', 'Nicoleta', 02938473, 'Decebal', 34, 'Chisinau', 'Rascani', 'F', '2007-04-09', 1000),
    (5, 3, 5, 'Bachinshi', 'Catalin', 02938473, 'Ismail', 34, 'Chisinau', 'Buiucani', 'M', '1999-11-11', 5500),
    (6, 3, 1, 'Rottaru', 'Tatiana', 02938473, 'Grigore Vieru', 34, 'Chisinau', 'Centru', 'F', '2000-05-11', 6650),
    (7, 4, 2, 'Bandas', 'Victor', 02938473, 'Independentei', 34, 'Chisinau', 'Ciocana', 'M', '2002-08-01', 1430),
    (8, 4, 3, 'Iapara', 'Oleg', 02938473, 'Dacia', 34, 'Chisinau', 'Ciocana', 'M', '2005-10-01', 5500),
    (9, 5, 4, 'Caminschi', 'Leonid', 02938473, 'Traian', 34, 'Buiucani', 'Botanica', 'M', '2002-11-01', 7000),
    (10, 5, 5, 'Cristea', 'Alexandru', 02938473, 'Bulgara', 34, 'Chisinau', 'Rascani', 'M', '2001-12-01', 8100);


SELECT *
FROM Proiecte
insert into Proiecte
values
    (1, 'Ananas', 5000, '2020-07-23', 1),
    (2, 'Banana', 8000, '2020-06-30', 2),
    (3, 'Farfurie', 2300, '2020-06-13', 3),
    (4, 'Husaq', 1300, '2020-05-05', 4),
    (5, 'Nasture', 2400, '2020-05-25', 5);

SELECT *
FROM AngProiect
insert into AngProiect
values
    (1, 1, 10, 24),
    (2, 2, 9, 45),
    (3, 3, 8, 43),
    (4, 4, 7, 24),
    (5, 5, 6, 30),
    (6, 1, 5, 15),
    (7, 2, 4, 20),
    (8, 3, 3, 27),
    (9, 4, 2, 24),
    (10, 5, 1, 34);

CREATE TABLE Intretinuti (
	IdIntretinuti int PRIMARY KEY, 
	Nume_intretinut NVARCHAR(50),
	Prenume_intretinut NVARCHAR(50), 
	Gen varchar(1)CHECK(Gen='M' OR Gen='F'), 
	Data_NS DATE, 
	IdAngajat INT REFERENCES Angajati(IdAngajat)
);

INSERT INTO Intretinuti VALUES
	(1, 'Bachinshi', 'Simona', 'F', '2009/12/12', 1),
	(2, 'Bachinshi', 'Samuel', 'M', '2005/10/04', 1),
	(3, 'Bachinshi', 'Silviu', 'M', '2011/03/03', 1),
	(4, 'Godoroja', 'Marian', 'M', '2010/03/12', 2),
	(5, 'Godoroja', 'Maria', 'F', '2010/03/12', 2),
	(6, 'Borzin', 'Elizaveta', 'F', '2006/04/14', 3),
	(7, 'Borzin', 'Olivia', 'F', '2010/12/03', 3),
	(8, 'Borzin', 'Olivia', 'F', '2010/12/03', 3),
	(9, 'Volosciuc', 'Raluca', 'F', '2000/02/12', 4),
	(10, 'Bachinshi', 'Liviu', 'M', '2005/02/04', 5),
	(11, 'Bachinshi', 'Elena', 'F', '2007/05/14', 5),
	(12, 'Rottaru', 'Emilia', 'F', '2015/06/16', 6),
	(13, 'Bandas', 'Alexandru', 'M', '2004/01/03', 7),
	(14, 'Bandas', 'Alexandra', 'F', '2005/05/25', 7),
	(15, 'Bandas', 'Alexia', 'F', '2007/09/22', 7),
	(16, 'Iapara', 'Alexandra', 'F', '2007/09/19', 8),
	(17, 'Iapara', 'Nicoleta', 'F', '2009/12/20', 8),
	(18, 'Caminschi', 'Lavinia', 'F', '2006/08/14', 9),
	(19, 'Caminschi', 'Laura', 'F', '2016/02/03', 9),
	(20, 'Cristea', 'Camelia', 'F', '2010/07/26', 10);

--a)Salariul ?l schimba?i in Salariul_calculat,
BEGIN TRY
    BEGIN TRANSACTION

	--parametrii sp_rename: obiectul care il redenumim, noul nume, tipul de obiect
	EXEC sp_rename 'Angajati.Salariu',  'Salariul_calculat', 'COLUMN';

    COMMIT TRANSACTION
	PRINT ('Tranzactia s-a efectuat cu succes');
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    --Printam mesajul de eroare
    PRINT 'Tranzactia a esuat';
    PRINT ERROR_MESSAGE();
END CATCH

SELECT * FROM Angajati;

--b)M?ri?i Salariul_calculat la to?i angaja?ii din Departamentul1 cu 10 %
BEGIN TRY
    BEGIN TRANSACTION

	UPDATE Angajati
	SET Salariul_calculat = (Salariul_calculat + Salariul_calculat * 0.1)
	WHERE IdDepartament = 1;

    COMMIT TRANSACTION
	PRINT ('Tranzactia s-a efectuat cu succes');
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    --Printam mesajul de eroare
    PRINT 'Tranzactia a esuat';
    PRINT ERROR_MESSAGE();
END CATCH

SELECT * FROM Angajati;

--c)Adaugand atributele: Taxe_retinute - va fi calculat 18% din  Salariul_calculat,
BEGIN TRANSACTION 
	ALTER TABLE Angajati 
	ADD Taxe_retinute INT
	GO

	SAVE TRANSACTION ColoanaAdaugata

	UPDATE Angajati
	SET Taxe_retinute = (Salariul_calculat * 0.18);

	ROLLBACK TRANSACTION ColoanaAdaugata
COMMIT
SELECT * FROM Angajati;

-- Adaugand atributele: Salariul_achitat-va fi calculat Salariul_calculat-Taxe_retinute
BEGIN TRANSACTION 
	ALTER TABLE Angajati 
	ADD Salariul_achitat INT
	GO

	SAVE TRANSACTION ColoanaAdaugata

	UPDATE Angajati
	SET Salariul_achitat = (Salariul_calculat - Taxe_retinute);

	ROLLBACK TRANSACTION ColoanaAdaugata
COMMIT
SELECT * FROM Angajati;

--d)Elimina?i c?teva ?nregistr?ri dup? ni?te criterii la dorinta.
BEGIN TRANSACTION 
	DELETE FROM AngProiect
	WHERE IdAngajat IN (
		SELECT IdAngajat FROM Angajati WHERE Salariul_calculat < 1300
	);

	DELETE FROM Intretinuti
	WHERE IdAngajat IN (
		SELECT IdAngajat FROM Angajati WHERE Salariul_calculat < 1300
	);

	DELETE FROM Angajati 
	WHERE Salariul_calculat < 1300;
COMMIT
SELECT * FROM Angajati;




