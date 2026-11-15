SELECT
    id AS player_id,
    first_name AS player_first_name,
    second_name AS player_last_name,
    web_name AS player_display_name,
    team_code AS team_code,
    influence AS fpl_influence_score,
    creativity AS fpl_creativity_score,
    threat AS fpl_threat_score,
    ict_index AS fpl_ict_index_score,
    expected_goals AS expected_goals_xg,
    expected_assists AS expected_assists_xa,
    expected_goal_involvements AS expected_goal_involvements_xgi,
    expected_goals_per_90 AS expected_goals_per_90_minutes,
    expected_assists_per_90 AS expected_assists_per_90_minutes,
    expected_goal_involvements_per_90 AS expected_goal_involvements_per_90_minutes
FROM {{ ref('stg_fpl_player_data') }}