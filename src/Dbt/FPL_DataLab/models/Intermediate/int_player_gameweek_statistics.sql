
WITH player_fixture_gameweek AS (

    SELECT
        p.fixture_id,
        p.player_id,
        p.team_side,
        f.event AS gameweek,

        CASE
            WHEN p.team_side = 'h' THEN f.home_team
            WHEN p.team_side = 'a' THEN f.away_team
        END AS team_id,

        p.goals_scored,
        p.assists,
        p.yellow_cards,
        p.red_cards,
        p.saves,
        p.bonus,
        p.bps,
        p.defcon,
        p.own_goals_scored,
        p.penalties_missed,
        p.penalties_saved

    FROM {{ ref('int_player_fixture_statistics') }} p

    INNER JOIN {{ ref('stg_fixture_team_stats') }} f
        ON p.fixture_id = f.fixture_id

),

player_gameweek_stats AS (

    SELECT
        player_id,
        team_id,
        fixture_id,
        gameweek,

        SUM(goals_scored) AS goals_scored,
        SUM(assists) AS assists,
        SUM(yellow_cards) AS yellow_cards,
        SUM(red_cards) AS red_cards,
        SUM(saves) AS saves,
        SUM(bonus) AS bonus,
        SUM(bps) AS bps,
        SUM(defcon) AS defcon,
        SUM(own_goals_scored) AS own_goals_scored,
        SUM(penalties_missed) AS penalties_missed,
        SUM(penalties_saved) AS penalties_saved

    FROM player_fixture_gameweek

    GROUP BY
        player_id,
        fixture_id,
        team_id,
        gameweek

)

SELECT *
FROM player_gameweek_stats
