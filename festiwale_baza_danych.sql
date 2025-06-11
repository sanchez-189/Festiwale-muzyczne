CREATE TABLE Uzytkownicy (
    ID_uzytkownika INT AUTO_INCREMENT PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Haslo VARCHAR(255) NOT NULL,
    Typ_konta ENUM('uczestnik', 'organizator', 'admin') NOT NULL,
    Zgoda_RODO BOOLEAN NOT NULL 
);
CREATE TABLE Festiwale (
    ID_festiwalu INT AUTO_INCREMENT PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL,
    Lokalizacja VARCHAR(100) NOT NULL,
    Data_rozpoczecia DATE NOT NULL,
    Data_zakonczenia DATE NOT NULL,
    Typ ENUM('rock', 'pop', 'jazz', 'electronic', 'inne'),
    Opis TEXT
);
CREATE TABLE Artysta (
    ID_artysty INT AUTO_INCREMENT PRIMARY KEY,
    Nazwa_artysty VARCHAR(100) NOT NULL,
    Gatunek VARCHAR(50),
    Kraj_pochodzenia VARCHAR(50),
    Opis TEXT
);
CREATE TABLE Sceny (
    ID_sceny INT AUTO_INCREMENT PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL,
    Pojemnosc INT NOT NULL,
    Lokalizacja_na_terenie VARCHAR(100)
);
CREATE TABLE Koncerty (
    ID_koncertu INT AUTO_INCREMENT PRIMARY KEY,
    ID_festiwalu INT NOT NULL,
    ID_artysty INT NOT NULL,
    ID_sceny INT NOT NULL,
    Data_i_godzina DATETIME NOT NULL,
    Czas_trwania INT NOT NULL,
    Rodzaj_dostępu ENUM('ogólny','VIP'),
    FOREIGN KEY (ID_festiwalu) REFERENCES Festiwale(ID_festiwalu),
    FOREIGN KEY (ID_artysty) REFERENCES Artysta(ID_artysty),
    FOREIGN KEY (ID_sceny) REFERENCES Sceny(ID_sceny)
);
CREATE TABLE Bilety (
    ID_biletu INT AUTO_INCREMENT PRIMARY KEY,
    ID_festiwalu INT NOT NULL,
    Typ_biletu ENUM('jednodniowy', 'karnet', 'vip') NOT NULL,
    Cena DECIMAL(10,2) NOT NULL,
    Ilosc_dostepna INT NOT NULL,
    Data_dotyczy DATE,
    FOREIGN KEY (ID_festiwalu) REFERENCES Festiwale(ID_festiwalu)
);
CREATE TABLE Zakupy (
    ID_zakupu INT AUTO_INCREMENT PRIMARY KEY,
    ID_uzytkownika INT NOT NULL,
    Data_zakupu DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('oczekujący', 'opłacony', 'anulowany'),
    FOREIGN KEY (ID_uzytkownika) REFERENCES Uzytkownicy(ID_uzytkownika)
);
CREATE TABLE Zakupione_Bilety (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_zakupu INT NOT NULL,
    ID_biletu INT NOT NULL,
    Liczba_sztuk INT NOT NULL,
    Cena_jednostkowa DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ID_zakupu) REFERENCES Zakupy(ID_zakupu),
    FOREIGN KEY (ID_biletu) REFERENCES Bilety(ID_biletu)
);
CREATE TABLE Statystyki_uczestnictwa (
    ID_statystyki INT AUTO_INCREMENT PRIMARY KEY,
    ID_festiwalu INT NOT NULL UNIQUE,
    Liczba_uczestnikow INT DEFAULT 0,
    Najpopularniejszy_koncert INT,
    Srednia_wiekowa DECIMAL(4,1),
    FOREIGN KEY (ID_festiwalu) REFERENCES Festiwale(ID_festiwalu),
    FOREIGN KEY (Najpopularniejszy_koncert) REFERENCES Koncerty(ID_koncertu)
);  