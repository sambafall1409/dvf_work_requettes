--COMPTER LE NOMBRE D'APPARTEMENTS ET DE MAISONS VENDUES EN INDRE-ET-LOIRE, SELON L'ANNÉE

select --l_codinsee, 
anneemut--, nblocanc

,sum (nblocmai) as nb_maison
,sum (nblocapt) as nb_appart
,sum (nbapt3pp) as T3
,sum (nblocmai + nblocapt) as nb_logement

from ds_dvf_d37.mutation

where libnatmut not in ('Adjudication', 'Echange', 'Expropriation')
and nbcomm = 1
AND l_codinsee IN ('{37025}','{37018}','{37195}','{37054}','{37214}','{37099}','{37261}','{37122}','{37151}','{37152}','{37172}','{37208}','{37179}','{37233}','{37203}','{37217}','{37219}','{37243}','{37272}','{37050}','{37109}','{37139}')

group by --l_codinsee, 
anneemut--, nblocanc


/*--COMPTER LE NOMBRE DE MAISONS ANCIENNES (plus de 5 ans) VENDUES EN INDRE-ET-LOIRE, SELON L'ANNÉE
/*
select l_codinsee, anneemut, sum (nblocmai) as nb_maison
from ds_dvf_d37.mutation
where anneemut <>'2023' and libnatmut not in ('Adjudication', 'Echange', 'Expropriation') and nbcomm = 1 and codtypbien = '1113'
group by l_codinsee, anneemut
*/


--COMPTER LE NOMBRE DE MAISONS NEUVES ( 1 an ou moins) ET RÉCENTES (de 2 à 4 ans) VENDUES EN INDRE-ET-LOIRE, SELON L'ANNÉE
/*
select l_codinsee, anneemut, sum (nblocmai) as nb_maison
from ds_dvf_d37.mutation
where anneemut <>'2023' and libnatmut not in ('Adjudication', 'Echange', 'Expropriation') and nbcomm = 1 and codtypbien in ('1111', '1112')
group by l_codinsee, anneemut
*/


--COMPTER LE NOMBRE DE MAISONS VENDUES EN INDRE-ET-LOIRE AU SEIN D'UNE MUTATION D'UNE SEULE MAISON, SELON L'ANNÉE
/*select anneemut, sum (nblocmai) as nb_maison
from ds_dvf_d37.mutation
where anneemut <>'2023' and libnatmut not in ('Adjudication', 'Echange', 'Expropriation')
and nbcomm = 1
AND l_codinsee IN ('{37025}','{37018}','{37195}','{37054}','{37214}','{37099}','{37261}','{37122}','{37151}','{37152}','{37172}','{37208}','{37179}','{37233}','{37203}','{37217}','{37219}','{37243}','{37272}','{37050}','{37109}','{37139}')
and codtypbien like ('111%')
group by anneemut
*/

--COMPTER LE NOMBRE D'APPARTEMENTS VENDUS EN INDRE-ET-LOIRE AU SEIN D'UNE MUTATION D'UN SEUL APPARTEMENT, SELON L'ANNÉE
/*select anneemut, sum (nblocapt) as nb_appart
from ds_dvf_d37.mutation
where anneemut <>'2023' and libnatmut not in ('Adjudication', 'Echange', 'Expropriation')
and nbcomm = 1 
AND l_codinsee IN ('{37025}','{37018}','{37195}','{37054}','{37214}','{37099}','{37261}','{37122}','{37151}','{37152}','{37172}','{37208}','{37179}','{37233}','{37203}','{37217}','{37219}','{37243}','{37272}','{37050}','{37109}','{37139}')
and codtypbien like ('121%')
group by anneemut*/

--COMPTER LE NOMBRE DE T3 VENDUS EN INDRE-ET-LOIRE AU SEIN D'UNE MUTATION D'UN SEUL APPARTEMENT, SELON L'ANNÉE
select anneemut, sum (nblocapt) as nb_appart
from ds_dvf_d37.mutation
where libnatmut not in ('Adjudication', 'Echange', 'Expropriation')
and nbcomm = 1 
--AND l_codinsee IN ('{37025}','{37018}','{37195}','{37054}','{37214}','{37099}','{37261}','{37122}','{37151}','{37152}','{37172}','{37208}','{37179}','{37233}','{37203}','{37217}','{37219}','{37243}','{37272}','{37050}','{37109}','{37139}')
and codtypbien in ('12113', '12123', '12133')
group by anneemut
*/