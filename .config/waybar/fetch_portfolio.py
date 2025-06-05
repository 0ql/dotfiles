from dotenv import load_dotenv
from pandas import os
import requests
import json
import subprocess
import urllib3

load_dotenv()

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


def check_status() -> bool:
    try:
        r = requests.get(
            "https://localhost:5000/v1/api/iserver/auth/status",
            verify=False,
        )
    except requests.exceptions.RequestException:
        print("Error connecting to server")
        return False

    if r.status_code != 200:
        print(f"Error checking status: Code {r.status_code}")
        return False
    else:
        data = r.json()
        if not data.get("authenticated"):
            print("Not authenticated")
            return False
        print("Authenticated successfully")
        return True


def fetch_portfolio():
    r = requests.get(
        f"https://localhost:5000/v1/api/portfolio/{os.getenv('IBKR_ACCOUNT')}/positions/0",
        verify=False,
    )
    if r.status_code != 200:
        return None
    return r.json()


if check_status():
    res = fetch_portfolio()
    if res is not None:
        with open("portfolio.json", "w") as f:
            json.dump(res, f, indent=4)
else:
    subprocess.Popen(["xdg-open", "https://localhost:5000"])
