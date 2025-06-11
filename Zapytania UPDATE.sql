-- Zmień status wszystkich nieopłaconych zakupów na „anulowany”
UPDATE Zakupy
SET Status = 'anulowany'
WHERE Status = 'oczekujący';

-- Zmiana hasła użytkownika o konkretnym adresie e-mail
UPDATE Uzytkownicy
SET Haslo = 'nowehaslo'
WHERE Email = 'jan.nowak@example.com';

-- Zwiększenie ceny wszystkich biletów typu „karnet” o 10%
UPDATE Bilety
SET Cena = Cena * 1.10
WHERE Typ_biletu = 'karnet';

-- Zmiana pojemności sceny o nazwie „Main Stage” na 12 000 miejsc
UPDATE Sceny
SET Pojemnosc = 12000
WHERE Nazwa = 'Main Stage';
