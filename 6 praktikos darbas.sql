/*-- 1 užduotis: įvedus darbuotojo pavardę, parodyti kitus to paties skyriaus darbuotojus
-- 1) vidinė užklausa suranda, kuriame skyriuje dirba įvestas darbuotojas
-- 2) išorinė užklausa parodo visus to skyriaus darbuotojus
-- 3) papildomai atmetame patį įvestą darbuotoją

SELECT Pavarde,
       Idarbinimo_data
FROM Atlyginimai
WHERE Skyrius =
      (SELECT Skyrius
       FROM Atlyginimai
       WHERE Pavarde = '&Pavarde')
AND Pavarde <> '&Pavarde';
*/

/*-- 2 užduotis: parodyti darbuotojus, kurių atlyginimas didesnis už visų darbuotojų vidurkį
-- 1) vidinė užklausa apskaičiuoja visų darbuotojų vidutinį atlyginimą
-- 2) išorinė užklausa atrenka tik tuos, kurių atlyginimas didesnis
-- 3) gale rikiuojame nuo mažesnio iki didesnio atlyginimo

SELECT Sutarties_Nr,
       Pavarde,
       Atlyginimas
FROM Atlyginimai
WHERE Atlyginimas >
      (SELECT AVG(Atlyginimas)
       FROM Atlyginimai)
ORDER BY Atlyginimas ASC;
*/

/*-- 3 užduotis: parodyti darbuotojus, kurie dirba tame pačiame skyriuje
-- kaip darbuotojas, kurio pavardė baigiasi '-is'
-- 1) vidinė užklausa suranda skyrių darbuotojo, kurio pavardė baigiasi 'is'
-- 2) išorinė užklausa išrenka visus to skyriaus darbuotojus

SELECT Sutarties_Nr,
       Pavarde
FROM Atlyginimai
WHERE Skyrius IN
      (SELECT Skyrius
       FROM Atlyginimai
       WHERE Pavarde LIKE '%is');
*/

/*-- 4 užduotis: įvedus Vietos_Id, parodyti tų skyrių darbuotojus
-- 1) lentelėje Skyrius surandame, kurie skyriai turi įvestą Vietos_Id
-- 2) iš lentelės Atlyginimai paimame darbuotojus, kurie dirba tuose skyriuose

SELECT Pavarde,
       Skyrius,
       Pareigos
FROM Atlyginimai
WHERE Skyrius IN
      (SELECT Kodas
       FROM Skyrius
       WHERE Vietos_Id = &Vietos_Id);
*/

/*-- 5 užduotis: įvedus viršininko pavardę, parodyti jo darbuotojus
-- 1) vidinė užklausa suranda įvesto viršininko sutarties numerį
-- 2) išorinė užklausa atrenka tuos darbuotojus, kurių stulpelyje Vadovas yra tas numeris

SELECT Pavarde,
       Atlyginimas
FROM Atlyginimai
WHERE Vadovas =
      (SELECT Sutarties_Nr
       FROM Atlyginimai
       WHERE Pavarde = '&Vadovo_pavarde');
*/

/*-- 6 užduotis: parodyti darbuotojus, kurie:
-- 1) dirba tame pačiame skyriuje kaip darbuotojas, kurio pavardė baigiasi 'is'
-- 2) ir kurių atlyginimas didesnis už bendrą atlyginimų vidurkį
-- čia sujungiame dvi sąlygas:
-- - viena vidinė užklausa randa reikiamą skyrių / skyrius
-- - kita vidinė užklausa randa bendrą atlyginimų vidurkį

SELECT Sutarties_Nr,
       Pavarde,
       Atlyginimas
FROM Atlyginimai
WHERE Skyrius IN
      (SELECT Skyrius
       FROM Atlyginimai
       WHERE Pavarde LIKE '%is')
AND Atlyginimas >
      (SELECT AVG(Atlyginimas)
       FROM Atlyginimai);
*/


-- Sukuriamos papildomos lentelės: PROJEKTAI ir VYKDYMAS

/*BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Vykdymas';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Projektai';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Projektų lentelė
CREATE TABLE Projektai (
  Nr           NUMBER(2) PRIMARY KEY,
  Pavadinimas  VARCHAR2(100) NOT NULL,
  Pradzia      DATE,
  Trukme       NUMBER(4)
);

-- Ryšio lentelė tarp vykdytojų ir projektų
CREATE TABLE Vykdymas (
  Projektas_Nr   NUMBER(2),
  Vykdytojas_Nr  NUMBER(2),
  Statusas       VARCHAR2(30),
  Valandos       NUMBER(4)
);

-- Projektai
INSERT INTO Projektai VALUES (1, 'Apskaitos sistema',   DATE '2024-01-15', 6);
INSERT INTO Projektai VALUES (2, 'Personalo sistema',   DATE '2024-03-01', 12);
INSERT INTO Projektai VALUES (3, 'Klientu portalas',    DATE '2023-11-10', 4);
INSERT INTO Projektai VALUES (4, 'Sandelio modulis',    DATE '2024-05-20', 8);
INSERT INTO Projektai VALUES (5, 'Ataskaitu posisteme', DATE '2024-02-05', 10);

-- Vykdymas
-- Naudojami vykdytojų numeriai, kurie turi sutapti su jau esančia lentele Vykdytojai
INSERT INTO Vykdymas VALUES (1, 1, 'Vadovas',         120);
INSERT INTO Vykdymas VALUES (1, 2, 'Analitikas',       80);
INSERT INTO Vykdymas VALUES (2, 1, 'Programuotojas',   60);
INSERT INTO Vykdymas VALUES (2, 3, 'Testuotojas',      90);
INSERT INTO Vykdymas VALUES (3, 2, 'Vadovas',         110);
INSERT INTO Vykdymas VALUES (3, 4, 'Programuotoja',    95);
INSERT INTO Vykdymas VALUES (4, 5, 'Vadovas',         130);
INSERT INTO Vykdymas VALUES (4, 6, 'Analitike',        70);
INSERT INTO Vykdymas VALUES (5, 1, 'Programuotojas',   75);
INSERT INTO Vykdymas VALUES (5, 3, 'Vadovas',         100);

COMMIT;
*/

/*-- 7 užduotis: parodyti visus projektus ir ar vykdytojas Nr. 1 juose dalyvauja
-- einame per visus projektus ir tikriname, ar projekto numeris yra tarp tų,
-- kuriuose dalyvauja vykdytojas Nr. 1

SELECT P.Nr,
       P.Pavadinimas,
       CASE
         WHEN P.Nr IN (
              SELECT Projektas_Nr
              FROM Vykdymas
              WHERE Vykdytojas_Nr = 1
         ) THEN 'Dalyvauja'
         ELSE 'Nedalyvauja'
       END AS Dalyvavimas
FROM Projektai P;
*/

/*-- 8 užduotis: parodyti vykdytojų pavardes, kurie dalyvauja bent dviejuose projektuose
-- vidinė užklausa suskaičiuoja, kiek projektų turi kiekvienas vykdytojas,
-- o išorinė užklausa pagal vykdytojo numerį paima jo pavardę

SELECT Pavarde
FROM Vykdytojai
WHERE Nr IN (
    SELECT Vykdytojas_Nr
    FROM Vykdymas
    GROUP BY Vykdytojas_Nr
    HAVING COUNT(*) >= 2
);
*/

/*-- 9 užduotis: parodyti vykdytojų pavardes, kurie vadovauja bent vienam projektui
-- laikome, kad projekto vadovas yra tas, kurio statusas = 'Vadovas'
-- todėl vidinė užklausa suranda tokių vykdytojų numerius

SELECT Pavarde
FROM Vykdytojai
WHERE Nr IN (
    SELECT Vykdytojas_Nr
    FROM Vykdymas
    WHERE Statusas = 'Vadovas'
);
*/

/*-- 10 užduotis: parodyti vykdytojų pavardes, kurių bendras valandų skaičius
-- didesnis už visų vykdytojų bendrų valandų vidurkį
-- 1) pirmiausia suskaičiuojame kiekvieno vykdytojo bendrą valandų sumą
-- 2) tada iš tų sumų paimame vidurkį
-- 3) paliekame tik tuos vykdytojus, kurių suma didesnė už tą vidurkį

SELECT Pavarde
FROM Vykdytojai
WHERE Nr IN (
    SELECT Vykdytojas_Nr
    FROM Vykdymas
    GROUP BY Vykdytojas_Nr
    HAVING SUM(Valandos) > (
        SELECT AVG(Suma_valandu)
        FROM (
            SELECT SUM(Valandos) AS Suma_valandu
            FROM Vykdymas
            GROUP BY Vykdytojas_Nr
        )
    )
);
*/