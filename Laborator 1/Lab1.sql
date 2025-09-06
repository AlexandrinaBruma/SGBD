CREATE DATABASE PetShop; --Crearea bazei de date

--Cream tabelele
CREATE TABLE Magazin (
	ID_magazin INT PRIMARY KEY IDENTITY(1, 1),
	Nume NVARCHAR(50) NOT NULL,
	Adresa NVARCHAR(50) NOT NULL,
	Data_deschiderii DATETIME,
	Servicii INT,
	Tabara_de_zi INT,
	Produse INT
);

CREATE TABLE Client (
	ID_client INT PRIMARY KEY IDENTITY(1, 1),
	Nume NVARCHAR(50) NOT NULL,
	Prenume NVARCHAR(50) NOT NULL,
	Telefon NVARCHAR(9) NOT NULL,
	Email NVARCHAR(50),
	Adresa_resedintei NVARCHAR(50)
);

CREATE TABLE Animal (
	ID_animal INT PRIMARY KEY IDENTITY(1, 1),
	Nume NVARCHAR(50) NOT NULL,
	Data_nasterii DATETIME NOT NULL,
	Specie NVARCHAR(20) NOT NULL,
	Contraindicatii NVARCHAR(100),
	Stapan INT
);

CREATE TABLE Serviciu (
	ID_serviciu INT PRIMARY KEY IDENTITY(1, 1),
	Nume NVARCHAR(50) NOT NULL,
	Client INT
);

CREATE TABLE Produs (
	ID_produs INT PRIMARY KEY IDENTITY(1, 1),
	Nume NVARCHAR(50) NOT NULL,
	Producator NVARCHAR(50),
	Data_producerii DATETIME NOT NULL,
	Data_expirarii DATETIME NOT NULL
);

CREATE TABLE Tabara_de_zi (
	ID_tabara INT PRIMARY KEY IDENTITY(1, 1),
	Nume NVARCHAR(50) NOT NULL,
	Animale INT,
	Capacitate_mxima INT NOT NULL,
	Ora_de_inceput TIME NOT NULL,
	Ora_de_sfarsit TIME NOT NULL,
);

-- Adaugam cheile straine 
ALTER TABLE Magazin
ADD FOREIGN KEY (Servicii) REFERENCES Serviciu(ID_serviciu);

ALTER TABLE Magazin
ADD FOREIGN KEY (Tabara_de_zi) REFERENCES Tabara_de_zi(ID_tabara);

ALTER TABLE Magazin
ADD FOREIGN KEY (Produse) REFERENCES Produs(ID_produs);

ALTER TABLE Serviciu
ADD FOREIGN KEY (Client) REFERENCES Client(ID_client);

ALTER TABLE Tabara_de_zi
ADD FOREIGN KEY (Animale) REFERENCES Animal(ID_animal);

ALTER TABLE Animal
ADD FOREIGN KEY (Stapan) REFERENCES Client(ID_client);

--Populam cu date baza de date
INSERT INTO Client (Nume, Prenume, Telefon, Email, Adresa_resedintei)
VALUES 
	('Bruma', 'Alexandrina', 069623669, 'alexandrinabruma04@gmail.com', 'str.Albisoara'), 
	('Niculce', 'Tatiana', 069244152, 'tatiananiculce@gmail.com', 'bd.Cuza-Voda'),
	('Ciobanu', 'Maria', 079526231, 'ciobanumaria@gmail.com', 'str.Burebista'), 
	('Popa', 'Elena', 069255152, 'popaelena@mail.ru', 'bd.Moscova'),
	('Moraru', 'Laura', 069334423, 'morarulaura@gmail.com', 'str.Albisoara');

INSERT INTO Serviciu (Nume, Client)
VALUES 
	('Frizerie', 1), 
	('Veterinar', 1),
	('Antrenament', 3),
	('Frizerie', 2),
	('Frizerie', 5);

INSERT INTO Produs (Nume, Producator, Data_producerii, Data_expirarii)
VALUES 
	('Hairball Care Adult','ROYAL CANIN', '2025-08-12', '2026-08-12'), 
	('Sterilised Adult','ROYAL CANIN', '2024-09-12', '2026-09-12'), 
	('Pure Puret','MIAU MIAU', '2025-08-12', '2029-08-12'), 
	('Junior Selectii Clasice','WHISKAS', '2025-06-29', '2026-06-29'), 
	('Gourmet Gold Mousse','PURINA', '2025-08-12', '2026-08-12'); 

INSERT INTO Animal(Nume, Data_nasterii, Specie, Contraindicatii, Stapan)
VALUES 
	('Bella','2019-11-20', 'Pisica', '', 1),
	('Thomas','2020-11-02', 'Pisica', 'Alergie la peste', 2), 
	('Daisy','2022-07-20', 'Caine', '', 3), 
	('Penny','2023-11-01', 'Iepure', '', 4), 
	('Fluffy','2017-04-06', 'Caine', '', 5);

INSERT INTO Tabara_de_zi(Nume, Animale, Capacitate_mxima, Ora_de_inceput, Ora_de_sfarsit)
VALUES 
	('Flower Daycamp', 1, 12, '08:00', '20:00'),
	('Flower Daycamp', 2, 12, '08:00', '20:00'), 
	('Flower Daycamp', 3, 12, '08:00', '20:00'), 
	('Butterfly Daycamp', 4, 15, '07:00', '20:00'), 
	('Butterfly Daycamp', 5, 15, '07:00', '20:00');


INSERT INTO Magazin(Nume, Adresa, Data_deschiderii, Servicii, Tabara_de_zi, Produse)
VALUES 
	('PetExpert', 'str.Albisoara', '2019-05-06', 1, 1, 5),
	('PetExpert', 'str.Albisoara', '2019-05-06', 2, 1, 6),
	('ZooMaster', 'bd.Cuza-Voda', '2022-08-16', 5, 2, 5),
	('ZooMaster', 'str.Cuza-Voda', '2022-08-16', 4, 2, 7),
	('PetCare', 'str.Paris', '2023-12-05', 3, 1, 9);


--CREAM INTEROGARI
--VEDERI:
--1. Afisarea tutror animalelor care sunt in fiecare tabara de zi
CREATE VIEW AnimaleleTaberelor AS
	SELECT t.Nume AS NumeleTaberei, a.Nume AS Animal 
	FROM Tabara_de_zi t
	INNER JOIN Animal a ON a.ID_animal = t.Animale;

SELECT * FROM AnimaleleTaberelor;

--2. Afisarea numarului de animale din fiecare tabara de zi
CREATE VIEW NumarulDeAnimaleDinTabere AS
	SELECT t.Nume AS NumeleTaberei, COUNT(a.ID_animal) AS NumarDeAnimale
	FROM Tabara_de_zi t
	INNER JOIN Animal a ON a.ID_animal = t.Animale
	GROUP BY t.Nume;

SELECT * FROM NumarulDeAnimaleDinTabere;

--3. Afisati cate locatii au fiecare magazin pentru animale
CREATE VIEW NumarulDeLocatii AS
	SELECT m.Nume, COUNT(m.Adresa) AS NumarulDeMagazine 
	FROM Magazin m
	GROUP BY m.Nume;

SELECT * FROM NumarulDeLocatii;

--4. Afisati clientul fiecarui serviciu
CREATE VIEW ClientiiServiciilor AS
	SELECT s.Nume AS NumeServiciu, c.Nume + ' ' + c.Prenume AS Clientul
	FROM Serviciu s
	INNER JOIN Client c ON s.Client = c.ID_client;

SELECT * FROM ClientiiServiciilor;

--5. Afisati animalul de companie al fiecarui client
CREATE VIEW AnimalulDeCompanie AS
	SELECT c.Nume + c.Prenume AS Clientul, a.Nume AS AnimalulDeCompanie
	FROM Client c
	INNER JOIN Animal a ON a.Stapan = C.ID_client;

SELECT * FROM AnimalulDeCompanie;