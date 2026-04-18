-- 1 užduotis: sukurti rodinį Darbuotojai_INFO iš lentelės Atlyginimai
-- 1) sukuriame rodinį, kuris rodo tik 3 stulpelius iš Atlyginimai
-- 2) dviem stulpeliams suteikiame naujus pavadinimus

CREATE OR REPLACE VIEW Darbuotojai_INFO (Darbuotojo_Id, Darbuotojas, Skyrius)
AS
SELECT Sutarties_Nr, Pavarde, Skyrius
FROM Atlyginimai;

-- 2 užduotis: patikrinti, ar rodinys Darbuotojai_INFO veikia
-- tiesiog išvedame visą rodinio turinį

SELECT *
FROM Darbuotojai_INFO;

-- 3 užduotis: naudojant rodinį Darbuotojai_INFO parodyti darbuotojų pavardes ir skyrius
-- nebeiname tiesiai į Atlyginimai, o naudojame ką tik sukurtą rodinį

SELECT Darbuotojas,
       Skyrius
FROM Darbuotojai_INFO;

-- 4 užduotis: sukurti rodinį Skyrius_ADMIN tik ADMIN skyriaus darbuotojams
-- 1) sukuriame rodinį tik tiems darbuotojams, kurių Skyrius = 'ADMIN'
-- 2) stulpeliams suteikiame tokius pavadinimus, kokių prašo užduotis

CREATE OR REPLACE VIEW Skyrius_ADMIN (Nr, Darbuotojas, Skyrius)
AS
SELECT Sutarties_Nr, Pavarde, Skyrius
FROM Atlyginimai
WHERE Skyrius = 'ADMIN';

-- 5 užduotis: pratestuoti rodinį Skyrius_ADMIN, bandant perkelti ADMIN darbuotoją į BUH
-- bandome per rodinį pakeisti vieno ADMIN darbuotojo skyrių į BUH

UPDATE Skyrius_ADMIN
SET Skyrius = 'BUH'
WHERE Nr = 1001;

-- 6 užduotis: neleisti per rodinį Skyrius_ADMIN prieiti prie kitų skyrių duomenų
-- perrašome rodinį su WITH CHECK OPTION
-- ši frazė neleidžia per rodinį pakeisti duomenų taip,
-- kad eilutė "iškristų" iš rodinio sąlygos
-- Pvz. jei rodinys skirtas tik ADMIN, nebegalėsime per jį pakeisti Skyrius į BUH

CREATE OR REPLACE VIEW Skyrius_ADMIN (Nr, Darbuotojas, Skyrius)
AS
SELECT Sutarties_Nr, Pavarde, Skyrius
FROM Atlyginimai
WHERE Skyrius = 'ADMIN'
WITH CHECK OPTION CONSTRAINT Skyrius_ADMIN_ck;

-- 7 užduotis: peržiūrėti rodinio Skyrius_ADMIN struktūrą ir jo turinį
-- 1) DESCRIBE parodo rodinio stulpelius ir jų tipus
-- 2) SELECT parodo pačius duomenis

DESC Skyrius_ADMIN;

SELECT *
FROM Skyrius_ADMIN;

-- 8 užduotis: dar kartą pratestuoti rodinį Skyrius_ADMIN,
-- bandant konkretų ADMIN darbuotoją perkelti į BUH
-- po WITH CHECK OPTION šitas veiksmas turėtų būti nebeleidžiamas

UPDATE Skyrius_ADMIN
SET Skyrius = 'BUH'
WHERE Nr = 1002;