WITH player_fixture_stats AS (

    SELECT
        fixture_id,
        player_id,
        stat_type,
        team_side,
        SUM(value) AS value

    FROM {{ref('stg_fixture_player_stats')}}

    GROUP BY
        fixture_id,
        player_id,
        stat_type,
        team_side

)

SELECT
    fixture_id,
    player_id,
    team_side,

    SUM(CASE WHEN stat_type = 'goals_scored'
        THEN value ELSE 0 END) AS goals_scored,

    SUM(CASE WHEN stat_type = 'assists'
        THEN value ELSE 0 END) AS assists,

    SUM(CASE WHEN stat_type = 'yellow_cards'
        THEN value ELSE 0 END) AS yellow_cards,

    SUM(CASE WHEN stat_type = 'red_cards'
        THEN value ELSE 0 END) AS red_cards,

    SUM(CASE WHEN stat_type = 'saves'
        THEN value ELSE 0 END) AS saves,

    SUM(CASE WHEN stat_type = 'bonus'
        THEN value ELSE 0 END) AS bonus,

    SUM(CASE WHEN stat_type = 'bps'
        THEN value ELSE 0 END) AS bps,

    SUM(CASE WHEN stat_type = 'defensive_contribution'
        THEN value ELSE 0 END) AS defcon,

    SUM(CASE WHEN stat_type = 'own_goals'
        THEN value ELSE 0 END) AS own_goals_scored,

    SUM(CASE WHEN stat_type = 'penalties_missed'
        THEN value ELSE 0 END) AS penalties_missed,

    SUM(CASE WHEN stat_type = 'penalties_saved'
        THEN value ELSE 0 END) AS penalties_saved

FROM player_fixture_stats

GROUP BY
    fixture_id,
    player_id,
    team_side

ORDER BY player_id;

