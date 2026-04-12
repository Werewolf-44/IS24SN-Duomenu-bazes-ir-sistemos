/*-- 1 užduotis: Komisiniai + NVL ir NVL2

-- Pridedam naują stulpelį komisinių procentui (0–1)
ALTER TABLE Atlyginimai ADD Komisiniai NUMBER(2,1);

-- Užpildom dalį reikšmių (kiti liks NULL)
UPDATE Atlyginimai SET Komisiniai = 0.2 WHERE Sutarties_Nr = 1001;
UPDATE Atlyginimai SET Komisiniai = 0.3 WHERE Sutarties_Nr = 1003;
UPDATE Atlyginimai SET Komisiniai = 0.1 WHERE Sutarties_Nr = 1005;

COMMIT;
*/

/*-- NVL: jei Komisiniai yra NULL → pakeičia į 0
SELECT Pavarde,
       Atlyginimas,
       NVL(Komisiniai, 0) AS Komisiniai,
       (Atlyginimas*12) + (Atlyginimas*12*NVL(Komisiniai,0)) AS Metines_pajamos
FROM Atlyginimai;

-- NVL2: tikrina ar reikšmė NULL ar ne
SELECT Pavarde,
       Komisiniai,
       NVL2(Komisiniai, 'Yra komisiniai', 'Nėra komisinių') AS Tipas
FROM Atlyginimai;
*/

/*-- 2 užduotis: Vardas + NULLIF ir CASE

-- Pridedam vardų stulpelį
ALTER TABLE Atlyginimai ADD Vardas VARCHAR2(30);

-- Užpildom kelias reikšmes
UPDATE Atlyginimai SET Vardas='Jonas' WHERE Sutarties_Nr=1001;
UPDATE Atlyginimai SET Vardas='Petras' WHERE Sutarties_Nr=1002;
UPDATE Atlyginimai SET Vardas='Kazys' WHERE Sutarties_Nr=1003;

COMMIT;

-- NULLIF: jei abu ilgiai vienodi → grąžina NULL
SELECT Vardas, LENGTH(Vardas),
       Pavarde, LENGTH(Pavarde),
       NULLIF(LENGTH(Vardas), LENGTH(Pavarde)) AS Rezultatas
FROM Atlyginimai;

-- Tas pats su CASE (loginė sąlyga)
SELECT Vardas, Pavarde,
       CASE 
         WHEN LENGTH(Vardas) = LENGTH(Pavarde) THEN NULL
         ELSE LENGTH(Vardas)
       END AS Rezultatas
FROM Atlyginimai;
*/

/*-- 3 užduotis: teksto formavimas + TO_CHAR

SELECT Pavarde ||
       ' uzdirba ' ||
       TO_CHAR(Atlyginimas, '9999.00') ||  -- skaičių paverčia tekstu su formatu
       ' per menesi, bet noretu uzdirbti ' ||
       TO_CHAR(Atlyginimas*3, '9999.00')   -- padaugina ir suformatuoja
       AS "Svajoniu atlyginimai"
FROM Atlyginimai;
*/

/*-- 4 užduotis: COALESCE

SELECT Pavarde,
       Atlyginimas,
       Komisiniai,
       COALESCE(Atlyginimas + Atlyginimas*Komisiniai, Atlyginimas + 200)
       -- jei Komisiniai NULL → ima antrą reikšmę (+200)
       AS Naujas_atlyginimas
FROM Atlyginimai;
*/

/*-- 5 užduotis: pirmas pirmadienis po 6 mėn. nuo įdarbinimo datos
SELECT Pavarde,
       Idarbinimo_data,
       TO_CHAR(
         NEXT_DAY(ADD_MONTHS(Idarbinimo_data, 6), 'MONDAY'),
         'fmDay, YYYY "metu" Month DD "diena"'
       ) AS Perziura
FROM Atlyginimai;
*/

-- 6 užduotis: savaitės diena

/*SELECT Pavarde,
       Idarbinimo_data,
       TO_CHAR(Idarbinimo_data, 'Day') AS Diena  -- ištraukia savaitės dieną
FROM Atlyginimai
ORDER BY TO_CHAR(Idarbinimo_data, 'D'); -- rikiuoja pagal savaitės dieną
*/

-- 7 užduotis: NULL pakeitimas tekstu

/*SELECT Pavarde,
       NVL(TO_CHAR(Komisiniai), 'Be komisiniu') 
       -- jei NULL → rodo tekstą
       AS Komisiniai
FROM Atlyginimai;
*/

-- Paleisti norint, kad būtų matomi pakeitimai ir 8 ir 9 užduotys būtų atliktos

/* UPDATE Vykdytojai SET Kvalifikacija = 'Informatikas' WHERE Pavarde = 'Jonaitis';
UPDATE Vykdytojai SET Kvalifikacija = 'Statistikas' WHERE Pavarde = 'Petraitis';
UPDATE Vykdytojai SET Kvalifikacija = 'Inžinierius' WHERE Pavarde = 'Kazlauskas';
UPDATE Vykdytojai SET Kvalifikacija = 'Vadybininkas' WHERE Pavarde = 'Vasiliauskas';

COMMIT;
*/

/*-- 8 užduotis: kvalifikacijos reitingavimas naudojant DECODE
SELECT Pavarde,
       Kvalifikacija,
       DECODE(Kvalifikacija,
              'Informatikas', 'A',
              'Statistikas', 'B',
              'Inžinierius', 'C',
              'Vadybininkas', 'E',
              '0') AS Reitingas
FROM Vykdytojai;
*/

/*-- 9 užduotis: tas pats reitingavimas naudojant CASE
SELECT Pavarde,
       Kvalifikacija,
       CASE
         WHEN Kvalifikacija = 'Informatikas' THEN 'A'
         WHEN Kvalifikacija = 'Statistikas' THEN 'B'
         WHEN Kvalifikacija = 'Inžinierius' THEN 'C'
         WHEN Kvalifikacija = 'Vadybininkas' THEN 'E'
         ELSE '0'
       END AS Reitingas
FROM Vykdytojai;
*/