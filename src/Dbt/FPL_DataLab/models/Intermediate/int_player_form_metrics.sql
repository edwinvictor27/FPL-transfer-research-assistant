with cte as (

select fs.*, 
    gws.gameweek, 

    sum(fs.goals_scored) 
    over(
        partition by fs.player_id 
        order by gws.gameweek 
        rows between 4 preceding and current row
         ) as goals_scored_in_last_5_games,

    sum(fs.assists) 
    over( 
        partition by fs.player_id
        order by gws.gameweek asc 
        rows between 4 preceding and current row
    ) as assists_in_last_5_games,

    round(avg(fs.defcon) over(
        partition by fs.player_id
        order by gws.gameweek asc
        rows between 4 preceding and current row
    ), 2) as avg_defcon_in_last_five_game,

    round(avg(fs.bps)
    over(
        partition by fs.player_id
        order by gws.gameweek
        rows between 4 preceding and current row
    ), 2) as avg_bps_in_last_five_game,

    sum(fs.bonus) over(
        partition by fs.player_id
        order by gws.gameweek
        rows between 4 preceding and current row
    ) as total_bonus_points_in_last_5_games,

    round(avg(fs.saves) over(
        partition by fs.player_id
        order by gws.gameweek
        rows between 4 preceding and current row
    ), 2) as avg_saves_in_last_5_games,

    sum(Case when fs.team_side = 'h' then fs.goals_scored else 0 end) over(
        partition by fs.player_id, fs.team_side
        order by gws.gameweek
        rows between 4 preceding and current row
    ) as total_goals_scored_at_home_in_last_5_home_games,

    sum(case when fs.team_side = 'a' then fs.goals_scored else 0 end) over(
        partition by fs.player_id, fs.team_side
        order by gws.gameweek
        rows between 4 preceding and current row
    ) as total_goals_scored_at_away_in_last_5_away_games, 

    sum(case when fs.team_side = 'h' then fs.assists else 0 end) over(
        partition by fs.player_id, fs.team_side
        order by gws.gameweek
        rows between 4 preceding and current row 
    ) as total_assists_at_home_in_last_5_home_games,

    sum(case when fs.team_side = 'a' then fs.assists else 0 end) over(
        partition by fs.player_id, fs.team_side
        order by gws.gameweek
        rows between 4 preceding and current row
    ) as total_assists_at_away_in_last_5_away_games,

    round(avg(case when fs.team_side = 'h' then fs.defcon else 0 end) over(
        partition by fs.player_id, fs.team_side
        order by gws.gameweek
        rows between 4 preceding and current row
    ), 2) as avg_defcon_at_home_in_last_5_home_games,

    round(avg(case when fs.team_side = 'a' then fs.defcon else 0 end) over(
        partition by fs.player_id, fs.team_side
        order by gws.gameweek
        rows between 4 preceding and current row
    ), 2) as avg_defcon_at_away_in_last_5_away_games

from 
    {{ref('int_player_fixture_statistics')}} as fs 
left join 
    {{ref('int_player_gameweek_statistics')}} as gws 
on (fs.player_id = gws.player_id) and (fs.fixture_id = gws.fixture_id)

)
select 
    gameweek, 
    cte.player_id, 
    pms.recent_form_rating,
    total_minutes_played,
    total_games_starts,
    round(
    total_minutes_played * 100.0 /
    nullif(gameweek * 90, 0), 2) as minutes_played_percentage, 
    round(
    total_games_starts * 100.0 /
    nullif(gameweek, 0), 2) as games_starts_percentage,
    goals_scored_in_last_5_games, 
    assists_in_last_5_games, 
    avg_defcon_in_last_five_game,
    avg_bps_in_last_five_game,
    total_bonus_points_in_last_5_games,
    avg_saves_in_last_5_games,
    total_goals_scored_at_home_in_last_5_home_games,
    total_goals_scored_at_away_in_last_5_away_games, 
    total_assists_at_home_in_last_5_home_games,
    total_assists_at_away_in_last_5_away_games,
    avg_defcon_at_home_in_last_5_home_games,
    avg_defcon_at_away_in_last_5_away_games
from 
    cte
left join {{ref('int_player_market_statistics')}} as pms 
on cte.player_id = pms.player_id
order by cte.gameweek asc, cte.player_id asc 
