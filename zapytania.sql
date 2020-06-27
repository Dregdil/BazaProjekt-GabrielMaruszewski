-- Zapytania Wybierające:

USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.Klient;  -- wyświetlenie danych z tabeli Klient
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.Pracownicy;  -- wyświetlenie danych z tabeli Pracownicy
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.Samochody;  -- wyświetlenie danych z tabeli Samochody
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.Producent;  -- wyświetlenie danych z tabeli Producent
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.Salony;  	-- wyświetlenie danych z tabeli Salony
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.Rezerwacje;  -- wyświetlenie danych z tabeli Rezerwacje
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.WynajeteSamochody;  -- wyświetlenie danych z tabeli WynajeteSamochody
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.OplataRezerwacji;  -- wyświetlenie danych z tabeli OplataRezerwacji
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.DostepnoscSamochodu;  -- wyświetlenie danych z tabeli DostepnoscSamochodu
USE `wypozyczalnia`;SELECT * FROM wypozyczalnia.OkresWynajecia;  -- wyświetlenie danych z tabeli OkresWynajecia

-- Zapytania Selekcji:

USE `wypozyczalnia`;SELECT * FROM dostepnoscsamochodu WHERE dostepnosc = 1; -- wyświetla listę dostępnych samochodów
USE `wypozyczalnia`;SELECT * FROM dostepnoscsamochodu WHERE dostepnosc = 0; -- wyświetla listę niedostępnych samochodów
USE `wypozyczalnia`;SELECT * FROM oplatarezerwacji WHERE czyZaplacono = 1; -- wyświetla listę opłaconych rezerwacji
USE `wypozyczalnia`;SELECT * FROM oplatarezerwacji WHERE czyZaplacono = 0; -- wyświetla listę nieopłaconych rezerwacji
USE `wypozyczalnia`;SELECT * FROM samochody WHERE cena < 3500 ORDER BY cena ASC; -- wyświetla listę samochodów poniżej podanej ceny (Można podać własną wartość: SELECT * FROM samochody WHERE cena < [ilość] ORDER BY cena ASC;)
USE `wypozyczalnia`;SELECT * FROM samochody WHERE cena > 3500 ORDER BY cena DESC; -- wyświetla listę samochodów powyżej podanej ceny (Można podać własną wartość: SELECT * FROM samochody WHERE cena > [ilość] ORDER BY cena DESC;)
USE `wypozyczalnia`;SELECT nrtelefonu, email FROM danekontaktoweklienta WHERE idklienta = 3;  -- wyświetla dane kontaktowe klienta o podanym id (Można podać własne id Klienta: SELECT nrtelefonu, email FROM danekontaktoweklienta WHERE idklienta = [idKlienta];)
USE `wypozyczalnia`;SELECT nrtelefonu, email FROM danekontaktowepracownika WHERE idpracownika = 4; -- wyświetla dane kontaktowe pracownika o podanym id (Można podać własne id Pracownika: SELECT nrtelefonu, email FROM danekontaktowepracownika WHERE idpracownika = [idPracownika];)
USE `wypozyczalnia`;SELECT Imie, Nazwisko, PESEL FROM klient WHERE idklienta = 5;  -- wyświetla imie, nazwisko i pesel klienta o podanym id (Można podać własne id Klienta: SELECT Imie, Nazwisko, PESEL FROM klient WHERE idklienta = [idKlienta];)
USE `wypozyczalnia`;SELECT 
    e.Imie,
    e.Nazwisko,
    e.PESEL,
    CONCAT(m.imie, ' ', m.nazwisko) AS Przełożony
FROM
    pracownicy e
        INNER JOIN
    pracownicy m ON m.idpracownika = e.idprzelozonego -- wyświetla imie, nazwisko i pesel pracownika wraz z imieniem, i nazwiskiem przełożonego(jeśli owego posiadają)

-- Zapytania join(2 tabele):

USE `wypozyczalnia`;SELECT 
    CONCAT(klient.imie, ' ', klient.nazwisko) AS 'Imię i Nazwisko',
    danekontaktoweklienta.email,
    danekontaktoweklienta.nrtelefonu
FROM
    klient
        LEFT JOIN
    danekontaktoweklienta ON klient.idklienta = danekontaktoweklienta.idklienta; -- wyświetla imie i nazwisko klienta wraz z jego danymi kontaktowymi

USE `wypozyczalnia`;SELECT 
    CONCAT(pracownicy.imie, ' ', pracownicy.nazwisko) AS 'Imię i Nazwisko',
    danekontaktowepracownika.email,
    danekontaktowepracownika.nrtelefonu
FROM
    pracownicy
        LEFT JOIN
    danekontaktowepracownika ON pracownicy.idpracownika = danekontaktowepracownika.idpracownika; -- wyświetla imie i nazwisko pracownika wraz z jego danymi kontaktowymi

USE `wypozyczalnia`;SELECT 
    s.model, s.cena, p.nazwa AS 'nazwa producenta'
FROM
    samochody s
        LEFT JOIN
    producent p ON s.idproducenta = p.idproducent -- wyświetla model i cene samochodów wraz z nazwa ich producenta

USE `wypozyczalnia`;SELECT 
    r.idKlienta,
    CASE o.czyZaplacono
        WHEN 0 THEN 'NIEZAPŁACONO'
        WHEN 1 THEN 'ZAPŁACONO'
    END AS 'Czy Zapłacono'
FROM
    rezerwacje r
        RIGHT JOIN
    oplatarezerwacji o ON r.idrezerwacji = o.idrezerwacji -- wyświetla idKlienta i czy opłacił on rezerwacje

USE `wypozyczalnia`;SELECT 
    r.idsamochodu,
    CASE o.czyZaplacono
        WHEN 0 THEN 'NIEZAPŁACONO'
        WHEN 1 THEN 'ZAPŁACONO'
    END AS 'Czy Zapłacono'
FROM
    rezerwacje r
        RIGHT JOIN
    oplatarezerwacji o ON r.idrezerwacji = o.idrezerwacji  -- wyświetla informacje czy rezerwacja na dany samochód została opłacona

USE `wypozyczalnia`;SELECT 
    s.model, s.cena, w.idsalonu
FROM
    wynajetesamochody w
        LEFT JOIN
    samochody s ON w.idSamochodu = s.idsamochodu  -- wyświetla samochód i jego cene w którym salonie zostały wynajęte

USE `wypozyczalnia`;SELECT 
    s.miasto, concat(s.ulica, ' ', s.nrBudynku) AS "Adres", w.idsamochodu
FROM
    wynajetesamochody w
        LEFT JOIN
    salony s ON w.idSalonu = s.idsalonu -- wyświetla salony w których zostały wynajęte samochody wraz z ich id

USE `wypozyczalnia`;SELECT 
    w.idsamochodu, w.idsalonu, p.idklienta
FROM
    przezkogowynajete p
        LEFT JOIN
    wynajetesamochody w ON p.idwynsamochodu = w.idwynsamochodu  -- wyświetlenie klienta wraz z wynajętym przez niego samochodem w danym salonie

USE `wypozyczalnia`;SELECT 
    w.idsamochodu, w.idsalonu, o.datawyn AS "Data wynajmu", o.datazak AS "Data Zakończenia Wynajmu"
FROM
    okreswynajecia o
        LEFT JOIN
    wynajetesamochody w ON o.idwynsamochodu = w.idwynsamochodu  -- wyświetlenie samochodu w jakim salonie został wynajęty i jego okres wynajecia

USE `wypozyczalnia`;SELECT 
    d.idSamochodu,
    s.miasto,
    CONCAT(s.ulica, ' ', s.nrbudynku) AS 'Adres',
    CASE d.dostepnosc
        WHEN 0 THEN 'NIEDOSTĘPNY'
        WHEN 1 THEN 'DOSTĘPNY'
    END AS 'DOSTĘPNOŚĆ'
FROM
    dostepnoscSamochodu d
        LEFT JOIN
    salony s ON d.idSalonu = s.idSalonu ORDER BY d.idsamochodu -- wyświetla czy samochód jest dostępny w danym salonie