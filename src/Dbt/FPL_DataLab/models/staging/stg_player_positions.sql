select 
    index,
    Position_Name_Full as position_name_full,
    Position_Name_Short as position_name_short,
    Maximum_Players_Allowed as maximum_players_allowed_per_role,
    Player_Count as player_count
from {{source('fpl', 'fpl_player_positions')}}