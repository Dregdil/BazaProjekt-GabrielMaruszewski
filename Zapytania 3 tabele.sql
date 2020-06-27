1. USE `wypozyczalnia`;
SELECT 
    CONCAT(p.imie, ' ', p.nazwisko) AS 'Imie i nazwisko',
    s.miasto,
    CONCAT(s.ulica, ' ', s.nrbudynku) AS 'Adres'
FROM
    pracownicysalonu ps
        LEFT JOIN
    pracownicy p ON ps.idpracownika = p.idpracownika
        LEFT JOIN
    salony s ON ps.idsalonu = s.idsalonu  -- wyświetla salony wraz z ich pracownikami

2.USE `wypozyczalnia`;
SELECT 
    CONCAT(k.imie, ' ', k.nazwisko) AS 'Imie i nazwisko',
    d.email,
    d.nrtelefonu
FROM
    rezerwacje r
        LEFT JOIN
    klient k ON r.idklienta = k.idklienta
        LEFT JOIN
    danekontaktoweklienta d ON k.idklienta = d.idklienta -- dane kontaktowe klientów którzy mają rezerwacje

3.USE `wypozyczalnia`;
SELECT 
    CONCAT(k.imie, ' ', k.nazwisko) AS 'Imie i nazwisko',
    k.pesel,
    d.email,
    d.nrtelefonu
FROM
    rezerwacje r
        LEFT JOIN
    klient k ON r.idklienta = k.idklienta
        LEFT JOIN
    danekontaktoweklienta d ON k.idklienta = d.idklienta
        LEFT JOIN
    oplatarezerwacji o ON r.idrezerwacji = o.idrezerwacji
WHERE
    o.czyzaplacono = 0 -- wyświetla dane klienta wraz z jego danymi kontaktowymi jeśli nie opłacił on rezerwacji

4.USE `wypozyczalnia`;
SELECT 
    CONCAT(k.imie, ' ', k.nazwisko) AS 'Imie i nazwisko',
    k.pesel,
    d.email,
    d.nrtelefonu
FROM
    rezerwacje r
        LEFT JOIN
    klient k ON r.idklienta = k.idklienta
        LEFT JOIN
    danekontaktoweklienta d ON k.idklienta = d.idklienta
        LEFT JOIN
    oplatarezerwacji o ON r.idrezerwacji = o.idrezerwacji
WHERE
    o.czyzaplacono = 0 -- wyświetla dane klienta wraz z jego danymi kontaktowymi jeśli opłacił on rezerwacje

5.USE `wypozyczalnia`;
SELECT 
	sa.model,
    sa.cena,
    s.miasto,
    CONCAT(s.ulica, ' ', s.nrbudynku) AS 'Adres',
    CASE d.dostepnosc
        WHEN 0 THEN 'NIEDOSTĘPNY'
        WHEN 1 THEN 'DOSTĘPNY'
    END AS 'DOSTĘPNOŚĆ'
FROM
    dostepnoscSamochodu d
		LEFT JOIN 
	samochody sa ON d.idsamochodu = sa.idsamochodu
        LEFT JOIN
    salony s ON d.idSalonu = s.idSalonu ORDER BY d.idsamochodu -- wyświetla model i cene samochodu dostępnego w danym salonie

6.USE `wypozyczalnia`;
SELECT 
    CONCAT(p.imie, ' ', p.nazwisko) AS 'Imie i nazwisko',
    d.email,
    d.nrtelefonu,
    s.miasto,
    CONCAT(s.ulica, ' ', s.nrbudynku) AS 'Adres'
FROM
    pracownicysalonu ps
        LEFT JOIN
    pracownicy p ON ps.idpracownika = p.idpracownika
        LEFT JOIN
    salony s ON ps.idsalonu = s.idsalonu
        LEFT JOIN
    danekontaktowepracownika d ON p.idpracownika = d.idpracownika -- wyświetla pracowników i ich dane kontaktowe wraz z miejscem ich pracy

7.USE `wypozyczalnia`;
SELECT 
    sa.model,
    sa.cena,
    p.nazwa AS 'Producent',
    s.miasto,
    CONCAT(s.ulica, ' ', s.nrbudynku) AS 'Adres'
FROM
    wynajetesamochody w
        LEFT JOIN
    samochody sa ON w.idsamochodu = sa.idsamochodu
        LEFT JOIN
    salony s ON w.idsalonu = s.idsalonu
        LEFT JOIN
    producent p ON sa.idproducenta = p.idproducent -- informacje o wynajętych samochodach

8.USE `wypozyczalnia`;
SELECT 
	p.idwynsamochodu AS 'id Wynajętego samochodu',
    CONCAT(k.imie, ' ', k.nazwisko) AS 'Imie i nazwisko',
    k.pesel,
    d.email,
    d.nrtelefonu
FROM
    przezkogowynajete p
        LEFT JOIN
    klient k ON p.idklienta = k.idklienta
        LEFT JOIN
    danekontaktoweklienta d ON k.idklienta = d.idklienta -- wyświetla dane klienta wraz z kontaktem do niego i wynajetym samochodem

9.USE `wypozyczalnia`;
SELECT 
    CONCAT(k.imie, ' ', k.nazwisko) AS 'Imie i nazwisko',
    k.pesel,
    d.email,
    d.nrtelefonu,
    o.datazak AS 'Data zakończenia wynajmu'
FROM
    przezkogowynajete p
        LEFT JOIN
    klient k ON p.idklienta = k.idklienta
        LEFT JOIN
    danekontaktoweklienta d ON k.idklienta = d.idklienta
        LEFT JOIN
    okreswynajecia o ON p.idwynsamochodu = o.idwynsamochodu
WHERE
    o.datazak < '2020-12-31' -- dane klienta któremu wynajm skończy się do końca roku

10.USE `wypozyczalnia`;
SELECT 
    CONCAT(k.imie, ' ', k.nazwisko) AS 'Imie i nazwisko',
    k.pesel,
    d.email,
    d.nrtelefonu,
    sa.model,
    pr.nazwa AS 'Producent',
    s.miasto,
    CONCAT(s.ulica, ' ', s.nrbudynku) AS 'Adres',
    o.datawyn AS 'Data rozpoczęcia wynajmu',
    o.datazak AS 'Data zakończenia wynajmu'
FROM
    przezkogowynajete p
        LEFT JOIN
    klient k ON p.idklienta = k.idklienta
        LEFT JOIN
    danekontaktoweklienta d ON k.idklienta = d.idklienta
        LEFT JOIN
    okreswynajecia o ON p.idwynsamochodu = o.idwynsamochodu
        LEFT JOIN
    wynajetesamochody w ON p.idwynsamochodu = w.idwynsamochodu
        LEFT JOIN
    samochody sa ON w.idsamochodu = sa.idsamochodu
        LEFT JOIN
    salony s ON w.idsalonu = s.idsalonu
        LEFT JOIN
    producent pr ON sa.idproducenta = pr.idproducent -- wyświetla pełne dane o wypożyczonych samochodach wraz z danymi klienta i salonu