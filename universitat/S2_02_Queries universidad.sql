select apellido1, apellido2, nombre from persona where tipo = "alumno" order by apellido1, apellido2, nombre;
select nombre, apellido1, apellido2 from persona where tipo = "alumno" and telefono is null;
select nombre, apellido1, apellido2 from persona where tipo = "alumno" and year(fecha_nacimiento)=1999;
select * from persona where tipo = "profesor" and telefono is null and right(nif,1)= "k";
select * from asignatura where cuatrimestre=1 and id_grado=7;
select pe.apellido1, pe.apellido2, pe.nombre, de.nombre from persona pe, profesor po, departamento de where pe.id = po.id_profesor and po.id_departamento = de.id order by pe.apellido1, pe.apellido2, pe.nombre;
select asi.nombre, anyo_inicio, anyo_fin from alumno_se_matricula_asignatura asm, persona per, asignatura asi, curso_escolar cur where asm.id_alumno = per.id and asm.id_asignatura = asi.id and asm.id_curso_escolar = cur.id and per.nif="26902806M";
select distinct (dep.nombre) from grado gra, asignatura asi, profesor pro, departamento dep where gra.id = asi.id_grado and asi.id_profesor = pro.id_profesor and pro.id_departamento=dep.id and gra.nombre = "Grado en Ingeniería Informática (Plan 2015)";
select per.nombre, per.apellido1, per.apellido2, count(*) Numero_asig from persona per, alumno_se_matricula_asignatura asm, curso_escolar cur where per.id = asm.id_alumno and asm.id_curso_escolar = cur.id and anyo_inicio=2018 and anyo_fin=2019 group by per.nombre, per.apellido1, per.apellido2;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
select dep.nombre, per.apellido1, per.apellido2, per.nombre from profesor pro inner join persona per on per.id = pro.id_profesor inner join departamento dep on pro.id_departamento = dep.id order by dep.nombre, per.apellido1, per.apellido2, per.nombre;
select * from persona per left join profesor pro on per.id = pro.id_profesor and per.tipo="profesor" and id_profesor is null;
select * from departamento where id not in (select id_departamento from profesor);
select * from persona where tipo = "profesor" and id not in (select id_profesor from asignatura where id_profesor is not null);
select * from asignatura where id_profesor is null;
select distinct (id), de.nombre from departamento de, profesor pr where de.id = pr.id_departamento and pr.id_profesor not in (SELECT id_profesor FROM asignatura where id_profesor is not null);

-- Consultes resum:
select count(*) total_alumnos from persona where tipo="alumno";
select count(*) total_alumnos from persona where tipo="alumno" and year(fecha_nacimiento) = 1999;
select dep.nombre Departamento, count(pro.id_profesor) Num_profesors from departamento dep, profesor pro where dep.id = pro.id_departamento group by dep.nombre order by Num_profesors desc;
select dep.nombre Departamento, count(pro.id_profesor) Num_profesors from departamento dep left join profesor pro on dep.id = pro.id_departamento group by dep.nombre order by dep.nombre;
select gra.nombre Grado, count(asi.id) Num_asig from grado gra left join asignatura asi on gra.id = asi.id_grado group by gra.nombre order by Num_asig desc;
select nombre from grado where id in (select id_grado from asignatura group by id_grado having count(*) > 40);
select gra.nombre Grado, asi.tipo TipoAsignatura, sum(creditos) SumaCréditos from grado gra, asignatura asi where gra.id = asi.id_grado group by gra.nombre, asi.tipo;
select cur.anyo_inicio AñoInicio, count(asm.id_asignatura) NumAlumnes from alumno_se_matricula_asignatura asm, curso_escolar cur where asm.id_curso_escolar = cur.id group by AñoInicio, asm.id_alumno;
select per.id, per.nombre, per.apellido1, per.apellido2, count(asi.id) from persona per left join asignatura asi on asi.id_profesor = per.id and per.tipo = 'profesor' group by per.id, per.nombre, per.apellido1, per.apellido2;
select * from persona where tipo="alumno" order by fecha_nacimiento desc limit 1;
SELECT pr.id_profesor, pe.nombre, pe.apellido1, pe.apellido2 FROM profesor pr, persona pe WHERE pr.id_profesor = pe.id and id_profesor NOT IN(SELECT id_profesor FROM asignatura where id_profesor is not null);