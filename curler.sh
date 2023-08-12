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
# or just use $1, $2, $3...
# in case I decide to change the API structure,
# I'll declare them into variables
function="$1"
ticker="$2"
third_arg="$3"


case "$1" in
    # TOP_GAINERS_LOSERS and most active...
    TGLAT*|TGLATS*|GAINERS*|LOSERS*|TOPGAINERSLOSERS*)
        url="${baseUrl}TOP_GAINERS_LOSERS"
        ;;
    OVERVIEW*)
        url="${baseUrl}OVERVIEW&symbol=${ticker}"
        ;;
    INCOME_STATEMENT*|INCOME*|STATEMENT*|INCOMESTATEMENT*)
        url="${baseUrl}INCOME_STATEMENT&symbol=${ticker}"
        ;;
    BALANCE_SHEET*|BALANCESHEET*|BALANCE*)
        url="${baseUrl}BALANCE_SHEET&symbol=${ticker}"
        ;;
    CASH_FLOW*|CASHFLOW*)
        url="${baseUrl}CASH_FLOW&symbol=${ticker}"
        ;;
    EARNINGS*)
        url="${baseUrl}EARNINGS&symbol=${ticker}"
        ;;
    # Commodities and Macro Indicators
    WTI*|BRENT*|NATURAL_GAS*|GAS*|COPPER*|ALUMINUM*|WHEAT*|CORN*|COTTON*|SUGAR*|COFFEE*|ALL_COMMODITIES*|GDP*|GDPPC*|GDPPERCAP*|FEDFUNDSRATE*|FEDFUNDS*|FUNDS*|EFFECTIVEFEDERALFUNDSRATE*|EFFR*|CPI*|INFLATION*|RETAILSALES*|RETAIL*|DURABLES*|UNEMPLOYMENT*|NONFARMPAYROLL*|NONFARM*|PAYROLL*|EMPLOYMENT*|BOND*|YIELD*|TREASURY*|TREASURY_YIELD*)
        case "$function" in
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
                function="TREASURY_YIELD"
                maturity="$third_arg"
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

        url="${baseUrl}${function}&${interval}"
        ;;

            # FX_DAILY
    EXCHANGE*|CURRENCY*|RATE*)
        from="$ticker"
        to="$third_arg"
        url="${baseUrl}FX_DAILY&outputsize=full&from_symbol=${from}&to_symbol=${to}"
        ;;

    # Time Series IntraDay
    # Date-based query
    [0-9][0-9][0-9][0-9]-[0-9][0-9]) #e.g. 2003-03
        refDate="2000-01"
        if [ "$function" \< "$refDate" ]; then
            echo "Error: Date is before 2000-01"
            exit 1
        fi
        url="${baseUrl}TIME_SERIES_INTRADAY&month=${function}&interval=1min&symbol=${ticker}&outputsize=full"
        ;;
    *)
        url="${baseUrl}TIME_SERIES_DAILY&symbol=${function}"
        ;;

esac

echo $url
curl "$url"