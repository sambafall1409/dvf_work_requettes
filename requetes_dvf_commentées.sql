
-- ============================================================================
--  ANALYSE DES MUTATIONS IMMOBILIÈRES - DÉPARTEMENT 37 (DVF)
--  Auteur : Samba FALL
--  Description : Requêtes SQL pour explorer les mutations et locaux du DVF.
-- ============================================================================
-- 🔄 Vue brute des tables
SELECT * FROM ds_dvf_d37.mutation;
SELECT * FROM ds_dvf_d37.adresse_local;

-- 🔍 Requête de test sur une mutation spécifique
SELECT * 
FROM ds_dvf_d37.mutation 
WHERE idmutation = '7466392';

-- 🏠 Appartements type 1210 (standard)
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('1210')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 🏢 Appartements type 120 (collectif simplifié)
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('120')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 🏘️ Appartements par sous-catégories de 1211x à 1213x
-- Type 1211x
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('12111','12112','12113','12114','12115','12110')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- Type 1212x
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('12121','12122','12123','12124','12125','12120')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- Type 1213x
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('12131','12132','12133','12134','12135','12130')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 🧱 Appartements groupés type 122x
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('1220','1221','1222','1223','1224','1229')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 📊 Nombre d'appartements par ancienneté
SELECT l.anciennete, COUNT(*) AS nb_appartements
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('1220','1221','1222','1223','1224','1229')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance'
GROUP BY l.anciennete;

-- 🏢 Appartements type 123
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('123')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 🧬 Cas spécifiques - Appartements sans données d'âge
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('1210')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 🧬 Cas spécifiques - Type 1214
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('1214')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 📊 Répartition par nombre de pièces principales
SELECT l.nbpprinc, COUNT(*) AS nb_appartements
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('1220','1221','1222','1223','1224','1229')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance'
GROUP BY l.nbpprinc
ORDER BY l.nbpprinc;

-- 🧾 Vue mutation - Appartements (type 122x)
SELECT m.*
FROM ds_dvf_d37.mutation m
WHERE m.codtypbien IN ('1220', '1221', '1222', '1223', '1224', '1229')
  AND m.idnatmut IN (1, 2, 4);

-- 🧾 Vue mutation - Catégorie 1211x
SELECT m.*
FROM ds_dvf_d37.mutation m
WHERE m.codtypbien IN ('12111','12112','12113','12114','12115','12110')
  AND m.idnatmut IN (1, 2, 4);

-- 🧾 Vue mutation - Catégorie 1212x avec terrain
SELECT m.*
FROM ds_dvf_d37.mutation m
WHERE m.codtypbien IN ('12121','12122','12123','12124','12125','12120')
  AND m.idnatmut IN (1, 2, 4)
  AND m.ffsparc <> 0;

-- 🧾 Vue mutation - Catégorie 1213x avec terrain
SELECT m.*
FROM ds_dvf_d37.mutation m
WHERE m.codtypbien IN ('12131','12132','12133','12134','12135','12130')
  AND m.idnatmut IN (1, 2, 4)
  AND m.ffsparc <> 0;

-- 🧬 Mutations sans période de construction
SELECT m.*
FROM ds_dvf_d37.mutation m
WHERE m.codtypbien IN ('1210')
  AND m.idnatmut IN (1, 2, 4)
  AND m.periodecst IS NULL;

-- 🔎 Locaux liés aux mutations sans dépendance
SELECT l.*
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('1210')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance';

-- 🏢 Appartements type 123 - agrégation par nblocapt
SELECT m.nblocapt, COUNT(*) 
FROM ds_dvf_d37.mutation m
WHERE m.codtypbien IN ('123')
  AND m.idnatmut IN (1, 2, 4)
GROUP BY m.nblocapt;
----------------------------------------------------------------------------------------------------------nbappartements part typologie et année
SELECT l.nbpprinc,l.anneemut, count(*)
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('12121','12122','12123','12124','12125','12120')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance'
  group by l.nbpprinc,l.anneemut
  order by l.anneemut

-----------------evolution appartement neuf vefa  
SELECT l.nbpprinc,l.anneemut, count(*)
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('12111','12112','12113','12114','12115','12110')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance'
  group by l.nbpprinc,l.anneemut
  order by l.anneemut
---------------------------evolution appartement anciens
-----------------evolution appartement neuf vefa  
SELECT l.nbpprinc,l.anneemut, count(*)
FROM ds_dvf_d37.local l
INNER JOIN ds_dvf_d37.mutation m ON l.idmutation = m.idmutation
WHERE m.codtypbien IN ('12131','12132','12133','12134','12135','12130')
  AND m.idnatmut IN (1, 2, 4)
  AND l.libtyploc <> 'Dépendance'
  group by l.nbpprinc,l.anneemut
  order by l.anneemut
  

