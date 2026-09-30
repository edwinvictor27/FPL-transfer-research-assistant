import requests


BASE_URL = "https://fantasy.premierleague.com/api"


def fetch_data(endpoint):
    """Fetch JSON data from the FPL API."""
    url = f"{BASE_URL}/{endpoint}"

    response = requests.get(
        url,
        headers={"User-Agent": "FPL-Transfer-Research-Assistant/1.0"},
        timeout=30,
    )

    response.raise_for_status()

    return response.json()


def get_bootstrap_data():
    """Get the main FPL dataset."""
    return fetch_data("bootstrap-static/")


def get_fixtures():
    """Get all FPL fixtures."""
    return fetch_data("fixtures/")


def get_player_summary(player_id):
    """Get history and upcoming fixtures for a player."""
    return fetch_data(f"element-summary/{player_id}/")


def main():
    data = get_bootstrap_data()

    print("FPL API connection successful")
    print(f"Players: {len(data['elements'])}")
    print(f"Teams: {len(data['teams'])}")
    print(f"Gameweeks: {len(data['events'])}")


if __name__ == "__main__":
    main()