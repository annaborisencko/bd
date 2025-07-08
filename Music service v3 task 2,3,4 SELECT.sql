--ЗАДАНИЕ №2
--Запрос №1
--Название и продолжительность самого длительного трека
SELECT name, duration
FROM TRACK
WHERE duration=(
	SELECT MAX(duration) 
	FROM TRACK
);

--Запрос №2
--Название треков, продолжительность которых не менее 3,5 минут.
SELECT name, duration
FROM TRACK
WHERE duration>='3:50';

--Запрос №3
--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name
FROM COLLECTION
WHERE year BETWEEN 2018 AND 2020;


--Запрос №4
--Исполнители, чьё имя состоит из одного слова.
SELECT nickname
FROM ARTIST
WHERE nickname NOT LIKE '% %';

--Запрос №5
--Название треков, которые содержат слово «мой» или «my».
SELECT name
FROM TRACK
WHERE LOWER(name) LIKE '%my%'
OR LOWER(name) LIKE '%мой%';

--ЗАДАНИЕ №3
--Запрос №6
--Количество исполнителей в каждом жанре.
SELECT genre.name AS genre_name, COUNT(artist_id) AS artist_count
FROM ARTISTINGENRE
JOIN genre ON ARTISTINGENRE.genre_id = GENRE.id
GROUP BY genre.name;

--Запрос №7
--Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(T.name) AS track_count, A.name as album_name
FROM TRACK T
JOIN ALBUM A ON T.album_id = A.id
WHERE A.year BETWEEN 2019 AND 2020
GROUP BY A.name;

--Запрос №8
--Средняя продолжительность треков по каждому альбому.
SELECT AVG(duration) AS track_avg_duration, A.name AS album_name
FROM TRACK T
JOIN ALBUM A on T.album_id = A.id
GROUP BY A.name;

--Запрос №9
--Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT distinct(A.nickname)
FROM ARTIST A
LEFT JOIN Artistinalbum AS AA ON A.id=AA.artist_id
LEFT JOIN Album AS Alb ON AA.album_id=Alb.id
WHERE Alb.year != 2020 or Alb.year IS NULL;

--Запрос №10
--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT distinct(C.name) as coll_name, A.nickname as artist_name
FROM Collection C
join TrackInCollection TC on C.id = TC.collection_id
join track T on TC.track_id = T.ID
join artistinalbum AA on T.album_id = AA.album_id
join artist A on AA.artist_id = A.ID
WHERE nickname LIKE 'Сплин';

--ЗАДАНИЕ №4
--Запрос №11
--Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT A.name AS album_name, COUNT(genre_id) AS genre_count
FROM ARTISTINGENRE AG
JOIN ARTISTINALBUM AA ON AG.artist_id = AA.artist_id
JOIN ALBUM A ON AA.album_id = A.id
GROUP BY album_name
HAVING COUNT(genre_id) > 1;

--Запрос №12
--Наименования треков, которые не входят в сборники.
SELECT name
FROM TRACK T
LEFT JOIN TRACKINCOLLECTION T2 ON T.id = T2.track_id
WHERE T2.track_id is null;

--Запрос №13
--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT T.name AS track_name, A.nickname AS artist_name, T.duration
FROM TRACK T
JOIN ARTISTINALBUM A2 ON T.album_id = A2.album_id
JOIN ARTIST A ON A2.artist_id = A.id
WHERE T.duration = (
	SELECT MIN(duration)
	FROM TRACK
);

--Запрос №14
--Названия альбомов, содержащих наименьшее количество треков.
SELECT A.name AS album_name, count(T.name) AS track_count
FROM ALBUM A
JOIN TRACK T ON A.id = T.album_id
GROUP BY album_name
HAVING COUNT(T.name) = (
	SELECT COUNT(T.name)
	FROM TRACK T
	GROUP BY album_id
	ORDER BY COUNT(T.name)
	LIMIT 1
	);
