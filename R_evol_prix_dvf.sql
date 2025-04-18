--cte filtrant les transactions utiles au calcul

with cte_filtre_mutation as
	(select l_codinsee, anneemut, nbcomm, codtypbien, libtypbien, valeurfonc
	 from ds_dvf_d37.mutation
	 where codtypbien ilike '111%' 
	 and nbcomm = '1' 
	 and anneemut between 2017 and 2022
	 --and l_codinsee='{37272}'
	 and valeurfonc not in (0.00, 1.00)
	),
	
--cte calculant la valeur fonciere corrigée de l'inflation
cte_prix_constant_2022 as
	(select l_codinsee, anneemut, nbcomm, codtypbien, libtypbien, valeurfonc,
	 case 
	 when anneemut = 2022 then valeurfonc
	 when anneemut = 2021 then round (valeurfonc*1.0522311,2)
	 when anneemut = 2020 then round (valeurfonc*1.0695121,2)
	 when anneemut = 2019 then round (valeurfonc*1.0746426,2)
	 when anneemut = 2018 then round (valeurfonc*1.086526351,2)
	 when anneemut = 2017 then round (valeurfonc*1.1065995,2)
	 end as valeurfonc_euro_cst
	 
	 from cte_filtre_mutation
	),

cte_prix_median_2017_2019 as 
(
	--sélectionner les mutations concernant une commune unique, de type maison unique sur les années 2017 à 2022

	select l_codinsee[1] as code_insee, count (valeurfonc) as nb_valfonc, percentile_cont(0.5) within group (order by valeurfonc_euro_cst) as resultat, geom
	from cte_prix_constant_2022 as p
	join dec_perim.communes37 as c
	on c.code_insee = p.l_codinsee[1]
	where anneemut between 2017 and 2019
	group by l_codinsee, geom
),

cte_prix_median_2020_2022 as 
(
	--sélectionner les mutations concernant une commune unique, de type maison unique sur les années 2017 à 2022

	select l_codinsee[1] as code_insee, count (valeurfonc) as nb_valfonc, percentile_cont(0.5) within group (order by valeurfonc_euro_cst) as resultat, geom
	from cte_prix_constant_2022 as p
	join dec_perim.communes37 as c
	on c.code_insee = p.l_codinsee[1]
	where anneemut between 2020 and 2022
	group by l_codinsee, geom
)


--CALCUL DE L'ÉVOLUTION DU PRIX MEDIAN ENTRE 2017-2019 ET 2020-2022
select avant.code_insee, avant.resultat avant , apres.resultat apres, ((apres.resultat - avant.resultat)/avant.resultat)*100 as evolution, avant.geom
from cte_prix_median_2017_2019 as avant
JOIN cte_prix_median_2020_2022 as apres ON (avant.code_insee=apres.code_insee)
ORDER BY evolution DESC

/*SELECT * FROM ds_dvf_d37.mutation
ORDER BY idmutation ASC LIMIT 100*/
