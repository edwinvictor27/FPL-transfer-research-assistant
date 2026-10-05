import requests as rq 
import pandas as pd
from sqlalchemy import create_engine

url = "https://fantasy.premierleague.com/api/bootstrap-static/"

response = rq.get(url)
fpl_data = response.json()

teams_list = []
for i in fpl_data["teams"] : 
    teams_list.append({
        "team_id" : i["id"],
        "code" : i["code"],
        "club_name" : i["name"],
        "short_name" : i["short_name"]
    })


fpl_team_df = pd.DataFrame(teams_list)

connection = create_engine("mysql+pymysql://root:@localhost/fpl_database")

fpl_team_df.to_sql(
    name="fpl_teams",
    con=connection,
    if_exists="append",
    index=False
)



