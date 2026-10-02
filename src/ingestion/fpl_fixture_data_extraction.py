import requests as rq

url = "https://fantasy.premierleague.com/api/fixtures/"
response = rq.get(url)

print(response.status_code)
fpl_fixtures_data = response.json()

print(type(fpl_fixtures_data))

fixtures_list = []

for fixture in fpl_fixtures_data:
    fixtures_list.append(fixture)


print(fixtures_list[1].keys())
