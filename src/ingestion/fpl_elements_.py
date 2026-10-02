import requests as rq 
import pandas as pd
from sqlalchemy import create_engine, text
import pymysql, json


url = "https://fantasy.premierleague.com/api/bootstrap-static/"
response = rq.get(url)
fpl_data = response.json()

keys = fpl_data.keys()

player_stats_list = []
for player_stats in fpl_data["elements"]:
    player_stats_list.append(player_stats)


df_player_stats = pd.DataFrame(player_stats_list)
print(df_player_stats)

for column in df_player_stats.columns:
    df_player_stats[column] = df_player_stats[column].apply(
        lambda x: json.dumps(x) if isinstance(x, (dict, list)) else x
    )

engine = create_engine("mysql+pymysql://root:@localhost/fpl_database") 

df_player_stats.to_sql(
    name="fpl_player_data",
    con=engine,
    if_exists="replace",
    index=False
)

 