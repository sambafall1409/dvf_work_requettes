-- Cette requête calcule le nbr de maisons et d'appartements vendu par cellule du carroyage 200 de l'ATU

select
	idcellule,
	sum(nb_maisons) as nbmaison,
	sum(nb_apparte)as nbappart

from ds_dvf.mutlogt_mtvl join dec_perim.carroyage_200
	on st_within(mutlogt_mtvl.geom,carroyage_200.geom)
where carroyage_200.code_insee = '37261' and mutlogt_mtvl.code_insee = '37261' and cat <> 'T3' and nb_apparte >0

Group by idcellule

order by idcellule


	select * from ds_dvf.mutlogt_mtvl where code_insee = '37261'and cat <> 'T3' and nb_apparte >0 order by cat desc