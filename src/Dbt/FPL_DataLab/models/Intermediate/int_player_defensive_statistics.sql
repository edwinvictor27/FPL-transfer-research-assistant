SELECT
    id AS player_id,
    clearances_blocks_interceptions AS total_clearances_blocks_interceptions,
    recoveries AS total_ball_recoveries,
    tackles AS total_tackles,
    defensive_contribution AS total_defensive_contributions,
    expected_goals_conceded AS expected_goals_conceded_xgc,
    expected_goals_conceded_per_90 AS expected_goals_conceded_per_90_minutes,
    goals_conceded_per_90 AS goals_conceded_per_90_minutes,
    saves_per_90 AS saves_per_90_minutes,
    clean_sheets_per_90 AS clean_sheets_per_90_minutes,
    defensive_contribution_per_90 AS defensive_contributions_per_90_minutes
FROM {{ ref('stg_fpl_player_data') }}