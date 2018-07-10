DROP TABLE IF EXISTS teams_franchises;
DROP TABLE IF EXISTS batting;
DROP TABLE IF EXISTS home_games;
DROP TABLE IF EXISTS pitching;
DROP TABLE IF EXISTS all_star_full;
DROP TABLE IF EXISTS appearances;
DROP TABLE IF EXISTS managers;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS schools;
DROP TABLE IF EXISTS parks;

CREATE TABLE parks (
  park_key CHAR(5) PRIMARY KEY,
  park_name VARCHAR(64),
  park_alias VARCHAR(64),
  city VARCHAR(64),
  state VARCHAR(32),
  country CHAR(3)
);


CREATE TABLE schools (
  schoolID VARCHAR(64) PRIMARY KEY,
  name_full VARCHAR(255),
  city VARCHAR(64),
  state CHAR(2),
  country CHAR(3)
);

CREATE INDEX ON schools (city);
CREATE INDEX ON schools (state);
CREATE INDEX ON schools (name_full);


CREATE TABLE teams (
  yearID SMALLINT NOT NULL,
  lgID CHAR(2) NOT NULL,
  teamID CHAR(3) NOT NULL,
  franchID CHAR(3),
  divID VARCHAR(4),
  Rank SMALLINT,
  G SMALLINT,
  Ghome SMALLINT,
  W SMALLINT,
  L SMALLINT,
  DivWin BOOLEAN,
  WCWin BOOLEAN,
  LgWin BOOLEAN,
  WSWin BOOLEAN,
  R SMALLINT,
  AB SMALLINT,
  H SMALLINT,
  "2B" SMALLINT,
  "3B" SMALLINT,
  HR SMALLINT,
  BB DECIMAL,
  SO SMALLINT,
  SB DECIMAL,
  CS DECIMAL,
  HBP DECIMAL,
  SF SMALLINT,
  RA SMALLINT,
  ER SMALLINT,
  ERA DECIMAL,
  CG SMALLINT,
  SHO SMALLINT,
  SV SMALLINT,
  IPouts SMALLINT,
  HA SMALLINT,
  HRA SMALLINT,
  BBA SMALLINT,
  SOA SMALLINT,
  E SMALLINT,
  DP SMALLINT,
  FP DECIMAL,
  name VARCHAR(64),
  park CHAR(5) REFERENCES parks(park_key),
  attendance INTEGER,
  BPF SMALLINT,
  PPF SMALLINT,
  teamIDBR varchar(32),
  teamIDlahman45 varchar(32),
  teamIDretro varchar(32)
);

CREATE INDEX ON teams (teamID);

CREATE TABLE people (
  playerID varchar(32) PRIMARY KEY,
  birthYear SMALLINT,
  birthMonth SMALLINT,
  birthDay SMALLINT,
  birthCountry varchar(32),
  birthState VARCHAR(32),
  birthCity varchar(32),
  deathYear SMALLINT,
  deathMonth SMALLINT,
  deathDay SMALLINT,
  deathCountry varchar(32),
  deathState VARCHAR(32),
  deathCity varchar(32),
  nameFirst varchar(32),
  nameLast varchar(32),
  nameGiven varchar(64),
  weight SMALLINT,
  height SMALLINT,
  bats CHAR(1),
  throws CHAR(1),
  debut DATE,
  finalGame DATE,
  retroID varchar(32),
  bbrefID varchar(32)
);

CREATE INDEX ON people (birthYear);



CREATE TABLE all_star_full (
  playerID varchar(32) REFERENCES people(playerID),
  yearID SMALLINT NOT NULL,
  gameNum SMALLINT NOT NULL,
  gameID varchar(24),
  teamID CHAR(3) NOT NULL,
  lgID CHAR(2) NOT NULL,
  GP INTEGER,
  startingPos SMALLINT
);

CREATE INDEX ON all_star_full (yearID);
CREATE INDEX ON all_star_full (lgID);
CREATE INDEX ON all_star_full (teamID);

CREATE TABLE appearances (
  yearID SMALLINT NOT NULL,
  teamID CHAR(3) NOT NULL,
  lgID CHAR(2) NOT NULL,
  playerID varchar(32),
  G_all SMALLINT,
  GS SMALLINT,
  G_batting SMALLINT,
  G_defense SMALLINT,
  G_p SMALLINT,
  G_c SMALLINT,
  G_1b SMALLINT,
  G_2b SMALLINT,
  G_3b SMALLINT,
  G_ss SMALLINT,
  G_lf SMALLINT,
  G_cf SMALLINT,
  G_rf SMALLINT,
  G_of SMALLINT,
  G_dh SMALLINT,
  G_ph SMALLINT,
  G_pr SMALLINT
);


CREATE TABLE managers (
  playerID varchar(32) REFERENCES people(playerID),
  yearID SMALLINT NOT NULL,
  teamID CHAR(3) NOT NULL,
  lgID CHAR(2) NOT NULL,
  inseason SMALLINT,
  G SMALLINT,
  W SMALLINT,
  L SMALLINT,
  rank SMALLINT,
  plyrMgr BOOLEAN
);

CREATE INDEX ON managers (lgID);
CREATE INDEX ON managers (teamID);


CREATE TABLE pitching (
  playerID varchar(32) REFERENCES people(playerID),
  yearID SMALLINT NOT NULL,
  stint SMALLINT,
  teamID CHAR(3) NOT NULL,
  lgID CHAR(2) NOT NULL,
  W SMALLINT,
  L SMALLINT,
  G SMALLINT,
  GS SMALLINT,
  CG SMALLINT,
  SHO SMALLINT,
  SV SMALLINT,
  IPouts SMALLINT,
  H SMALLINT,
  ER SMALLINT,
  HR SMALLINT,
  BB SMALLINT,
  SO SMALLINT,
  BAOpp DECIMAL,
  ERA DECIMAL,
  IBB SMALLINT,
  WP SMALLINT,
  HBP DECIMAL,
  BK SMALLINT,
  BFP SMALLINT,
  GF SMALLINT,
  R SMALLINT,
  SH SMALLINT,
  SF SMALLINT,
  GIDP SMALLINT
);

CREATE TABLE home_games (
  yearID SMALLINT NOT NULL,
  lgID CHAR(2) NOT NULL,
  teamID CHAR(3) NOT NULL,
  park_key CHAR(5) REFERENCES parks(park_key),
  span_first DATE NOT NULL,
  span_last DATE NOT NULL,
  games SMALLINT NOT NULL,
  openings SMALLINT NOT NULL,
  attendance INTEGER NOT NULL,
  PRIMARY KEY(yearID,lgID,teamID,park_key)
);

CREATE INDEX ON home_games(attendance);


DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries (
  yearID SMALLINT NOT NULL,
  teamID CHAR(3) NOT NULL,
  lgID   CHAR(2) NOT NULL,
  playerID varchar(32) REFERENCES people(playerID),
  salary INTEGER NOT NULL,
  PRIMARY KEY (playerID,yearID,teamID,salary)
);

CREATE INDEX ON salaries(salary);
CREATE INDEX ON salaries(yearID);
CREATE INDEX ON salaries(teamID);

CREATE TABLE teams_franchises (
  franchID CHAR(3) PRIMARY KEY,
  franchName VARCHAR(64) NOT NULL,
  active VARCHAR(2),
  NAassoc VARCHAR(4)
);
CREATE INDEX ON teams_franchises(active);

CREATE TABLE batting (
  playerID varchar(32) REFERENCES people(playerID),
  yearID SMALLINT NOT NULL,
  stint SMALLINT,
  teamID CHAR(3) NOT NULL,
  lgID CHAR(2) NOT NULL,
  G SMALLINT,
  AB SMALLINT,
  R SMALLINT,
  H SMALLINT,
  "2B" SMALLINT,
  "3B" SMALLINT,
  HR SMALLINT,
  RBI DECIMAL,
  SB SMALLINT,
  CS SMALLINT,
  BB SMALLINT,
  SO SMALLINT,
  IBB DECIMAL,
  HBP DECIMAL,
  SH SMALLINT,
  SF SMALLINT,
  GIDP SMALLINT
);


CREATE TABLE pitching (
  playerID varchar(32) REFERENCES people(playerID),
  yearID SMALLINT NOT NULL,
  stint SMALLINT,
  teamID CHAR(3) NOT NULL,
  lgID CHAR(2) NOT NULL,
  W SMALLINT,
  L SMALLINT,
  G SMALLINT,
  GS SMALLINT,
  CG SMALLINT,
  SHO SMALLINT,
  SV SMALLINT,
  IPouts SMALLINT,
  H SMALLINT,
  ER SMALLINT,
  HR SMALLINT,
  BB SMALLINT,
  SO SMALLINT,
  BAOpp DECIMAL,
  ERA DECIMAL,
  IBB SMALLINT,
  WP SMALLINT,
  HBP DECIMAL,
  BK SMALLINT,
  BFP SMALLINT,
  GF SMALLINT,
  R SMALLINT,
  SH SMALLINT,
  SF SMALLINT,
  GIDP SMALLINT
);

CREATE INDEX ON pitching(yearID);
CREATE INDEX ON pitching(teamID);
CREATE INDEX ON pitching(ERA);

\COPY parks(park_key,park_name,park_alias,city,state,country) FROM './core/Parks.csv' WITH DELIMITER ',' CSV HEADER;
\COPY schools(schoolID,name_full,city,state,country) FROM './core/Schools.csv' WITH DELIMITER ',' CSV HEADER;
\COPY teams(yearID,lgID,teamID,franchID,divID,Rank,G,Ghome,W,L,DivWin,WCWin,LgWin,WSWin,R,AB,H,"2B","3B",HR,BB,SO,SB,CS,HBP,SF,RA,ER,ERA,CG,SHO,SV,IPouts,HA,HRA,BBA,SOA,E,DP,FP,name,park,attendance,BPF,PPF,teamIDBR,teamIDlahman45,teamIDretro) FROM './core/Teams.csv' WITH DELIMITER ',' CSV HEADER;
\COPY people(playerID,birthYear,birthMonth,birthDay,birthCountry,birthState,birthCity,deathYear,deathMonth,deathDay,deathCountry,deathState,deathCity,nameFirst,nameLast,nameGiven,weight,height,bats,throws,debut,finalGame,retroID,bbrefID) FROM './core/People.csv' WITH DELIMITER ',' CSV HEADER;
\COPY all_star_full(playerID,yearID,gameNum,gameID,teamID,lgID,GP,startingPos) FROM './core/AllstarFull.csv' WITH DELIMITER ',' CSV HEADER;
\COPY appearances(yearID,teamID,lgID,playerID,G_all,GS,G_batting,G_defense,G_p,G_c,G_1b,G_2b,G_3b,G_ss,G_lf,G_cf,G_rf,G_of,G_dh,G_ph,G_pr) FROM './core/Appearances.csv' WITH DELIMITER ',' CSV HEADER;
\COPY managers(playerID,yearID,teamID,lgID,inseason,G,W,L,rank,plyrMgr) FROM './core/Managers.csv' WITH DELIMITER ',' CSV HEADER;
\COPY pitching(playerID,yearID,stint,teamID,lgID,W,L,G,GS,CG,SHO,SV,IPouts,H,ER,HR,BB,SO,BAOpp,ERA,IBB,WP,HBP,BK,BFP,GF,R,SH,SF,GIDP) FROM './core/Pitching.csv' WITH DELIMITER ',' CSV HEADER;
\COPY home_games(yearID,lgID,teamID,park_key,span_first,span_last,games,openings,attendance) FROM './core/HomeGames.csv' WITH DELIMITER ',' CSV HEADER;
\COPY salaries(yearID,teamID,lgID,playerID,salary) FROM './core/Salaries.csv' WITH DELIMITER ',' CSV HEADER;
\COPY teams_franchises(franchID,franchName,active,NAassoc) FROM './core/TeamsFranchises.csv' WITH DELIMITER ',' CSV HEADER;
\COPY batting(playerID,yearID,stint,teamID,lgID,G,AB,R,H,"2B","3B",HR,RBI,SB,CS,BB,SO,IBB,HBP,SH,SF,GIDP) FROM './core/Batting.csv' WITH DELIMITER ',' CSV HEADER;
\COPY pitching(playerID,yearID,stint,teamID,lgID,W,L,G,GS,CG,SHO,SV,IPouts,H,ER,HR,BB,SO,BAOpp,ERA,IBB,WP,HBP,BK,BFP,GF,R,SH,SF,GIDP) FROM './core/Pitching.csv' WITH DELIMITER ',' CSV HEADER;

