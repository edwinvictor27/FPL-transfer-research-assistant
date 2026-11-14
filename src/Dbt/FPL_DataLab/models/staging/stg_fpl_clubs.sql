select 
    team_id,
    short_name as team_short_name,
    code as team_code,
    club_name as football_club_name 
from {{source( 'fpl', 'clubs')}}  