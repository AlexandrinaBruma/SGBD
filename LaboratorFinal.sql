CREATE DATABASE SchimbValutar;
USE SchimbValutar;

CREATE TABLE Moneda (
    ID_moneda INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) NOT NULL,
    Simbol NVARCHAR(5) NOT NULL
);

CREATE TABLE Banca (
    ID_banca INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(100) NOT NULL
);

CREATE TABLE CursValutar (
    ID_curs INT PRIMARY KEY IDENTITY(1,1),
    ID_banca INT NOT NULL FOREIGN KEY REFERENCES Banca(ID_banca),
    ID_moneda_from INT NOT NULL FOREIGN KEY REFERENCES Moneda(ID_moneda),
    ID_moneda_to INT NOT NULL FOREIGN KEY REFERENCES Moneda(ID_moneda),
    Rata DECIMAL(10,4) NOT NULL,
    DataCurs DATE NOT NULL
);


INSERT INTO Moneda (Nume, Simbol) VALUES 
('Leu', 'MDL'),
('Euro', 'EUR'),
('Dolar American', 'USD'),
('Liră Sterlină', 'GBP');

INSERT INTO Banca (Nume) VALUES
('Banca Națională'),
('BCR'),
('ING Bank');

INSERT INTO CursValutar (ID_banca, ID_moneda_from, ID_moneda_to, Rata, DataCurs) VALUES
(1, 1, 2, 0.049, '2025-11-28'),  -- MDL -> EUR
(1, 1, 3, 0.056, '2025-11-28'),  -- MDL -> USD
(2, 1, 2, 0.0485, '2025-11-28'), -- MDL -> EUR la BCR
(3, 1, 3, 0.0555, '2025-11-28'), -- MDL -> USD la ING
(2, 2, 3, 1.15, '2025-11-28');   -- EUR -> USD la BCR

--Creați 1-2 tabele prin intermediul tranzacțiilor
BEGIN TRANSACTION 
	CREATE TABLE Utilizator (
		ID_utilizator INT PRIMARY KEY IDENTITY(1,1),
		Nume NVARCHAR(50) NOT NULL,
		Email NVARCHAR(100) NOT NULL UNIQUE,
		DataInregistrare DATE NOT NULL DEFAULT GETDATE()
	);

	CREATE TABLE Tranzactie (
		ID_tranzactie INT PRIMARY KEY IDENTITY(1,1),
		ID_utilizator INT NOT NULL,
		ID_curs INT NOT NULL,
		Suma DECIMAL(15,2) NOT NULL,
		DataTranzactie DATETIME NOT NULL DEFAULT GETDATE(),
		FOREIGN KEY (ID_utilizator) REFERENCES Utilizator(ID_utilizator),
		FOREIGN KEY (ID_curs) REFERENCES CursValutar(ID_curs)
	);
COMMIT TRANSACTION;

INSERT INTO Utilizator (Nume, Email) VALUES
('Alexandrina Bruma', 'alexandrina@gmail.com'),
('Emilia Ciobanu', 'ciobanue@gmail.com'),
('Mihai Stincu', 'mihaistincu@gmail.com'),
('Laura Marin', 'lauram@gmail.com'),
('Paula Grosu', 'paula.grosu@gmail.com'),
('Ion Popescu', 'ion.popescu@gmail.com')

--inserați 5-6 înregistrări prin intermediul unei proceduri.
CREATE PROCEDURE addTransaction
    @utilizator INT,
    @curs INT,
    @suma DECIMAL(15,2),
    @dataTranzactiei DATETIME
AS
BEGIN
    INSERT INTO Tranzactie (ID_utilizator, ID_curs, Suma, DataTranzactie) 
    VALUES (@utilizator, @curs, @suma, @dataTranzactiei);
END;

EXEC addTransaction 1, 1, 1000, '2025/11/28';
EXEC addTransaction 2, 2, 500, '2025/11/25';
EXEC addTransaction 3, 2, 200, '2025/11/23';
EXEC addTransaction 4, 1, 1000, '2025/11/28';
EXEC addTransaction 5, 1, 50, '2025/11/18';
EXEC addTransaction 1, 1, 1000, '2025/11/10';

SELECT * FROM Tranzactie;

--Faceți careva calcule folosind o funcție(scalară sau tabelară).
CREATE FUNCTION tranzactiiPeZi (
	@data DATETIME
)
RETURNS INT
AS
BEGIN
	DECLARE @numar INT 
	SELECT @numar = COUNT(ID_tranzactie) FROM Tranzactie
	WHERE DataTranzactie = @data
    RETURN @numar
END

SELECT dbo.tranzactiiPeZi('2025/11/28'); 

CREATE FUNCTION informatiiTranzactii
  (@tranzactie INT)
RETURNS TABLE
AS
   	RETURN
	SELECT 
		ID_tranzactie, 
		u.Nume AS nume_utilizator,
		mf.Nume AS moneda_oferita,
        mt.Nume AS moneda_schimbata,
		t.Suma,
		t.DataTranzactie
	FROM Tranzactie t
	JOIN CursValutar c ON t.ID_curs = c.ID_curs
	JOIN Utilizator u ON u.ID_utilizator = t.ID_utilizator
	JOIN Moneda mf ON c.ID_moneda_from = mf.ID_moneda
    JOIN Moneda mt ON c.ID_moneda_to = mt.ID_moneda 
	WHERE ID_tranzactie = @tranzactie;
GO

SELECT * FROM informatiiTranzactii(2);

--Creați un declanșator(INSERT, UPDATE, DELETE) care va interzice una din operații MDL verificând o condiție anumită.
CREATE TRIGGER trigger_restrictiiMDL
ON Tranzactie
AFTER INSERT, UPDATE
AS
BEGIN
  IF EXISTS (
        SELECT *
        FROM inserted i
		JOIN CursValutar c ON c.ID_curs = i.ID_curs
		JOIN Moneda m ON c.ID_moneda_from = m.ID_moneda
		JOIN Banca b ON b.ID_banca = c.ID_banca
        WHERE m.Simbol = 'MDL' AND i.Suma > 100000 AND b.ID_banca != 1
  )
    BEGIN
        RAISERROR('Nu aveti voie sa schimbati mai mult de 100 000 de lei moldovenesti la bancile straine.', 16, 1);
        ROLLBACK;
    END
END;

INSERT INTO CursValutar (ID_banca, ID_moneda_from, ID_moneda_to, Rata, DataCurs) VALUES
(2, 1, 3, 0.0560, '2025-11-28')

INSERT INTO Tranzactie (ID_utilizator, ID_curs, Suma, DataTranzactie)
VALUES (1, 6, 200000, GETDATE());
