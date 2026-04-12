/*-- 1 užduotis: rasti bendrą atlyginimų statistiką (max, min, suma, vidurkis)
SELECT 
  ROUND(MAX(Atlyginimas)) AS Didziausias,  -- didžiausia reikšmė
  ROUND(MIN(Atlyginimas)) AS Maziausias,   -- mažiausia reikšmė
  ROUND(SUM(Atlyginimas)) AS Suma,         -- visų suma
  ROUND(AVG(Atlyginimas)) AS Vidurkis      -- vidurkis
FROM Atlyginimai;
*/

/*-- 2 užduotis: sugrupuoti darbuotojus pagal pareigas ir paskaičiuoti statistiką kiekvienai grupei

-- pridedam pareigų stulpelį
ALTER TABLE Atlyginimai ADD Pareigos VARCHAR2(30);

-- užpildom duomenis (kad būtų pasikartojančių pareigų)
UPDATE Atlyginimai SET Pareigos='Programuotojas' WHERE Sutarties_Nr IN (1001,1004);
UPDATE Atlyginimai SET Pareigos='Analitikas' WHERE Sutarties_Nr IN (1002,1006);
UPDATE Atlyginimai SET Pareigos='Testuotojas' WHERE Sutarties_Nr=1003;
UPDATE Atlyginimai SET Pareigos='Administratorius' WHERE Sutarties_Nr=1005;

COMMIT;

-- skaičiavimai kiekvienai pareigų grupei
SELECT Pareigos,
       ROUND(MAX(Atlyginimas)) AS Didziausias,
       ROUND(MIN(Atlyginimas)) AS Maziausias,
       ROUND(AVG(Atlyginimas)) AS Vidurkis
FROM Atlyginimai
GROUP BY Pareigos;  -- padalina duomenis į grupes
*/

/*-- 3 užduotis: suskaičiuoti kiek darbuotojų yra kiekvienoje pareigų grupėje
SELECT Pareigos,
       COUNT(*) AS Kiekis   -- kiek eilučių kiekvienoje grupėje
FROM Atlyginimai
GROUP BY Pareigos;
*/

/*-- 4 užduotis: leisti įvesti pareigas ir suskaičiuoti tik jų darbuotojus
SELECT Pareigos,
       COUNT(*) AS Kiekis
FROM Atlyginimai
WHERE Pareigos = '&Pareigos'  -- įvedi pvz. Programuotojas
GROUP BY Pareigos;
*/

/*-- 5 užduotis: rasti skirtumą tarp didžiausio ir mažiausio atlyginimo
SELECT MAX(Atlyginimas) - MIN(Atlyginimas) AS Skirtumas
FROM Atlyginimai;
*/

/*-- 6 užduotis: priskirti skyrius ir rasti tik tuos skyrius, kur vidurkis > 1000

ALTER TABLE Atlyginimai ADD Skyrius VARCHAR2(10);

UPDATE Atlyginimai SET Skyrius='ADMIN' WHERE Sutarties_Nr IN (1001,1002);
UPDATE Atlyginimai SET Skyrius='BUH' WHERE Sutarties_Nr IN (1003);
UPDATE Atlyginimai SET Skyrius='SAND1' WHERE Sutarties_Nr IN (1004);
UPDATE Atlyginimai SET Skyrius='SAND2' WHERE Sutarties_Nr IN (1005,1006);

COMMIT;

SELECT Skyrius,
       AVG(Atlyginimas) AS Vidurkis
FROM Atlyginimai
GROUP BY Skyrius
HAVING AVG(Atlyginimas) > 1000;  -- filtruoja jau grupes
*/

/*-- 7 užduotis: rasti pareigas (be "ininkas") kurių vidutinis atlyginimas < 900
SELECT Pareigos,
       AVG(Atlyginimas) AS Vidurkis
FROM Atlyginimai
WHERE Pareigos NOT LIKE '%ininkas%'  -- atmeta žodžius su "ininkas"
GROUP BY Pareigos
HAVING AVG(Atlyginimas) < 900;
*/

/*-- 8 užduotis: rasti vadovus ir jų darbuotojų mažiausią atlyginimą (>1000)

ALTER TABLE Atlyginimai ADD Vadovas NUMBER(5);

-- priskiriam vadovus
UPDATE Atlyginimai SET Vadovas=1001 WHERE Sutarties_Nr IN (1002,1003);
UPDATE Atlyginimai SET Vadovas=1004 WHERE Sutarties_Nr IN (1005,1006);

COMMIT;

SELECT Vadovas,
       MIN(Atlyginimas) AS Min_Atlyginimas
FROM Atlyginimai
WHERE Vadovas IS NOT NULL
GROUP BY Vadovas
HAVING MIN(Atlyginimas) >= 1000  -- tik tinkantys vadovai
ORDER BY Min_Atlyginimas DESC;
*/

/*-- 9 užduotis: suskaičiuoti kiek darbuotojų įdarbinta kiekvienais metais
SELECT 
  EXTRACT(YEAR FROM Idarbinimo_data) AS Metai, -- paima metus iš datos
  COUNT(*) AS Kiekis
FROM Atlyginimai
GROUP BY EXTRACT(YEAR FROM Idarbinimo_data)
ORDER BY Metai;
*/