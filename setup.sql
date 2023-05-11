CREATE DATABASE tv_programs;
USE tv_programs;
CREATE TABLE Users(
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  UNIQUE(email)
);
CREATE TABLE Channels(
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);
CREATE TABLE Programs(
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  description TEXT NOT NULL
);
CREATE TABLE Seasons(
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  program_id BIGINT(20),
  season_number INT(11) NOT NULL,
  FOREIGN KEY (program_id) REFERENCES Programs(id)
);
CREATE TABLE Episodes(
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  season_id BIGINT(20),
  title VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  term INT(11) NOT NULL,
  release_date DATE NOT NULL,
  viewers_number BIGINT(20),
  FOREIGN KEY (season_id) REFERENCES Seasons(id)
);
CREATE TABLE Genres(
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);
CREATE TABLE Program_Genres(
  program_id BIGINT(20),
  genre_id BIGINT(20),
  FOREIGN KEY (program_id) REFERENCES Programs(id),
  FOREIGN KEY (genre_id) REFERENCES Genres(id)
);
CREATE TABLE Channel_Episodes(
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  channel_id BIGINT(20),
  episode_id BIGINT(20),
  broadcast_time DATETIME NOT NULL,
  viewers_number BIGINT(20),
  FOREIGN KEY (channel_id) REFERENCES Channels(id),
  FOREIGN KEY (episode_id) REFERENCES Episodes(id)
);
INSERT INTO Users(name, email)
VALUES ('User1', 'user1@example.com'),
  ('User2', 'user2@example.com'),
  ('User3', 'user3@example.com');
INSERT INTO Channels(name)
VALUES ('Channel1'),
  ('Channel2'),
  ('Channel3');
INSERT INTO Programs(title, description)
VALUES ('Program1', 'This is a description for Program1'),
  ('Program2', 'This is a description for Program2'),
  ('Program3', 'This is a description for Program3');
INSERT INTO Seasons(program_id, season_number)
VALUES (1, 1),
  (2, 1),
  (3, 1);
INSERT INTO Episodes(
    season_id,
    title,
    description,
    term,
    release_date,
    viewers_number
  )
VALUES (
    1,
    'Episode1',
    'This is a description for Episode1',
    60,
    '2023-05-01',
    100000
  ),
  (
    2,
    'Episode1 of Season1 from Program2',
    'This is a description for Episode2',
    60,
    '2023-05-02',
    200000
  ),
  (
    3,
    'Episode1 of Season1 from Program3',
    'This is a description for Episode3',
    60,
    '2023-05-03',
    300000
  );
INSERT INTO Genres(name)
VALUES ('Genre1'),
  ('Genre2'),
  ('Genre3');
INSERT INTO Program_Genres(program_id, genre_id)
VALUES (1, 1),
  (2, 2),
  (3, 3);
INSERT INTO Channel_Episodes(
    channel_id,
    episode_id,
    broadcast_time,
    viewers_number
  )
VALUES (1, 1, '2023-05-01 20:00:00', 100000),
  (2, 2, '2023-05-02 20:00:00', 200000),
  (3, 3, '2023-05-03 20:00:00', 300000);
