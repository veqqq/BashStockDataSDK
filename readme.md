### Hi

- quick and dirty version of https://github.com/veqqq/StockDataSDK
- added functionality to coordinate calls

- coordinator calls curler to generate stock reports or macro economic summaries.



### Pls fix



----------

### Usage

- "function" comes first. then ticker 
- need 3 args:
	- baseUrl + "FX_DAILY" + "&outputsize=full" + "&from_symbol=" + from + "&to_symbol=" + to
    - baseUrl + "TIME_SERIES_INTRADAY" + "&month" + tickerFirst + "&interval=1min" + "&symbol=" + tickerNext + "&outputsize=full"
        - needs a 2004-12 formated month

- need 2 args
    - baseUrl + "OVERVIEW" + "&symbol=" + tickerNext
    - baseUrl + "INCOME_STATEMENT" + "&symbol=" + tickerNext
    - baseUrl + "BALANCE_SHEET" + "&symbol=" + tickerNext
    - baseUrl + "CASH_FLOW" + "&symbol=" + tickerNext
    - baseUrl + "EARNINGS" + "&symbol=" + tickerNext
    - baseUrl + "TREASURY_YIELD" + "&interval=daily" + "&maturity=" + maturity
        - maturity is 3month, 2year, 5 year, 7year, 10year, 30year

- only needs a stock ticker?
    - baseUrl + "TIME_SERIES_DAILY" + "&symbol=" + ticker // + "&outputsize=full"

- 1 arg:
    - TOP_GAINERS_LOSERS
    - baseUrl + "WTI" + "&interval=daily"
    - baseUrl + "BRENT" + "&interval=daily"
    - baseUrl + "NATURAL_GAS" + "&interval=daily"
    - baseUrl + "COPPER" + "&interval=quarterly"
    - baseUrl + "ALUMINUM" + "&interval=quarterly"
    - baseUrl + "WHEAT" + "&interval=quarterly"
    - baseUrl + "CORN" + "&interval=quarterly"
    - baseUrl + "COTTON" + "&interval=quarterly"
    - baseUrl + "SUGAR" + "&interval=quarterly"
    - baseUrl + "COFFEE" + "&interval=quarterly"
    - baseUrl + "ALL_COMMODITIES" + "&interval=quarterly"
    - baseUrl + "REAL_GDP" + "&interval=quarterly"
    - baseUrl + "REAL_GDP_PER_CAPITA" + "&interval=quarterly"
    - baseUrl + "FEDERAL_FUNDS_RATE" + "&interval=daily"
    - baseUrl + "CPI" + "&interval=monthly"
    - baseUrl + "INFLATION"
    - baseUrl + "RETAIL_SALES"
    - baseUrl + "DURABLES"
    - baseUrl + "UNEMPLOYMENT"
    - baseUrl + "NONFARM_PAYROLL"