-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament


DROP TABLE IF EXISTS Players;
CREATE TABLE Players (

	"id" serial PRIMARY KEY,
	"name" varchar(20)
);

DROP TABLE IF EXISTS Matches;
CREATE TABLE Matches (
	"id" serial PRIMARY KEY,
	"winner_id" integer REFERENCES players(id) ON DELETE CASCADE,
	"loser_id" integer REFERENCES players(id) ON DELETE CASCADE
);

DROP VIEW IF EXISTS Standings;
CREATE VIEW Standings AS
	SELECT 	players.id AS id,players.name AS name,
           	count(win.id) AS wins, count(win.id)+count(loss.id) AS matches
            FROM players
            LEFT JOIN matches AS win ON players.id = win.winner_id
            LEFT JOIN matches AS loss ON players.id = loss.loser_id
            GROUP BY players.id,players.name ORDER BY wins DESC;