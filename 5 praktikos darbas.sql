/*-- 1 užduotis: sukurti lenteles Skyrius ir Vieta, jas užpildyti,
-- tada per NATURAL JOIN parodyti skyriaus kodą, pavadinimą, gatvę ir miestą

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Skyrius';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Vieta';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Lentelė skyriams
CREATE TABLE Skyrius (
  Kodas       VARCHAR2(10) PRIMARY KEY,
  Pavadinimas VARCHAR2(50),
  Vietos_Id   NUMBER(3)
);

-- Lentelė vietoms
CREATE TABLE Vieta (
  Vietos_Id NUMBER(3) PRIMARY KEY,
  Gatve     VARCHAR2(50),
  Miestas   VARCHAR2(30)
);

-- Vietos
INSERT INTO Vieta VALUES (1, 'Gedimino pr. 1', 'Vilnius');
INSERT INTO Vieta VALUES (2, 'Laisves al. 10', 'Kaunas');
INSERT INTO Vieta VALUES (3, 'Klaipedos g. 5', 'Klaipeda');
INSERT INTO Vieta VALUES (4, 'Siauliu g. 8', 'Siauliai');
INSERT INTO Vieta VALUES (5, 'Panevezio g. 3', 'Panevezys');

-- Skyriai
INSERT INTO Skyrius VALUES ('ADMIN', 'Administracija', 1);
INSERT INTO Skyrius VALUES ('BUH',   'Buhalterija',    2);
INSERT INTO Skyrius VALUES ('SAND1', 'Sandelis 1',     3);
INSERT INTO Skyrius VALUES ('SAND2', 'Sandelis 2',     4);
INSERT INTO Skyrius VALUES ('IT',    'Informacines sistemos', 5);

COMMIT;

-- NATURAL JOIN jungia pagal vienodą stulpelį Vietos_Id
SELECT Kodas,
       Pavadinimas,
       Gatve,
       Miestas
FROM Skyrius
NATURAL JOIN Vieta;
*/

/*-- 2 užduotis: parodyti visų darbuotojų vardus, pavardes,
-- jų skyriaus kodus ir skyrių pavadinimus

SELECT A.Vardas,
       A.Pavarde,
       A.Skyrius,
       S.Pavadinimas
FROM Atlyginimai A
JOIN Skyrius S
ON A.Skyrius = S.Kodas;
*/

/*-- 3 užduotis: parodyti tik Vilniuje dirbančių darbuotojų
-- vardus, pavardes, pareigas, skyriaus kodus ir pavadinimus

SELECT A.Vardas,
       A.Pavarde,
       A.Pareigos,
       A.Skyrius,
       S.Pavadinimas
FROM Atlyginimai A
JOIN Skyrius S
ON A.Skyrius = S.Kodas
JOIN Vieta V
ON S.Vietos_Id = V.Vietos_Id
WHERE V.Miestas = 'Vilnius';
*/

/*-- 4 užduotis: parodyti darbuotojo pavardę ir jo viršininko pavardę
-- čia lentelė Atlyginimai jungiama pati su savimi

SELECT D.Pavarde AS Darbuotojas,
       V.Pavarde AS Virsininkas
FROM Atlyginimai D
JOIN Atlyginimai V
ON D.Vadovas = V.Sutarties_Nr;
*/

/*-- 5 užduotis: parodyti darbuotojo pavardę ir sutarties numerį,
-- taip pat jo vadovo pavardę ir sutarties numerį

SELECT D.Pavarde AS Darbuotojas,
       D.Sutarties_Nr AS "Darb#",
       V.Pavarde AS Vadovas,
       V.Sutarties_Nr AS "Vad#"
FROM Atlyginimai D
JOIN Atlyginimai V
ON D.Vadovas = V.Sutarties_Nr;
*/

/*-- 6 užduotis: ta pati 5 užduotis, bet rodyti ir darbuotojus,
-- kurie neturi vadovo

SELECT D.Pavarde AS Darbuotojas,
       D.Sutarties_Nr AS "Darb#",
       V.Pavarde AS Vadovas,
       V.Sutarties_Nr AS "Vad#"
FROM Atlyginimai D
LEFT OUTER JOIN Atlyginimai V
ON D.Vadovas = V.Sutarties_Nr
ORDER BY D.Sutarties_Nr;
*/

/*-- 7 užduotis: parodyti skyriaus kodą, darbuotojo pavardę
-- ir kitų tame pačiame skyriuje dirbančių darbuotojų pavardes

SELECT A.Skyrius,
       A.Pavarde AS Darbuotojas,
       B.Pavarde AS Bendradarbis
FROM Atlyginimai A
JOIN Atlyginimai B
ON A.Skyrius = B.Skyrius
AND A.Sutarties_Nr <> B.Sutarties_Nr   -- kad nerodytų to paties darbuotojo su savimi
ORDER BY A.Skyrius, A.Pavarde;
*/

/*-- 8 užduotis: sukurti lentelę Kategorijos ir pagal atlyginimo intervalą
-- priskirti kategorijos lygį

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Kategorijos';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE Kategorijos (
  Min_Atlyginimas NUMBER(8,2),
  Max_Atlyginimas NUMBER(8,2),
  Lygis           VARCHAR2(10)
);

INSERT INTO Kategorijos VALUES (0,    1199.99, 'C');
INSERT INTO Kategorijos VALUES (1200, 1399.99, 'B');
INSERT INTO Kategorijos VALUES (1400, 1599.99, 'A');
INSERT INTO Kategorijos VALUES (1600, 9999.99, 'A+');

COMMIT;

-- Teta jungtis: naudojamas BETWEEN, o ne lygybė
SELECT A.Pavarde,
       A.Atlyginimas,
       K.Lygis
FROM Atlyginimai A
JOIN Kategorijos K
ON A.Atlyginimas BETWEEN K.Min_Atlyginimas AND K.Max_Atlyginimas;
*/

/*-- 9 užduotis: parodyti darbuotojo vardą, pavardę, pareigas,
-- skyriaus pavadinimą, atlyginimą ir kategorijos lygį

SELECT A.Vardas,
       A.Pavarde,
       A.Pareigos,
       S.Pavadinimas AS Skyrius,
       A.Atlyginimas,
       K.Lygis
FROM Atlyginimai A
JOIN Skyrius S
ON A.Skyrius = S.Kodas
JOIN Kategorijos K
ON A.Atlyginimas BETWEEN K.Min_Atlyginimas AND K.Max_Atlyginimas;
*/

/*-- 10 užduotis: parodyti darbuotojus, kurie įdarbinti vėliau negu Petraitis

SELECT Pavarde,
       Idarbinimo_data
FROM Atlyginimai
WHERE Idarbinimo_data >
      (SELECT Idarbinimo_data
       FROM Atlyginimai
       WHERE Pavarde = 'Petraitis');
*/

/*-- 11 užduotis: parodyti darbuotojus, kurie įdarbinti anksčiau negu jų vadovai

SELECT D.Pavarde,
       D.Idarbinimo_data,
       V.Pavarde AS Vadovas,
       V.Idarbinimo_data AS Vadovo_idarbinimo_data
FROM Atlyginimai D
JOIN Atlyginimai V
ON D.Vadovas = V.Sutarties_Nr
WHERE D.Idarbinimo_data < V.Idarbinimo_data;
*/