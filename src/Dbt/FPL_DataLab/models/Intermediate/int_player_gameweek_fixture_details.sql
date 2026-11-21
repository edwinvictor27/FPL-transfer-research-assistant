with gameweek_stats_with_fixture_details as (
select 
    pgws.player_id, 
    pgws.team_id, 
    pgws.fixture_id, 
    pgws.gameweek,
    pgws.goals_scored, 
    pgws.assists, 
    pgws.yellow_cards, 
    pgws.red_cards,
    pgws.saves,
    pgws.bonus, 
    pgws.bps, 
    pgws.defcon,
    fts.home_team, 
    fts.away_team, 
    fts.home_team_score, 
    fts.away_team_score, 
    fts.home_team_difficulty, 
    fts.away_team_difficulty 
from 
    {{ref('int_player_gameweek_statistics')}} pgws
left join
    {{ref('stg_fixture_team_stats')}} fts 
on 
    pgws.fixture_id = fts.fixture_id and pgws.gameweek = fts.event
),
gameweek_stats_with_home_and_away_details as(
    select 
        player_id,
        team_id,
        fixture_id,
        gameweek,
        case when team_id = home_team then 'Home'
        when team_id = away_team then 'Away' 
        else 'Neutral' End as venue_type,
        goals_scored, 
        assists, 
        yellow_cards, 
        red_cards,
        saves,
        bonus, 
        bps, 
        defcon,
        case when  team_id = home_team then home_team_difficulty
        when team_id = away_team then away_team_difficulty 
        else 0 End as team_difficulty,
        home_team_score,
        away_team_score
    from 
        gameweek_stats_with_fixture_details
)
select * from gameweek_stats_with_home_and_away_details