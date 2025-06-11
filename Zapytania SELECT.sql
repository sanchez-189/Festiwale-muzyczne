-- Lista użytkowników, którzy są uczestnikami, posortowana alfabetycznie
SELECT Imie, Nazwisko, Email
FROM Uzytkownicy
WHERE Typ_konta = 'uczestnik'
ORDER BY Nazwisko ASC;

-- Festiwale, które rozpoczną się po 1 lipca 2025, posortowane wg daty rozpoczęcia
SELECT Nazwa, Lokalizacja, Data_rozpoczecia, Data_zakonczenia
FROM Festiwale
WHERE Data_rozpoczecia > '2025-07-01'
ORDER BY Data_rozpoczecia ASC;

-- Bilety VIP, które kosztują więcej niż 200 zł, posortowane malejąco po cenie
SELECT Typ_biletu, Cena, Ilosc_dostepna, Data_dotyczy
FROM Bilety
WHERE Typ_biletu = 'vip' AND Cena > 200
ORDER BY Cena DESC;

-- Koncerty, które trwają dłużej niż 90 minut i są typu ogólny
SELECT ID_koncertu, Data_i_godzina, Czas_trwania, Rodzaj_dostępu
FROM Koncerty
WHERE Czas_trwania > 90 AND Rodzaj_dostępu = 'ogólny'
ORDER BY Data_i_godzina;

-- Zakupy, które mają status „opłacony”, posortowane od najnowszych
SELECT ID_zakupu, ID_uzytkownika, Data_zakupu, Status
FROM Zakupy
WHERE Status = 'opłacony'
ORDER BY Data_zakupu DESC;

-- Użytkownicy, którzy kupili najwięcej biletów
SELECT u.Imie,u.Nazwisko, COUNT(zb.ID) AS Liczba_biletow
FROM Uzytkownicy u
JOIN Zakupy z ON u.ID_uzytkownika = z.ID_uzytkownika
JOIN Zakupione_Bilety zb ON z.ID_zakupu = zb.ID_zakupu
GROUP BY u.ID_uzytkownika
ORDER BY Liczba_biletow DESC LIMIT 5;

-- Lista koncertów z nazwami festiwali, artystów i scen
SELECT f.Nazwa AS Festiwal, a.Nazwa_artysty AS Artysta, s.Nazwa AS Scena, k.Data_i_godzina, k.Czas_trwania, k.Rodzaj_dostępu FROM Koncerty k
JOIN Festiwale f ON k.ID_festiwalu = f.ID_festiwalu
JOIN Artysta a ON k.ID_artysty = a.ID_artysty
JOIN Sceny s ON k.ID_sceny = s.ID_sceny
ORDER BY k.Data_i_godzina;

-- Średnia cena biletu dla każdego festiwalu (z nazwą)
SELECT f.Nazwa AS Festiwal, ROUND(AVG(b.Cena), 2) AS Srednia_cena
FROM Bilety b
JOIN Festiwale f ON b.ID_festiwalu = f.ID_festiwalu
GROUP BY f.ID_festiwalu
ORDER BY Srednia_cena DESC;

-- Najpopularniejsze koncerty według liczby sprzedanych biletów
SELECT k.ID_koncertu, f.Nazwa AS Festiwal, a.Nazwa_artysty AS Artysta, COUNT(zb.ID) AS Sprzedane_bilety FROM Koncerty k
JOIN Festiwale f ON k.ID_festiwalu = f.ID_festiwalu
JOIN Artysta a ON k.ID_artysty = a.ID_artysty
JOIN Bilety b ON b.ID_festiwalu = f.ID_festiwalu
JOIN Zakupione_Bilety zb ON zb.ID_biletu = b.ID_biletu
GROUP BY k.ID_koncertu
ORDER BY Sprzedane_bilety DESC
LIMIT 5;

-- Lista koncertów które trwają dłużej niż śrenia długość koncertu
SELECT ID_koncertu, Data_i_godzina, Czas_trwania
FROM Koncerty
WHERE Czas_trwania > (
    SELECT AVG(Czas_trwania)
    FROM Koncerty
);


