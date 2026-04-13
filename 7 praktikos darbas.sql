/*-- 1 užduotis: sukurti lentelę Karjera, ją užpildyti ir turėti duomenis tolimesnėms užduotims
-- 1) sukuriame lentelę, kur saugosime ankstesnes darbuotojų pareigas ir skyrius
-- 2) įrašome 10 eilučių
-- 3) naudojame jau turimus darbuotojų sutarties numerius iš lentelės Atlyginimai

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Karjera';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE Karjera (
  Sutarties_Nr  NUMBER(5),
  Pradzios_data DATE NOT NULL,
  Pabaigos_data DATE NOT NULL,
  Pareigos      VARCHAR2(30) NOT NULL,
  Skyrius       VARCHAR2(10)
);

-- Jonaitis
INSERT INTO Karjera VALUES (1001, DATE '2020-01-10', DATE '2021-12-31', 'Testuotojas',     'ADMIN');
INSERT INTO Karjera VALUES (1001, DATE '2022-01-01', DATE '2023-12-31', 'Analitikas',      'BUH');

-- Petraitis
INSERT INTO Karjera VALUES (1002, DATE '2021-02-01', DATE '2022-12-31', 'Analitikas',      'ADMIN');
INSERT INTO Karjera VALUES (1002, DATE '2023-01-01', DATE '2023-12-31', 'Programuotojas',  'IT');

-- Kazlauskas
INSERT INTO Karjera VALUES (1003, DATE '2019-05-01', DATE '2021-05-31', 'Testuotojas',     'BUH');

-- Jankauskaite
INSERT INTO Karjera VALUES (1004, DATE '2018-03-15', DATE '2020-06-30', 'Programuotoja',   'SAND1');
INSERT INTO Karjera VALUES (1004, DATE '2020-07-01', DATE '2022-12-31', 'Analitike',       'SAND2');

-- Vasiliauskas
INSERT INTO Karjera VALUES (1005, DATE '2022-02-05', DATE '2023-02-28', 'Administratorius','ADMIN');

-- Mikalauskaite
INSERT INTO Karjera VALUES (1006, DATE '2023-04-12', DATE '2024-01-31', 'Analitike',       'SAND2');
INSERT INTO Karjera VALUES (1006, DATE '2024-02-01', DATE '2024-09-30', 'Testuotoja',      'BUH');

COMMIT;

-- Pasitikrinimui
SELECT * FROM Karjera;
*/


/*-- 2 užduotis: parodyti skyrius, kuriuose NERA pareigybes 'Administratorius'
-- 1) iš Atlyginimai paimame visus skyrius
-- 2) atimame tuos skyrius, kuriuose yra Administratorius

SELECT Skyrius
FROM Atlyginimai
MINUS
SELECT Skyrius
FROM Atlyginimai
WHERE Pareigos = 'Administratorius';
*/

/*-- 3 užduotis: parodyti miestus, kuriuose nera jokio imones skyriaus
-- 1) iš Vieta paimame visus miestus
-- 2) per jungti su Skyrius surandame miestus, kuriuose skyrius yra
-- 3) su MINUS atimame tuos miestus, kuriuose jau yra skyrius

SELECT Miestas
FROM Vieta
MINUS
SELECT V.Miestas
FROM Vieta V
JOIN Skyrius S
ON V.Vietos_Id = S.Vietos_Id;
*/

/*-- 4 užduotis: parodyti pareigas skyriuose ADMIN ir BUH
-- 1) paimame pareigas is ADMIN
-- 2) su UNION prijungiame pareigas is BUH

SELECT Pareigos, Skyrius
FROM Atlyginimai
WHERE Skyrius = 'ADMIN'

UNION

SELECT Pareigos, Skyrius
FROM Atlyginimai
WHERE Skyrius = 'BUH';
*/

/*-- 5 užduotis: parodyti darbuotojus, kurie siandien vel dirba tomis paciomis pareigomis,
-- kuriomis buvo idarbinti is pradziu
-- 1) is dabartines lenteles Atlyginimai paimame darbuotojo numeri ir dabartines pareigas
-- 2) is Karjera paimame jo ankstesnes pareigas
-- 3) INTERSECT palieka tik tas poras, kurios sutampa abiejose uzklausose
-- Kitaip tariant:
-- darbuotojas kadaise dirbo tomis pareigomis ir dabar vel dirba tomis paciomis

SELECT Sutarties_Nr, Pareigos
FROM Atlyginimai

INTERSECT

SELECT Sutarties_Nr, Pareigos
FROM Karjera;
*/

/*-- 6 užduotis: sudaryti viena bendra sarasa is dvieju skirtingu lenteliu
-- 1) pirmoje dalyje rodome darbuotojo pavarde ir jo skyriaus koda is Atlyginimai
-- 2) antroje dalyje rodome skyriaus koda ir skyriaus pavadinima is Skyrius
-- Kadangi UNION reikalauja to paties stulpeliu skaiciaus ir suderinamu tipu,
-- abiejose SELECT dalyse pateikiame po 2 tekstinius stulpelius

SELECT Pavarde AS Pirmas_laukas,
       Skyrius AS Antras_laukas
FROM Atlyginimai

UNION

SELECT Kodas AS Pirmas_laukas,
       Pavadinimas AS Antras_laukas
FROM Skyrius;
*/
