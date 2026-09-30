import requests as rq
import pandas as pd
from sqlalchemy import create_engine, text

url = "https://fantasy.premierleague.com/api/bootstrap-static/"
response = rq.get(url)
print(response.status_code)

fpl_data = response.json()
keys_data = fpl_data.keys()
print(keys_data)

for keys, values in fpl_data.items(): #if the top level layer of json in dict this will help us to investigate the data type of the keys
    print(keys, "->", type(values))

elements_types = fpl_data["element_types"]
print(elements_types)

player_position_elements = []
for position in fpl_data["element_types"]:
    player_position_elements.append(
        {
        "Position_Name_Full"  : position["singular_name"],
        "Position_Name_Short" : position["singular_name_short"],
        "Maximum_Players_Allowed" : position["squad_select"],
        "Players_Count" : position["element_count"]
        }
                                    )

df_positions = pd.DataFrame(player_position_elements)
print(df_positions)

engine = create_engine("mysql+pymysql://root:@localhost/fpl_database")

df_positions.to_sql(
    name="player_positions_fpl",
    con=engine,
    if_exists='append',
    index=False
)



















