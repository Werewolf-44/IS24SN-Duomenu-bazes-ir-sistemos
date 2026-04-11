-- Bandom ištrinti lentelę Projektai (jei nėra – klaida ignoruojama)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Projektai';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Bandom ištrinti lentelę Vykdytojai
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Vykdytojai';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Sukuriama lentelė Projektai
CREATE TABLE Projektai (
  Nr           NUMBER(2) PRIMARY KEY,   -- unikalus projekto numeris
  Pavadinimas  VARCHAR2(100) NOT NULL,  -- projekto pavadinimas
  Pradzia      DATE,                    -- projekto pradžios data
  Trukme       NUMBER(4)                -- projekto trukmė
);

-- Sukuriama lentelė Vykdytojai
CREATE TABLE Vykdytojai (
  Nr             NUMBER(2) PRIMARY KEY, -- unikalus vykdytojo numeris
  Pavarde        VARCHAR2(50) NOT NULL, -- pavardė
  Kvalifikacija  VARCHAR2(30),          -- pareigos
  Kategorija     NUMBER(2),             -- kategorija
  Issilavinimas  VARCHAR2(10)           -- išsilavinimas
);

-- Įterpiami projektų duomenys
INSERT INTO Projektai (Nr, Pavadinimas, Pradzia, Trukme)
VALUES (1, 'Apskaitos sistema', DATE '2024-01-15', 6);

INSERT INTO Projektai (Nr, Pavadinimas, Pradzia, Trukme)
VALUES (2, 'Personalo sistema', DATE '2024-03-01', 12);

INSERT INTO Projektai (Nr, Pavadinimas, Pradzia, Trukme)
VALUES (3, 'Klientu portalas', DATE '2023-11-10', 4);

INSERT INTO Projektai (Nr, Pavadinimas, Pradzia, Trukme)
VALUES (4, 'Sandelio modulis', DATE '2024-05-20', 8);

INSERT INTO Projektai (Nr, Pavadinimas, Pradzia, Trukme)
VALUES (5, 'Ataskaitu posisteme', DATE '2024-02-05', 10);

-- Įterpiami vykdytojų duomenys
INSERT INTO Vykdytojai (Nr, Pavarde, Kvalifikacija, Kategorija, Issilavinimas)
VALUES (1, 'Jonaitis', 'Programuotojas', 2, 'VIKO');

INSERT INTO Vykdytojai (Nr, Pavarde, Kvalifikacija, Kategorija, Issilavinimas)
VALUES (2, 'Petraitis', 'Analitikas', 3, 'VU');

INSERT INTO Vykdytojai (Nr, Pavarde, Kvalifikacija, Kategorija, Issilavinimas)
VALUES (3, 'Kazlauskas', 'Testuotojas', 2, 'VIKO');

INSERT INTO Vykdytojai (Nr, Pavarde, Kvalifikacija, Kategorija, Issilavinimas)
VALUES (4, 'Jankauskaite', 'Programuotoja', 4, 'KTU');

INSERT INTO Vykdytojai (Nr, Pavarde, Kvalifikacija, Kategorija, Issilavinimas)
VALUES (5, 'Vasiliauskas', 'Administratorius', 3, 'VU');

INSERT INTO Vykdytojai (Nr, Pavarde, Kvalifikacija, Kategorija, Issilavinimas)
VALUES (6, 'Mikalauskaite', 'Analitike', 1, 'VGTU');

-- Išsaugomi pakeitimai
COMMIT;

-- Parodomi visi duomenys iš lentelių
SELECT * FROM Projektai;
SELECT * FROM Vykdytojai;

-- UŽDUOTYS --

/*-- 1 užduotis: projektai, kurių trukmė didesnė nei įvesta (pvz: 8)
SELECT Pavadinimas, Pradzia, Trukme
FROM Projektai
WHERE Trukme > &Trukme;  -- įvedama trukmė
*/

/* -- 2 užduotis: vykdytojai pagal įvestą išsilavinimą, su rikiavimu (pvz: VIKO, PAVARDE)
SELECT Nr, Pavarde, Kvalifikacija, Kategorija, Issilavinimas
FROM Vykdytojai
WHERE Issilavinimas = '&Issilavinimas'  -- įvedamas išsilavinimas
ORDER BY &Rikiavimo_stulpelis;          -- įvedamas rikiavimo stulpelis
*/

/*-- 3 užduotis: rodomi tik 2 stulpeliai (pavardė + pasirinktas) (pvz: VIKO, NR,  PAVARDE)
SELECT Pavarde, &Stulpelis
FROM Vykdytojai
WHERE Issilavinimas = '&Issilavinimas'  -- įvedamas išsilavinimas
ORDER BY &Rikiavimo_stulpelis;          -- įvedamas rikiavimo stulpelis
*/