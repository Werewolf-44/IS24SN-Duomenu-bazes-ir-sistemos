-- Sukuriama (jei yra – ištrinama) lentelė Atlyginimai
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Atlyginimai';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Sukuriama lentelė darbuotojų atlyginimams saugoti
CREATE TABLE Atlyginimai (
  Sutarties_Nr      NUMBER(5) PRIMARY KEY, -- sutarties numeris
  Pavarde           VARCHAR2(50) NOT NULL, -- darbuotojo pavardė
  Atlyginimas       NUMBER(8,2),           -- atlyginimas
  Idarbinimo_data   DATE                   -- įdarbinimo data
);

-- Įterpiami testiniai duomenys
INSERT INTO Atlyginimai VALUES (1001, 'Jonaitis',      1200, DATE '2021-03-15');
INSERT INTO Atlyginimai VALUES (1002, 'Petraitis',     1450, DATE '2022-06-10');
INSERT INTO Atlyginimai VALUES (1003, 'Kazlauskas',    1100, DATE '2020-09-01');
INSERT INTO Atlyginimai VALUES (1004, 'Jankauskaite',  1700, DATE '2019-01-20');
INSERT INTO Atlyginimai VALUES (1005, 'Vasiliauskas',  1350, DATE '2023-02-05');
INSERT INTO Atlyginimai VALUES (1006, 'Mikalauskaite', 1250, DATE '2024-04-12');

COMMIT; -- išsaugomi pakeitimai

-- Užduotys --

/*-- 1 užduotis: parodo dabartinę sistemos datą
SELECT SYSDATE AS Data
FROM DUAL;
*/

/*-- 2 užduotis: apskaičiuoja naują atlyginimą (+15.5%), tik sveika dalis
SELECT Sutarties_Nr,
       Pavarde,
       TRUNC(Atlyginimas * 1.155) AS "Naujas Atlyginimas"
FROM Atlyginimai;
*/

/*-- 3 užduotis: parodo kiek padidėjo atlyginimas
SELECT Sutarties_Nr,
       Pavarde,
       Atlyginimas,
       TRUNC(Atlyginimas * 1.155) AS "Naujas Atlyginimas",
       TRUNC(Atlyginimas * 1.155) - Atlyginimas AS "Padidėjimas"
FROM Atlyginimai;
*/

/*-- 4 užduotis: suformuoja tekstinį stulpelį su darbuotojo informacija
SELECT 'Darbuotojo ' || UPPER(Pavarde) ||
       ' numeris yra ' || Nr ||
       ', o kvalifikacija ' || LOWER(Kvalifikacija)
       AS "Vykdytojo duomenys"
FROM Vykdytojai;
*/

/*-- 5 užduotis: pavardės suformatuojamos ir parodomas jų ilgis (tik J, G, A)
SELECT INITCAP(Pavarde) AS Pavarde,
       LENGTH(Pavarde) AS Pavardes_ilgis
FROM Vykdytojai
WHERE SUBSTR(UPPER(Pavarde), 1, 1) IN ('J', 'G', 'A') <-- nuo kurio simbolio pradėti ir kiek simbolių paimti
ORDER BY Pavarde;
*/

/*-- 6 užduotis: pavardės filtruojamos pagal įvestą pirmą raidę
SELECT INITCAP(Pavarde) AS Pavarde,
       LENGTH(Pavarde) AS Pavardes_ilgis
FROM Vykdytojai
WHERE SUBSTR(Pavarde, 1, 1) = '&Raide'
ORDER BY Pavarde;
*/

/*-- 7 užduotis: tas pats kaip 6, bet nesvarbu raidės tipas
SELECT INITCAP(Pavarde) AS Pavarde,
       LENGTH(Pavarde) AS Pavardes_ilgis
FROM Vykdytojai
WHERE UPPER(SUBSTR(Pavarde, 1, 1)) = UPPER('&Raide')
ORDER BY Pavarde;
*/

/*-- 8 užduotis: skaičiuoja kiek mėnesių darbuotojas dirba
SELECT Pavarde,
       ROUND(MONTHS_BETWEEN(SYSDATE, Idarbinimo_data)) AS Dirba_Menesiu
FROM Atlyginimai
ORDER BY Dirba_Menesiu DESC;
*/