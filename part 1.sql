-- Assignment 6
--
-- Author: Oleksandr Kuprii
-- Student number: 510190
-- Part 1
--1

SELECT
	first_name,
	last_name
FROM
	player
WHERE
	first_name LIKE '%a%'
	OR last_name LIKE '%a';

--2
SELECT
	player.first_name,
	player.last_name,
	team.name
FROM
	player
	JOIN team ON team.team_id = player.team_id
WHERE
	first_name LIKE '%a%'
	OR last_name LIKE '%a';

--3
SELECT
	(
		SELECT
			name
		FROM
			team
		WHERE
			team_id = match.home_team_id) AS 'home team', 
	(
		SELECT
			name
		FROM
			team
		WHERE
			team_id = match.away_team_id) AS 'away team', 
	match.date, 
	match.start_time
FROM
	match
WHERE
	date >= datetime ('now');

--4
SELECT
	match.*
FROM
	match
	JOIN match_stage ON match_stage.match_stage_id = match.match_stage_id
WHERE
	match_stage.name = 'A';

--5
SELECT
	match.*
FROM
	match
	JOIN match_stage ON 
	match_stage.match_stage_id = match.match_stage_id
WHERE
	match_stage.name = '1/4';

--6
SELECT
	player.first_name,
	player.last_name,
	count(match_event.player_id) AS 'scored'
FROM
	match_event
	JOIN event_type ON event_type.event_type_id = match_event.event_type_id
	JOIN player ON player.player_id = match_event.player_id
WHERE
	event_type.name = 'Goal'
GROUP BY
	match_event.player_id
ORDER BY
	scored DESC;

--7
SELECT
	(
		SELECT
			name
		FROM
			team
		WHERE
			team_id = match.home_team_id) AS 'home team', 
	(
		SELECT
			name
		FROM
			team
		WHERE
			team_id = match.away_team_id) AS 'away team', 
	match.date, 
	match.start_time
FROM
	"match"
WHERE
	match.date <= datetime ('now')
ORDER BY 
	match.date DESC, 
	match.start_time DESC;

--8
SELECT
	home_team_score,
	away_team_score
FROM
	"match"
WHERE
	match_id = 1;

--9
SELECT
	player.first_name,
	player.last_name,
	event_type.name,
	match_event.time
FROM
	match_event
	JOIN player ON player.player_id = match_event.player_id
	JOIN event_type ON event_type.event_type_id = match_event.event_type_id
WHERE
	match_id = 1
ORDER BY
	match_event.time;

--10
SELECT
	team.name,
	count(*) AS 'number of games'
FROM
	match
	JOIN team ON team.team_id = match.home_team_id
		OR team.team_id = match.away_team_id
WHERE
	team.name = 'Belgium';

--11
SELECT sum(count) 'number of draws'
FROM (
	SELECT
		count(*) AS count
	FROM
		match
		JOIN team ON team.team_id = match.home_team_id
		JOIN match_result ON match_result.match_result_id = match.home_team_result
	WHERE
		team.name = 'Belgium' AND match_result.name = 'draw'
		
	UNION ALL
	
	SELECT
		count(*) AS count
	FROM 
		match
		JOIN team ON team.team_id = match.away_team_id
		JOIN match_result ON match_result.match_result_id = match.away_team_result
	WHERE
		team.name = 'Belgium' AND match_result.name = 'draw'
);

--12
SELECT sum(count) 'number of wins in group stage'
FROM (
	SELECT
		count(*) AS count
	FROM
		match
		JOIN team ON team.team_id = match.home_team_id
		JOIN match_result ON match_result.match_result_id = match.home_team_result
		JOIN match_stage ON match_stage.match_stage_id = "match".match_stage_id
	WHERE
		team.name = 'Uruguay' AND match_result.name = 'win' AND match_stage."group" = 1
		
	UNION ALL
	
	SELECT
		count(*) AS count
	FROM 
		match
		JOIN team ON team.team_id = match.away_team_id
		JOIN match_result ON match_result.match_result_id = match.away_team_result
		JOIN match_stage ON match_stage.match_stage_id = "match".match_stage_id
	WHERE
		team.name = 'Uruguay' AND match_result.name = 'win' AND match_stage."group" = 1
);

--13
SELECT sum(count) 'number of losses in group stage'
FROM (
	SELECT
		count(*) AS count
	FROM
		match
		JOIN team ON team.team_id = match.home_team_id
		JOIN match_result ON match_result.match_result_id = match.home_team_result
		JOIN match_stage ON match_stage.match_stage_id = "match".match_stage_id
	WHERE
		team.name = 'Egypt' AND match_result.name = 'loss' AND match_stage."group" = 1
		
	UNION ALL
	
	SELECT
		count(*) AS count
	FROM 
		match
		JOIN team ON team.team_id = match.away_team_id
		JOIN match_result ON match_result.match_result_id = match.away_team_result
		JOIN match_stage ON match_stage.match_stage_id = "match".match_stage_id
	WHERE
		team.name = 'Egypt' AND match_result.name = 'loss' AND match_stage."group" = 1
);

--14
SELECT
	team.name,
	sum(score) AS 'number of goals'
FROM (
	SELECT
		match.home_team_id AS t,
		sum(home_team_score) AS score
	FROM
		match
	WHERE
		match.home_team_id = 3
		
	UNION ALL
	
	SELECT
		match.away_team_id AS t,
		sum(away_team_score) AS score
	FROM
		match
	WHERE
		match.away_team_id = 3)
	JOIN team ON team.team_id = t;

--15
SELECT
	team.name,
	sum(score) AS "number of opponents' goals"
FROM (
	SELECT
		match.home_team_id AS t,
		sum(away_team_score) AS score
	FROM
		match
	WHERE
		match.home_team_id = 3
		
	UNION ALL
	
	SELECT
		match.away_team_id AS t,
		sum(home_team_score) AS score
	FROM
		match
	WHERE
		match.away_team_id = 3)
	JOIN team ON team.team_id = t;
