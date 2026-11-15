SELECT
    id AS player_id,
    team AS team_id,
    first_name AS player_first_name,
    second_name AS player_last_name,
    web_name AS player_display_name,
    form AS recent_form_rating,
    Value_form AS form_value_ratio,
    value_season AS season_value_ratio,
    ROUND(now_cost * 0.1, 2) AS current_price_millions_gbp,
    in_dreamteam AS is_in_weekly_dream_team,
    transfers_in AS total_transfers_in,
    transfers_out AS total_transfers_out
FROM {{ref('stg_fpl_player_data')}}