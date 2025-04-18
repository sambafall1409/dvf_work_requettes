--CALCULS DES PRIX MÉDIANS

--CTE PERMETTANT DE TRANSFORMER LE CODE INSEE LISTE EN CODE INSEE SIMPLE
with code_insee_simple as
(
	select array_to_string(l_codinsee,', ') as code_insee, idmutation, valeurfonc
	from ds_dvf_d37.mutation
	
	where nbcomm = 1
),

--REQUÊTE PERMETTANT DE PRENDRE EN COMPTE LES FUSIONS DE COMMUNES
evol_commune_2016_2023 as (

select codgeo_2016 AS code_ancien, libgeo_2016 AS nom_ancien, codgeo_2023 AS code_nouveau, libgeo_2023 AS nom_nouveau
from dec_perim.table_passage_ann_communes
order by codgeo_2023),

--REQUÊTE PERMETTANT DE CORRIGER LA VALEUR FONCIERE ANTÉRIEURE A 2022, EN EURO CONSTANT DE 2022
euro_cst as

(
	select anneemut, count (*) as nb_ventes, ds_dvf_d37.mediane(valeurfonc) as prix_median_cst
	,case
		when anneemut = 2021 then round (valeurfonc/0.950361569811042,2)
		when anneemut = 2020 then round (valeurfonc/0.935005784413285,2)
		when anneemut = 2019 then round (valeurfonc/0.930541930870784,2)
		when anneemut = 2018 then round (valeurfonc/0.920364283865011,2)
		when anneemut = 2017 then round (valeurfonc/0.90366930402553,2)
		when anneemut = 2016 then round (valeurfonc/0.894384464041004,2)
		when anneemut = 2015 then round (valeurfonc/0.892777430586555,2)
		when anneemut = 2014 then round (valeurfonc/0.892420334975327,2)
		when anneemut = 2013 then round (valeurfonc/0.88795641625763,2)
		when anneemut = 2012 then round (valeurfonc/0.88027851307931,2)
		when anneemut = 2011 then round (valeurfonc/0.863405084886103,2)
		when anneemut = 2010 then round (valeurfonc/0.845549479906743,2)

		else valeurfonc
		end as valeurfonc_euro_cst
		FROM ds_dvf_d37.mutation
	

	WHERE coddep = '37' and libnatmut not in ('Adjudication', 'Echange', 'Expropriation') 
		and anneemut != 2023
		and nbcomm = 1 --FILTRE SUR LES MUTATIONS PRÉSENTES SUR UNE SEULE COMMUNE
		and codtypbien ilike ('111%') --FILTRE SUR LE TYPE DE BIEN (111 = maison unique / 121 = appartement unique)
		--and codtypbien in ('1111', '1112') --FILTRE SUR L'ÂGE DU BIEN (/ 1111 = vefa ou neuf (moins d'1 an) / 1112 = Maison récente (de 2 à 4 ans) / 1113 = maison ancienne (5ans ou plus) )
		and valeurfonc not in (0.00, 1.00) --SUPPRESSION DES VALEURS FONCIÈRES NULLES OU ÉGALES A 1€
	
	group by anneemut, valeurfonc_euro_cst
)

SELECT anneemut, ds_dvf_d37.mediane(prix_median_cst) as prix_median, ds_dvf_d37.mediane(valeurfonc_euro_cst) as prix_medi_cst

FROM euro_cst

GROUP BY anneemut
ORDER BY anneemut
