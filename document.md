## STEP2 Document

### ⚫ 手順1 SQLスクリプトファイルの作成
`setup.sql`という名前のファイルを作成し、以下のsqlスクリプトをsetup.sqlにコピペして下さい。この実行ファイルはデータベースの構築、テーブルの構築、サンプルデータの投入の順で処理されます。
データベースはMySQLを使用しています。


setupsql.db
```sql
-- Create Database
CREATE DATABASE IF NOT EXISTS TVGuide;
USE TVGuide;

-- Create Tables
CREATE TABLE Users (
    id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Channels (
    id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Programs (
    id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description LONGTEXT
);

CREATE TABLE Seasons (
    id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
    program_id BIGINT(20) NOT NULL,
    season_number INT(11) NOT NULL,
    UNIQUE(program_id, season_number)
);

CREATE TABLE Episodes (
    id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
    season_id BIGINT(20) NOT NULL,
    episode_number INT(11) NOT NULL,
    title VARCHAR(100) NOT NULL,
    description LONGTEXT,
    duration INT(11) NOT NULL,
    release_date DATE NOT NULL,
    total_viewers_number BIGINT(20) NOT NULL,
    UNIQUE(season_id, episode_number)
);

CREATE TABLE Genres (
    id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Program_Genres (
    program_id BIGINT(20) NOT NULL,
    genre_id BIGINT(20) NOT NULL
);

CREATE TABLE Channel_Episodes (
    channel_id BIGINT(20) NOT NULL,
    episode_id BIGINT(20) NOT NULL,
    broadcast_time DATETIME NOT NULL,
    broadcast_viewers_number BIGINT(20) NOT NULL,
    PRIMARY KEY(channel_id, episode_id, broadcast_time)
);

-- Insert Test Data
INSERT INTO Users (name, email) VALUES ('John Doe', 'johndoe@example.com');
INSERT INTO Channels (name) VALUES ('Channel 1'), ('Channel 2');
INSERT INTO Programs (title, description) VALUES ('Program 1', 'Description of Program 1'), ('Program 2', 'Description of Program 2');
INSERT INTO Seasons (program_id, season_number) VALUES (1, 1), (2, 1);
INSERT INTO Episodes (season_id, episode_number, title, description, duration, release_date, total_viewers_number) VALUES (1, 1, 'Episode 1', 'Description of Episode 1', 60, '2023-05-11', 1000), (2, 1, 'Episode 2', 'Description of Episode 2', 90, '2023-05-11', 2000);
INSERT INTO Genres (name) VALUES ('Genre 1'), ('Genre 2');
INSERT INTO Program_Genres (program_id, genre_id) VALUES (1, 1), (2, 2);
INSERT INTO Channel_Episodes (channel_id, episode_id, broadcast_time, broadcast_viewers_number) VALUES (1, 1, '2023-05-12 20:00:00', 500), (2, 2, '2023-05-12 21:00:00', 800);

```

### ⚫ 手順2 MySQLコマンドクライアントの起動
MySQLのコマンドラインクライアントを起動します。これは通常、システムのコマンドラインインターフェース（例えば、Windowsの場合はコマンドプロンプト、MacやLinuxの場合はターミナル）から下のように入力して行います。ここで username はあなたのMySQLユーザー名に置き換えます。パスワードを求められるので、それを入力します。

```zsh
mysql -u username -p
```

### ⚫ 手順3： SQLスクリプトの実行

以下のコマンドを入力して `setup.sql` ファイルを実行します。

```bash
source /path/to/your/setup.sql
```

ここで `/path/to/your/` は `setup.sql` ファイルが保存されている実際のパスに置き換えます。

これにより、`setup.sql` ファイル内のすべてのSQLステートメントが順に実行され、データベースとテーブルが作成され、そしてサンプルデータが投入されます。

なお、各環境（Windows、Mac、Linux等）やインストールしたMySQLのバージョンによってコマンドが異なる場合がありますので、詳細はMySQLの公式ドキュメンテーションや、その他のオンラインリソースをご参照ください。
