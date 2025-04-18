-- ici je recupére toutes les mutations de types maison ou appartement
--dont le code insee est unique je lstocke dans FiltreMutations
--ça inclut les mutations à une commune qui nous interesse pas ici je les enleve dans la deuxiéme
--sous requette

create view w_sambfall.nbmutationsadeuxcommunes as 
WITH FiltreMutations AS (
    -- Sélectionne les idmutation où tous les ffcodinsee sont identiques
    SELECT idmutation
    FROM ds_dvf_d37.local
    WHERE libtyploc IN ('Maison', 'Appartement')
    GROUP BY idmutation
    HAVING COUNT(DISTINCT ffcodinsee) = 1
)
-- Appliquer les filtres et remplacer les valeurs nulles
    select 
    l.idmutation,
	l.anneemut,
    l.libtyploc, 
    COALESCE(l.ffcodinsee, LEFT(l.idloc, 5)) AS ffcodinsee_corrige, --retourne la 1ere valeur non nulle 
    l.idloc
FROM ds_dvf_d37.local l
JOIN FiltreMutations f ON l.idmutation = f.idmutation
WHERE l.libtyploc IN ('Maison', 'Appartement')
AND l.idmutation IN (
    SELECT idmutation
    FROM ds_dvf_d37.mutation
    WHERE nbcomm > 1
    AND codtypbien LIKE '1%'  
    AND idnatmut IN (1, 2, 4)
)
ORDER BY l.idmutation;
