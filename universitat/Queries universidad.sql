-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select apellido1, apellido2, nombre from persona where tipo = "alumno" order by apellido1, apellido2, nombre;

-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
select nombre, apellido1, apellido2 from persona where tipo = "alumno" and telefono is null;

-- Retorna el llistat dels alumnes que van néixer en 1999.
select nombre, apellido1, apellido2 from persona where tipo = "alumno" and year(fecha_nacimiento)=1999;

-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
select * from persona where tipo = "profesor" and telefono is null and right(nif,1)= "k";

-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
select * from asignatura where cuatrimestre=1 and id_grado=7;

-- Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
-- El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
select pe.apellido1, pe.apellido2, pe.nombre, de.nombre
from persona pe, profesor po, departamento de
where pe.id = po.id_profesor
and po.id_departamento = de.id
order by pe.apellido1, pe.apellido2, pe.nombre;

-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
select asi.nombre, anyo_inicio, anyo_fin
from alumno_se_matricula_asignatura asm, persona per, asignatura asi, curso_escolar cur
where asm.id_alumno = per.id
and asm.id_asignatura = asi.id
and asm.id_curso_escolar = cur.id
and per.nif="26902806M";

-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

select distinct (dep.nombre) from grado gra, asignatura asi, profesor pro, departamento dep
where gra.id = asi.id_grado
and asi.id_profesor = pro.id_profesor
and pro.id_departamento=dep.id
and gra.nombre = "Grado en Ingeniería Informática (Plan 2015)";


-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
select per.nombre, per.apellido1, per.apellido2, count(*) Numero_asig from persona per, alumno_se_matricula_asignatura asm, curso_escolar cur
where per.id = asm.id_alumno
and asm.id_curso_escolar = cur.id
and anyo_inicio=2018 and anyo_fin=2019
group by per.nombre, per.apellido1, per.apellido2;


-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select dep.nombre, per.apellido1, per.apellido2, per.nombre
from profesor pro
inner join persona per
on per.id = pro.id_profesor
inner join departamento dep
on pro.id_departamento = dep.id
order by dep.nombre, per.apellido1, per.apellido2, per.nombre;

-- Retorna un llistat amb els professors/es que no estan associats a un departament.
select * from persona per
left join profesor pro
on per.id = pro.id_profesor
and per.tipo="profesor"
and id_profesor is null;

-- Retorna un llistat amb els departaments que no tenen professors/es associats.
select * from departamento where id not in (select id_departamento from profesor);


-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
select * from persona where tipo = "profesor" and id not in (select id_profesor from asignatura where id_profesor is not null);

-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
select * from asignatura where id_profesor is null;

-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.curso_escolar
select distinct (id), de.nombre from departamento de, profesor pr where de.id = pr.id_departamento and pr.id_profesor not in (SELECT id_profesor FROM asignatura where id_profesor is not null);

-- Consultes resum:

-- Retorna el nombre total d'alumnes que hi ha.
select count(*) total_alumnos from persona where tipo="alumno";

-- Calcula quants alumnes van néixer en 1999.
select count(*) total_alumnos from persona where tipo="alumno" and year(fecha_nacimiento) = 1999;

-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que 
-- hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
select dep.nombre Departamento, count(pro.id_profesor) Num_profesors from departamento dep, profesor pro
where dep.id = pro.id_departamento
group by dep.nombre
order by Num_profesors desc;

-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
-- Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
select dep.nombre Departamento, count(pro.id_profesor) Num_profesors from departamento dep left join profesor pro
on dep.id = pro.id_departamento
group by dep.nombre
order by dep.nombre;

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Tingues en compte que poden existir graus que no tenen assignatures associades. 
-- Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
select gra.nombre Grado, count(asi.id) Num_asig from grado gra left join asignatura asi
on gra.id = asi.id_grado
group by gra.nombre
order by Num_asig desc;


-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
select nombre from grado where id in (
select id_grado from asignatura group by id_grado having count(*) > 40);

-- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
-- El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
select gra.nombre Grado, asi.tipo TipoAsignatura, sum(creditos) SumaCréditos from grado gra, asignatura asi
where gra.id = asi.id_grado
group by gra.nombre, asi.tipo;



-- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
-- El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
select cur.anyo_inicio AñoInicio, count(asm.id_asignatura) NumAlumnes from alumno_se_matricula_asignatura asm, curso_escolar cur
where asm.id_curso_escolar = cur.id
group by AñoInicio, asm.id_alumno;



-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
select per.id, per.nombre, per.apellido1, per.apellido2, count(asi.id) from persona per left join asignatura asi on asi.id_profesor = per.id and per.tipo = 'profesor' group by per.id, per.nombre, per.apellido1, per.apellido2;

-- Retorna totes les dades de l'alumne/a més jove.
select * from persona where tipo="alumno" order by fecha_nacimiento desc limit 1;

-- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT pr.id_profesor, pe.nombre, pe.apellido1, pe.apellido2 FROM profesor pr, persona pe
WHERE pr.id_profesor = pe.id
and id_profesor NOT IN(
SELECT id_profesor FROM asignatura where id_profesor is not null);