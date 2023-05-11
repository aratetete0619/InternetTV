## STEP3 データ抽出
1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
```sql
SELECT title, viewers_number 
FROM episodes 
ORDER BY viewers_number DESC
LIMIT 3;
```
[![Image from Gyazo](https://i.gyazo.com/5e9c563396eccedcf5b395bdd92a713b.png)](https://gyazo.com/5e9c563396eccedcf5b395bdd92a713b)


2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
```sql
FROM episodes e
JOIN seasons s ON e.season_id = s.id
JOIN programs p ON s.program_id = p.id                                                                  
ORDER BY e.viewers_number DESC                                                                          
LIMIT 3;
```          

[![Image from Gyazo](https://i.gyazo.com/194f41395f1acf26eaebd8de806ff16e.png)](https://gyazo.com/194f41395f1acf26eaebd8de806ff16e)

3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします(本日は、2023-05-12ということを想定します)
```sql
SELECT 
    c.name AS channel_name,
    ce.broadcast_time AS broadcast_start_time,
    DATE_ADD(ce.broadcast_time, INTERVAL e.duration MINUTE) AS broadcast_end_time,
    s.season_number AS season_number,
    e.episode_number AS episode_number,
    e.title AS episode_title,
    e.description AS episode_description
FROM
    Channel_Episodes ce
JOIN
    Channels c ON ce.channel_id = c.id
JOIN
    Episodes e ON ce.episode_id = e.id
JOIN
    Seasons s ON e.season_id = s.id
JOIN
    Programs p ON s.program_id = p.id
WHERE
    DATE(ce.broadcast_time) = '2023-05-12'
ORDER BY
    ce.broadcast_time;
```

[![Image from Gyazo](https://i.gyazo.com/98b06c9eb2c0d1a57e5926da748498c8.png)](https://gyazo.com/98b06c9eb2c0d1a57e5926da748498c8)



4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください(ここでは`ドラマ`を
`Channel 1`と仮定します)
```sql
SELECT 
    ce.broadcast_time AS broadcast_start_time,
    DATE_ADD(ce.broadcast_time, INTERVAL e.duration MINUTE) AS broadcast_end_time,
    s.season_number AS season_number,
    e.episode_number AS episode_number,
    e.title AS episode_title,
    e.description AS episode_description
FROM
    Channel_Episodes ce
JOIN
    Channels c ON ce.channel_id = c.id
JOIN
    Episodes e ON ce.episode_id = e.id
JOIN
    Seasons s ON e.season_id = s.id
JOIN
    Programs p ON s.program_id = p.id
WHERE
    c.name = 'Channel 1'
AND 
    DATE(ce.broadcast_time) BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY
    ce.broadcast_time;
```
[![Image from Gyazo](https://i.gyazo.com/f7b51a6cb92f135d4c11851e4e723e61.png)](https://gyazo.com/f7b51a6cb92f135d4c11851e4e723e61)


5. (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください
```sql
SELECT 
    p.title AS program_title,
    SUM(e.total_viewers_number) AS total_viewers
FROM
    Episodes e
JOIN
    Seasons s ON e.season_id = s.id
JOIN
    Programs p ON s.program_id = p.id
JOIN
    Channel_Episodes ce ON ce.episode_id = e.id
WHERE
    DATE(ce.broadcast_time) BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE()
GROUP BY
    p.id
ORDER BY
    total_viewers DESC
LIMIT 2;
```
[![Image from Gyazo](https://i.gyazo.com/a297ea456049748dc13e200865478b02.png)](https://gyazo.com/a297ea456049748dc13e200865478b02)

6. (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。
```sql
SELECT 
    g.name AS genre_name,
    top_programs.program_title,
    top_programs.average_viewers
FROM
    Genres g
JOIN
    (
        SELECT 
            pg.genre_id,
            p.title AS program_title,
            AVG(e.total_viewers_number) AS average_viewers
        FROM
            Programs p
        JOIN
            Seasons s ON p.id = s.program_id
        JOIN
            Episodes e ON s.id = e.season_id
        JOIN
            Program_Genres pg ON p.id = pg.program_id
        GROUP BY
            p.id, pg.genre_id
        ORDER BY
            average_viewers DESC
    ) AS top_programs ON g.id = top_programs.genre_id;
```
[![Image from Gyazo](https://i.gyazo.com/4f54c2e1f627d17e5483f0aae0be18a5.png)](https://gyazo.com/4f54c2e1f627d17e5483f0aae0be18a5)
