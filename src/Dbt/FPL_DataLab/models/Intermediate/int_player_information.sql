SELECT 
    id as player_id,
    team as team_id,
    first_name as player_first_name,
    second_name as player_last_name,
    web_name as player_display_name,
    selected_by_percent as selected_by_percentage
From {{ref('stg_fpl_player_data')}}


