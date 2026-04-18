-- 1 užduotis: sukurti neunikalų indeksą lentelės Atlyginimai stulpeliui Vardas
-- sukuriame indeksą stulpeliui Vardas

CREATE INDEX Atlyginimai_Vardas_ind
ON Atlyginimai (Vardas);

-- 2 užduotis: sukurti sinonimą lentelei Atlyginimai pavadinimu DARB
-- sukuriame trumpesnį alternatyvų vardą lentelei Atlyginimai

DROP SYNONYM DARB;
CREATE SYNONYM DARB FOR Atlyginimai;

-- 2 užduoties tęsinys: naudojant sinonimą parodyti visus darbuotojų duomenis
-- kreipiamės ne į Atlyginimai, o į jos sinonimą DARB

SELECT *
FROM DARB;