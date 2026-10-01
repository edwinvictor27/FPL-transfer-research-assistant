import requests as rq
from sqlalchemy import create_engine
import pandas as pd
url = "https://fantasy.premierleague.com/api/bootstrap-static/"

response = rq.get(url)
fpl_data = response.json()
data_key = fpl_data.keys()
print(data_key)
teams_investigate = fpl_data["chips"]

chips_list = []
for chips in teams_investigate:
    chips_list.append({
        "Chip_Name" : chips["name"],
        "Start_Gameweek" : chips["start_event"],
        "End_Gameweek" : chips["stop_event"],
        "chip_type" : chips["chip_type"]
    })

df_chips = pd.DataFrame(chips_list)
engine = create_engine("mysql+pymysql://root:@localhost/fpl_database") 

df_chips.to_sql(
    name= "fpl_chips",
    con= engine,
    if_exists="append",
    index=False
    )


