CREATE TABLE IF NOT EXISTS Genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Artist(
	id SERIAL PRIMARY KEY,
	nickname VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS ArtistInGenre(
	artist_id INTEGER REFERENCES Artist(id),
	genre_id INTEGER REFERENCES Genre(id),
	CONSTRAINT pk PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS Album(
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	year DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS ArtistInAlbum(
	artist_id INTEGER REFERENCES Artist(id),
	album_id INTEGER REFERENCES Album(id),
	CONSTRAINT pk1 PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS Track(
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	length INTEGER NOT NULL,
	album_id INTEGER NOT NULL REFERENCES Album(id)
);

CREATE TABLE IF NOT EXISTS Collection(
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	year DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS TrackInCollection(
	track_id INTEGER REFERENCES Track(id),
	collection_id INTEGER REFERENCES Collection(id),
	CONSTRAINT pk2 PRIMARY KEY (track_id, collection_id)
);

