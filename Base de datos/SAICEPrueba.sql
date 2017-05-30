select  count(t.cedula)*100/count(t.provincia),provincia,count(cedula) from 
	(select pp.provincia,e.cedula from estudiantes e
		inner join 
		(select provincia,cedula from personas p)as pp
		on e.cedula=pp.cedula) as t
	group by(t.provincia)