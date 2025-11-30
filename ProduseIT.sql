USE master

GO
IF exists(
	SELECT *FROM sys.databases WHERE name='Magazin_Electronic_Andries')
	BEGIN
		ALTER DATABASE Magazin_Electronic_Andries SET single_user
		WITH ROLLBACK IMMEDIATE
		DROP DATABASE Magazin_Electronic_Andries
	END
GO
CREATE DATABASE Magazin_Electronic_Andries
GO
USE Magazin_Electronic_Andries
GO
CREATE TABLE produse(
			Producator varchar(1),
			Model int PRIMARY KEY,
			Tip nvarchar(15)
			)
GO
CREATE TABLE pc_uri(
			Cod int PRIMARY KEY,
			Model int FOREIGN KEY REFERENCES produse(Model),
			Viteza int NOT NULL,
			RAM int NOT NULL,
			Hd int NOT NULL,
			Cd nvarchar(4) NOT NULL,
			Pret int NOT NULL
)
GO
CREATE TABLE laptop_uri(
			Cod int PRIMARY KEY,
			Model int FOREIGN KEY REFERENCES produse(Model),
			Viteza int NOT NULL,
			RAM int NOT NULL,
			Hd int NOT NULL,
			Pret int NOT NULL,
			Ecran float NOT NULL
)
GO
CREATE TABLE imprimante(
			Cod int PRIMARY KEY,
			Model int FOREIGN KEY REFERENCES produse(Model),
			Color nvarchar(2) NOT NULL,
			Tip nvarchar(10) NOT NULL,
			Pret int NOT NULL
)
GO
INSERT INTO produse VALUES
	('B',1121,'PC'),
	('A',1232,'PC'),
	('A',1233,'PC'),
	('E',1260,'PC'),
	('A',1276,'Imprimante'),
	('D',1288,'Imprimante'),
	('A',1298,'Laptop_uri'),
	('C',1321,'Laptop_uri'),
	('A',1401,'Imprimante'),
	('A',1408,'Imprimante'),
	('D',1433,'Imprimante'),
	('E',1434,'Imprimante'),
	('B',1750,'Laptop_uri'),
	('A',1752,'Laptop_uri'),
	('E',2111,'PC'),
	('E',2112,'PC')
GO
	INSERT INTO pc_uri (Cod, Model, Viteza, Ram, Hd, Cd, Pret)
		VALUES(1, 1232, 500, 64, 5, '12x', 600),
		(2, 1121, 750, 128, 14, '40x', 850),
		(3, 1233, 500, 64, 5, '12x', 600),
		(4, 1121, 600, 128, 14, '40x', 850),
		(5, 1121, 600, 128, 8, '40x', 850),
		(6, 1233, 750, 128, 20, '50x', 950),
		(7, 1232, 500, 32, 10, '12x', 400),
		(8, 1232, 450, 64, 8, '24x', 350),
		(9, 1232, 450, 64, 8, '24x', 350),
		(10, 1260, 500, 32, 10, '12x', 350),
		(11, 1233, 900, 128, 40, '40x', 980)

GO
INSERT INTO laptop_uri(Cod, Model, Viteza, Ram, Hd, Pret, Ecran)
		VALUES(1, 1298, 350, 32,4, 700, 11),
		(2, 1232, 500, 64, 8, 970, 12),
		(3, 1750, 750, 128, 12, 1200, 14),
		(4, 1298, 600, 64, 10, 1050, 15),
		(5, 1752, 750, 128, 10, 1150, 14),
		(6, 1298, 450, 64, 10, 950, 12)

		GO
	INSERT INTO imprimante(Cod, Model, Color, Tip, Pret)
		VALUES(1, 1276, 'nu', 'Laser', 400),
		(2, 1433, 'da', 'Jet',270 ),
		(3, 1434, 'da', 'Jet', 290),
		(4, 1401, 'nu', 'Matrix', 150),
		(5, 1408, 'nu', 'Matrix', 270),
		(6, 1288, 'nu', 'Laser', 400)

--PROCEDURI:
--1) O procedura: Adauga care va adaugand atributele:
-- Venit(companie)-va fi calculat 15% din pret_de_primire
-- TVA-va fi 18% din pret_de_primire
-- Pret_vinzare-suma(pret_de_primire,Venit(companie),TVA)
CREATE PROCEDURE CreareAtribute AS 
BEGIN
	ALTER TABLE pc_uri
	ADD Venit DECIMAL(18, 2);

	ALTER TABLE pc_uri
	ADD TVA DECIMAL(18, 2);

	ALTER TABLE pc_uri
	ADD Pret_vinzare DECIMAL(18, 2);
END
GO

EXEC CreareAtribute

CREATE PROCEDURE InserareValori AS 
BEGIN
	UPDATE pc_uri
	SET Venit = (Pret * 0.15),
		TVA = (Pret * 0.18),
		Pret_vinzare = (Pret + Venit + TVA);
END
GO

EXEC InserareValori

--2)O procedura - Elimină, care va șterge înregistrări după niște criterii la dorinta(de ex modele care nu se mai produc).
CREATE PROCEDURE Elimină
	@pret INT,
	@ecran INT
AS
BEGIN
	DELETE FROM laptop_uri
	WHERE Pret = @pret AND Ecran = @ecran;
END

EXEC Elimină @pret = 1050, @ecran = 15;
SELECT * FROM laptop_uri

--3) O procedura -Calcule, care va calcula nr. de produse de același fel.
CREATE PROCEDURE Calcule 
	@ram INT
AS
BEGIN
	SELECT COUNT(*)
	FROM pc_uri
	WHERE RAM = @ram;
END

EXEC Calcule @ram = 64;