import sys
import json
import time
import yfinance as yf
import os

# documentation: https://ibkrcampus.com/campus/ibkr-api-page/webapi-doc/#sessions-in-the-web-api-13
# to check if authenticated https://localhost:5000/v1/api/iserver/auth/status
# to get account info https://localhost:5000/v1/api/portfolio/accounts
# to get positions https://localhost:5000/v1/api/portfolio/<ACCOUNTID>/positions/0


def create_strings(portfolio) -> list[str]:
    tickers = [position["ticker"] for position in portfolio]

    data = yf.download(tickers, period="2d")

    # check if data is None
    if data is None or data.empty:
        return []

    data = data["Close"]

    res = []
    for position in portfolio:
        today = data[position["ticker"]].iloc[-1]
        yesterday = data[position["ticker"]].iloc[-2]
        change = today - yesterday
        percent = (change / yesterday) * 100
        pnl = (today / position["avgPrice"] - 1) * 100
        res.append(
            f'<span color="{"#fb4934" if percent < 0 else "#b8bb26"}"><b>{position["ticker"]}</b> {today:.2f} {percent:.2f}%</span>  <span color="{"#fb4934" if pnl < 0 else "#b8bb26"}">{pnl:.2f}%</span>'
        )
    return res


def render_portfolio(portfolio):
    positions = create_strings(portfolio)
    cnt = 0
    while True:
        for position in positions:
            sys.stdout.write(
                json.dumps({
                    "text": position,
                    "markup": "pango",
                    "tooltip": "".join(s + "\n" for s in positions),
                })
                + "\n"
            )
            sys.stdout.flush()
            cnt += 1
            if cnt == 20:
                positions = create_strings(portfolio)
                cnt = 0
            time.sleep(4)


def main():
    with open(os.path.expanduser("~/.config/waybar/portfolio.json"), "r") as f:
        portfolio = json.load(f)
        render_portfolio(portfolio)


if __name__ == "__main__":
    main()
