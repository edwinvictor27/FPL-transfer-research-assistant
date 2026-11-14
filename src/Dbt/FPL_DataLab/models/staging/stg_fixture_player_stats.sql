select 
    fixture_id,
    player_id,
    stat_type, 
    team_side,
    value
from {{source( 'fpl', 'fixture_player_stats')}}