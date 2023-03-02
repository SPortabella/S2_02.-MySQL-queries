select nombre from producto;
select nombre, precio from producto;
select * from producto;
select nombre, precio, format(precio*1.07, 2) from producto;
select nombre, precio euros, format(precio*1.07, 2) dolars from producto;
select ucase(nombre) nombre, precio from producto;
select lcase(nombre) nombre, precio from producto;
select nombre, ucase(substr(nombre,1,2)) subnom  from fabricante;
select nombre, round(precio) from producto;
select nombre, truncate(precio,0) from producto;
select codigo_fabricante from producto; 
select DISTINCT(codigo_fabricante) from producto; 
select nombre from fabricante order by nombre asc;
select nombre from fabricante order by nombre desc;
select nombre from producto order by nombre, precio desc;
select * from fabricante limit 5;
select * from fabricante limit 3,2; 
select nombre, precio from producto order by precio asc limit 1;
select nombre, precio from producto order by precio desc limit 1;
select nombre from producto where codigo_fabricante = 2;
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo;
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo order by f.nombre;
select p.codigo, p.nombre, p.codigo_fabricante, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo;
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo order by p.precio asc limit 1;
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo order by p.precio desc limit 1; 
select p.* from producto p, fabricante f where p.codigo_fabricante = f.codigo and f.nombre = 'Lenovo';
select p.* from producto p, fabricante f where p.codigo_fabricante = f.codigo and f.nombre = 'Crucial' and p.precio>200;
select p.*, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo and (f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate');
select p.*, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo and f.nombre in ('Asus', 'Hewlett-Packard', 'Seagate');
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo and lower(right(f.nombre,1)) = 'e'; 
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo and locate('w',lower(f.nombre)) > 0;
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante = f.codigo and p.precio > 180 order by p.precio desc, p.nombre asc;
select f.codigo, f.nombre from fabricante f, producto p where f.codigo = p.codigo_fabricante group by f.codigo, f.nombre;
select f.codigo, f.nombre, p.* from fabricante f left join producto p on f.codigo = p.codigo_fabricante;
select f.codigo, f.nombre, p.* from fabricante f left join producto p on f.codigo = p.codigo_fabricante where p.codigo is null;
select * from producto p where p.codigo_fabricante in (select codigo from fabricante where nombre = 'Lenovo');
select * from producto p where p.precio = (select max(precio) from producto where codigo_fabricante in (select codigo from fabricante where nombre = 'Lenovo'));
select p.nombre, p.precio from fabricante f, producto p where p.codigo_fabricante = f.codigo and f.nombre = 'Lenovo' order by precio desc limit 1;
select p.nombre, p.precio from fabricante f, producto p where p.codigo_fabricante = f.codigo and f.nombre = 'Hewlett-Packard' order by precio asc limit 1;
select * from producto where precio >= (select p.precio from fabricante f, producto p where p.codigo_fabricante = f.codigo and f.nombre = 'Lenovo' order by precio desc limit 1);
select p.* from producto p, fabricante f where p.codigo_fabricante = f.codigo and f.nombre = 'Asus' and precio >= (select avg(precio) from producto p, fabricante f where p.codigo_fabricante = f.codigo and f.nombre = 'Asus');

