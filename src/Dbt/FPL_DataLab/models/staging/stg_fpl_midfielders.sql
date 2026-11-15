select 
    name as player_name,
    team_name,
    position as player_position
from {{source('fpl', 'fpl_midfielders')}} 