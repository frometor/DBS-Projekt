CREATE TABLE imdb (
    imdbId character varying(32) NOT NULL,
    name character varying(320) NOT NULL,
    year integer,
    rating numeric(2, 1),
    votes varchar(32),
    runtime varchar(32),
    directors varchar(80),
    actors varchar(160),
    genres varchar(160) 
);
ALTER TABLE imdb ADD CONSTRAINT pk_imdbID PRIMARY KEY(imdbId);

CREATE TABLE movies (
    mov_id character varying(32) NOT NULL,
    mov_name character varying(320) NOT NULL,
    year integer,
    votes character varying(32),
    rating numeric(2, 1),
    runtime character varying(32) 
);
ALTER TABLE movies ADD CONSTRAINT pk_mov_id PRIMARY KEY(mov_id);

CREATE TABLE regisseur (
    reg_name character varying(80),
    reg_id serial NOT NULL
);
ALTER TABLE regisseur ADD CONSTRAINT pk_reg_id PRIMARY KEY(reg_id);

CREATE TABLE actor (
    act_name character varying(80) NOT NULL,
    act_id serial NOT NULL
);
ALTER TABLE actor ADD CONSTRAINT pk_act_id PRIMARY KEY(act_id);

CREATE TABLE genre (
    gen_id serial NOT NULL,
    gen_name character varying(80) NOT NULL
);
ALTER TABLE genre ADD CONSTRAINT pk_gen_id PRIMARY KEY(gen_id);

CREATE TABLE directs (
    reg_id integer NOT NULL,
    mov_id character varying(32) NOT NULL
);
ALTER TABLE directs ADD CONSTRAINT pk_directs PRIMARY KEY(reg_id,mov_id);
ALTER TABLE directs ADD CONSTRAINT directs_reg_id FOREIGN KEY (reg_id) REFERENCES regisseur(reg_id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE directs ADD CONSTRAINT directs_mov_id FOREIGN KEY (mov_id) REFERENCES movies(mov_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE TABLE acts (
    act_id integer NOT NULL,
    mov_id character varying(32) NOT NULL
);
ALTER TABLE acts ADD CONSTRAINT pk_acts PRIMARY KEY(act_id,mov_id);
ALTER TABLE acts ADD CONSTRAINT acts_act_id FOREIGN KEY (act_id) REFERENCES actor(act_id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE acts ADD CONSTRAINT acts_mov_id FOREIGN KEY (mov_id) REFERENCES movies(mov_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE TABLE genmov (
    mov_id character varying(32) NOT NULL,
    gen_id integer NOT NULL
);
ALTER TABLE genmov ADD CONSTRAINT pk_genmov PRIMARY KEY(mov_id,gen_id);
ALTER TABLE genmov ADD CONSTRAINT genmov_mov_id FOREIGN KEY (mov_id) REFERENCES movies(mov_id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE genmov ADD CONSTRAINT genmov_gen_id FOREIGN KEY (gen_id) REFERENCES genre(gen_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

linux:
COPY imdb FROM '/etc/postgresql/9.3/csv/imdb_top100t_janosch.csv' WITH DELIMITER E'\t' NULL 'NA'; 

INSERT INTO movies (mov_id, mov_name, year, rating, votes, runtime) SELECT DISTINCT imdbID, name, year, rating, votes, runtime FROM imdb;

update imdb set actors = (string_to_array(actors, '|') );
update imdb set directors = (string_to_array(directors, '|') );
update imdb set genres = (string_to_array(genres, '|') );

INSERT INTO genre (gen_name) SELECT DISTINCT (UNNEST(genres::text[])) from imdb;
INSERT INTO actor (act_name) SELECT DISTINCT (UNNEST(actors::text[])) from imdb;
INSERT INTO regisseur (reg_name) SELECT DISTINCT (UNNEST(directors::text[])) from imdb;

CREATE TABLE regisseur_tmp(
reg_name character varying(80) NOT NULL,
mov_id character varying(80) NOT NULL
);
ALTER TABLE regisseur_tmp ADD CONSTRAINT pk_regisseurBLA_tmp PRIMARY KEY (reg_name, mov_id);

CREATE TABLE actor_tmp(
act_name character varying(80) NOT NULL,
mov_id character varying(80) NOT NULL
);
ALTER TABLE actor_tmp ADD CONSTRAINT pk_actorBLA_tmp PRIMARY KEY (act_name, mov_id);

CREATE TABLE genmov_tmp(
gen_name character varying(80) NOT NULL,
mov_id character varying(80) NOT NULL
);
ALTER TABLE genmov_tmp ADD CONSTRAINT pk_genmovBLA_tmp PRIMARY KEY (gen_name, mov_id);

INSERT INTO regisseur_tmp (reg_name, mov_id) SELECT DISTINCT unnest(directors::text[]), imdbID from imdb;
INSERT INTO actor_tmp (act_name, mov_id) SELECT DISTINCT unnest(actors::text[]), imdbID from imdb;
INSERT INTO genmov_tmp (gen_name, mov_id) SELECT DISTINCT unnest(genres::text[]), imdbID from imdb;

INSERT INTO directs (reg_id, mov_id) SELECT regisseur.reg_id, regisseur_tmp.mov_id FROM regisseur, regisseur_tmp WHERE regisseur.reg_name = regisseur_tmp.reg_name;

INSERT INTO acts (act_id, mov_id) SELECT actor.act_id, actor_tmp.mov_id FROM actor, actor_tmp WHERE actor.act_name = actor_tmp.act_name;

INSERT INTO genmov (mov_id, gen_id) SELECT genmov_tmp.mov_id, genre.gen_id FROM genmov_tmp, genre WHERE genmov_tmp.gen_name = genre.gen_name;

DROP TABLE actor_tmp, genmov_tmp, regisseur_tmp;

DROP TABLE imdb;


