-- Procedura dodająca nowego użytkownika
DELIMITER //
CREATE PROCEDURE DodajUzytkownika (
    IN p_Imie VARCHAR(50),
    IN p_Nazwisko VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_Haslo VARCHAR(255),
    IN p_Typ_konta ENUM('uczestnik', 'organizator', 'admin'),
    IN p_Zgoda_RODO BOOLEAN
)
BEGIN
    INSERT INTO Uzytkownicy (Imie, Nazwisko, Email, Haslo, Typ_konta, Zgoda_RODO)
    VALUES (p_Imie, p_Nazwisko, p_Email, p_Haslo, p_Typ_konta, p_Zgoda_RODO);
END //
DELIMITER ;

-- Procedura aktualizująca cenę biletu
DELIMITER //
CREATE PROCEDURE ZmienCeneBiletu (
    IN p_ID_biletu INT,
    IN p_Nowa_cena DECIMAL(10,2)
)
BEGIN
    UPDATE Bilety
    SET Cena = p_Nowa_cena
    WHERE ID_biletu = p_ID_biletu;
END //
DELIMITER ;

-- Procedura generująca raport zakupów użytkownika
DELIMITER //
CREATE PROCEDURE RaportZakupow (
    IN p_ID_uzytkownika INT
)
BEGIN
    SELECT 
        z.ID_zakupu,
        z.Data_zakupu,
        z.Status,
        b.Typ_biletu,
        zb.Liczba_sztuk,
        zb.Cena_jednostkowa
    FROM Zakupy z
    JOIN Zakupione_Bilety zb ON z.ID_zakupu = zb.ID_zakupu
    JOIN Bilety b ON zb.ID_biletu = b.ID_biletu
    WHERE z.ID_uzytkownika = p_ID_uzytkownika;
END //
DELIMITER ;




