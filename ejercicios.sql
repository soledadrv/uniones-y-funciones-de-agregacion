-- Micro desafío - Paso 1:

/* Utilizando la base de datos de películas queremos conocer: */

/* los títulos y el nombre del género de todas las series de la base de datos. */

SELECT title, name
FROM series
INNER JOIN genres ON genre_id = genres.id

/* listar los títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada uno de ellos. */

SELECT title, first_name, last_name
FROM episodes
INNER JOIN actor_episode ON episode_id = episodes.id
INNER JOIN actors ON actor_id = actors.id


-- Micro desafío - Paso 2:

/* Para nuestro próximo desafío necesitamos obtener a todos los actores o actrices (mostrar nombre y apellido) que han trabajado en cualquier película de la saga de la Guerra de las galaxias, pero ¡cuidado!: debemos asegurarnos de que solo se muestre una sola vez cada actor/actriz. */

SELECT DISTINCT first_name, last_name
FROM actors
INNER JOIN actor_movie ON actor_id = actors.id
INNER JOIN movies ON movie_id = movies.id
WHERE title LIKE '%la Guerra de las galaxias%'


-- Micro desafío - Paso 3:

/* Debemos listar los títulos de cada película con su género correspondiente. En el caso de que no tenga género, mostraremos una leyenda que diga "no tiene género". Como ayuda podemos usar la función COALESCE() que retorna el primer valor no nulo de una lista. */

SELECT title, COALESCE(name, 'No tiene género.')
FROM series
INNER JOIN genres ON genre_id = genres.id


-- Micro desafío - Paso 4:

/* Necesitamos mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con la particularidad de que a la columna que mostrará dicha cantidad la renombraremos: “Duración”. */

SELECT title AS 'Título', DATEDIFF(end_date, release_date) AS 'Duración'
FROM series


-- Micro desafío - Paso 5:

/* Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres. */

SELECT first_name, last_name
FROM actors
WHERE LENGTH(first_name) > 6
ORDER BY first_name

/* Debemos mostrar la cantidad total de los episodios guardados en la base de datos. */

SELECT COUNT(id) AS 'cantidad de episodios'
FROM episodes

/* Para el siguiente desafío nos piden que obtengamos el título de todas las series y el total de temporadas que tiene cada una de ellas.*/

SELECT series.title, COUNT(seasons.id) AS seasons
FROM series
INNER JOIN seasons ON serie_id = series.id
GROUP BY series.title

/* Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor o igual a 3. */

SELECT genres.name, COUNT(movies.id) AS movies
FROM genres
INNER JOIN movies ON genre_id = genres.id
GROUP BY genres.name
HAVING COUNT(movies.id) >= 3
