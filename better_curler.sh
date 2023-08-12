#!/bin/bash



#load apikey
if [ -f .env ]; then
    source .env
fi

#load apikey, build url from it:
if [ -f .env ]; then
    source .env
fi
apikey="$API_KEY"
baseUrl="https://www.alphavantage.co/query?apikey=${apikey}&function="



# Parse the input arguments
ticker="$1"
if [ -z "$ticker" ]; then
    echo "Usage: $0 TICKER"
    exit 1
fi






# come up with specific api assigning args to everything
case "$ticker" in
    # FX_DAILY
    EXCHANGE*|CURRENCY*|RATE*)
        from="$2"
        to="$3"
        url="${baseUrl}FX_DAILY&outputsize=full&from_symbol=${from}&to_symbol=${to}"
        ;;
    # TOP_GAINERS_LOSERS and most active...
    TGLAT*|TGLATS*|GAINERS*|LOSERS*|TOPGAINERSLOSERS*)
        url="${baseUrl}TOP_GAINERS_LOSERS"
        ;;
    # OVERVIEW
    OVERVIEW*)
        ticker="$2"
        url="${baseUrl}OVERVIEW&symbol=${ticker}"
        ;;
    # INCOME_STATEMENT
    INCOME_STATEMENT*|INCOME*|STATEMENT*|INCOMESTATEMENT*)
        ticker="$2"
        url="${baseUrl}INCOME_STATEMENT&symbol=${ticker}"
        ;;
    # BALANCE_SHEET
    BALANCE_SHEET*|BALANCESHEET*|BALANCE*)
        ticker="$2"
        url="${baseUrl}BALANCE_SHEET&symbol=${ticker}"
        ;;
    # CASH_FLOW
    CASH_FLOW*|CASHFLOW*)
        ticker="$2"
        url="${baseUrl}CASH_FLOW&symbol=${ticker}"
        ;;
    # EARNINGS
    EARNINGS*)
        ticker="$2"
        url="${baseUrl}EARNINGS&symbol=${ticker}"
        ;;
    # Commodities and Macro Indicators
    WTI*|BRENT*|NATURAL_GAS*|GAS*|COPPER*|ALUMINUM*|WHEAT*|CORN*|COTTON*|SUGAR*|COFFEE*|ALL_COMMODITIES*|GDP*|GDPPC*|GDPPERCAP*|FEDFUNDSRATE*|FEDFUNDS*|FUNDS*|EFFECTIVEFEDERALFUNDSRATE*|EFFR*|CPI*|INFLATION*|RETAILSALES*|RETAIL*|DURABLES*|UNEMPLOYMENT*|NONFARMPAYROLL*|NONFARM*|PAYROLL*|EMPLOYMENT*|BOND*|YIELD*|TREASURY*|TREASURY_YIELD*)
        case "$ticker" in
            WTI*|BRENT*|NATURAL_GAS*|GAS*)
                interval="interval=daily"
                ;;
            COPPER*|ALUMINUM*|WHEAT*|CORN*|COTTON*|SUGAR*|COFFEE*|ALL_COMMODITIES*)
                interval="interval=quarterly"
                ;;
            GDP*|GDPPC*|GDPPERCAP*)
                interval="interval=quarterly"
                ;;
            FEDFUNDSRATE*|FEDFUNDS*|FUNDS*|EFFECTIVEFEDERALFUNDSRATE*|EFFR*)
                interval="interval=daily"
                ;;
            CPI*)
                interval="interval=monthly"
                ;;
            INFLATION*)
                ;;
            RETAILSALES*|RETAIL*)
                ;;
            DURABLES*)
                ;;
            UNEMPLOYMENT*)
                ;;
            NONFARMPAYROLL*|NONFARM*|PAYROLL*|EMPLOYMENT*)
                ;;
            BOND*|YIELD*|TREASURY*|TREASURY_YIELD*)
                maturity="$(echo "$ticker" | cut -d ' ' -f 2)"
                case "$maturity" in
                    3|3m|3month)
                        maturity="3month"
                        ;;
                    2|2y|2yr|2year)
                        maturity="2year"
                        ;;
                    5|5y|5yr|5year)
                        maturity="5year"
                        ;;
                    7|7y|7yr|7year)
                        maturity="7year"
                        ;;
                    10|10y|10yr|10year)
                        maturity="10year"
                        ;;
                    30|30y|30yr|30year)
                        maturity="30year"
                        ;;
                esac
                interval="interval=daily"
                ;;
        esac

        url="${baseUrl}${ticker}&${interval}"
        ;;
    # Date-based query
    [0-9][0-9][0-9][0-9]-[0-9][0-9])
        refDate="2000-01"
        if [ "$ticker" \< "$refDate" ]; then
            echo "Error: Date is before 2000-01"
            exit 1
        fi
        tickerNext="$(echo "$ticker" | cut -d ' ' -f 2)"
        url="${baseUrl}TIME_SERIES_INTRADAY&month=${ticker}&interval=1min&symbol=${tickerNext}&outputsize=full"
        ;;
    *)
        url="${baseUrl}TIME_SERIES_DAILY&symbol=${ticker}"
        ;;
esac

echo $url
curl "$url"