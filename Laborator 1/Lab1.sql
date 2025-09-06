CREATE DATABASE PetShop;

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
