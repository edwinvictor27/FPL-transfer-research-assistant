import requests as rq
import pandas as pd
from sqlalchemy import create_engine

url = "https://fantasy.premierleague.com/api/fixtures/"
response = rq.get(url)

print(response.status_code)
fpl_fixtures_data = response.json()

fixtures_df = pd.DataFrame(fpl_fixtures_data)

fixtures_df = fixtures_df[
    [
        "id",
        "code",
        "event",
        "kickoff_time",
        "finished",
        "finished_provisional",
        "started",
        "minutes",
        "team_h",
        "team_a",
        "team_h_score",
        "team_a_score",
        "team_h_difficulty",
        "team_a_difficulty",
        "pulse_id"
    ]
]

fixtures_df.rename(
    columns={"id": "fixture_id"},
    inplace=True
)

print(fixtures_df)

stats_rows = []

for fixture in fpl_fixtures_data:

    fixture_id = fixture["id"]

    for stat in fixture.get("stats", []):

        stat_type = stat["identifier"]

        for team_side in ["h", "a"]:

            for player in stat.get(team_side, []):

                stats_rows.append({
                    "fixture_id": fixture_id,
                    "stat_type": stat_type,
                    "team_side": team_side,
                    "player_id": player["element"],
                    "value": player["value"]
                })


stats_df = pd.DataFrame(stats_rows)

print(stats_df)

engine = create_engine(
    "mysql+pymysql://root:@localhost/fpl_database"
)



fixtures_df.to_sql(
    "fixtures",
    con=engine,
    if_exists="append",
    index=False
)

stats_df.to_sql(
    "fixture_player_stats",
    con=engine,
    if_exists="append",
    index=False
)


print("Ingestion completed successfully.")
