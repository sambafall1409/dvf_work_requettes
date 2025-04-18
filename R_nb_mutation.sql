select codtypbien, libtypbien, 
count (idmutation)

from ds_dvf_d37.mutation

where 

--SÉLECTION DE LA COMMUNE
--l_codinsee = '{37261}'

l_codinsee IN 
--Tours Métropole Val de Loire
('{37018}','{37025}','{37050}','{37054}','{37099}','{37109}','{37122}','{37139}','{37151}','{37152}','{37172}',



'{37195}','{37214}','{37261}','{37208}','{37179}','{37233}','{37203}','{37217}','{37219}','{37243}','{37272}',)

and libnatmut not in ('Adjudication', 'Echange', 'Expropriation')
and anneemut = '2022'
--and valeurfonc != 0
--and valeurfonc != 1

group by codtypbien, libtypbien