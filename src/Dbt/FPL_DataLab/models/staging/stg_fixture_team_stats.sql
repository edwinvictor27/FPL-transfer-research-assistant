select 
    fixture_id,
    code,
    event,
    kickoff_time,
    finished,
    finished_provisional,
    started,
    minutes, 
    team_h as home_team, 
    team_a as away_team, 
    team_h_score as home_team_score, 
    team_a_score as away_team_score, 
    team_h_difficulty as home_team_difficulty, 
    team_a_difficulty as away_team_difficulty
from {{source('fpl', 'fixture_team_stats')}}