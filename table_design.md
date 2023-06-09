## STEP1 テーブル設計

**テーブル：Users**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | bigint(20) |  | PRIMARY |  | YES |
| name | varchar(100) |  |  |  |  |
| email | varchar(100) |  | INDEX |  |  |

ユニークキー制約：email カラムに対して設定

**テーブル：Channels**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | bigint(20) |  | PRIMARY |  | YES |
| name | varchar(100) |  |  |  |  |

**テーブル：Programs**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | bigint(20) |  | PRIMARY |  | YES |
| title | varchar(100) |  |  |  |  |
| description | longtext |  |  |  |  |

**テーブル：Seasons**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | bigint(20) |  | PRIMARY |  | YES |
| program_id | bigint(20) |  | FOREIGN, UNIQUE |  |  |
| season_number | int(11) |  | UNIQUE |  |  |

**テーブル：Episodes**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | bigint(20) |  | PRIMARY |  | YES |
| season_id | bigint(20) |  | FOREIGN, UNIQUE |  |  |
| episode_number | int(11) |  | UNIQUE |  |  |
| title | varchar(100) |  |  |  |  |
| description | longtext |  |  |  |  |
| duration | int(11) |  |  |  |  |
| release_date | date |  |  |  |  |
| total_viewers_number | bigint(20) |  |  |  |  |

**テーブル：Genres**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | bigint(20) |  | PRIMARY |  | YES |
| name | varchar(100) |  |  |  |  |

**テーブル：Program_Genres**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| program_id | bigint(20) |  | FOREIGN |  |  |
| genre_id | bigint(20) |  | FOREIGN |  |  |

**テーブル：Channel_Episodes**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| channel_id | bigint(20) |  | PRIMARY |  |  |
| episode_id | bigint(20) |  | PRIMARY |  |  |
| broadcast_time | datetime |  | PRIMARY |  |  |
| broadcast_viewers_number | bigint(20) |  |  |  |  |


### ER図

![ER図](https://showme.redstarplugin.com/s/lC0XvLLX)
