#!/usr/bin/env bash

# This calls curler.sh multiple times to generate a full report on a chosen 
# equity. I.e. the relevant financial statements, intraday stock data for all 
# months or an economy overview, reporting on all commodty and macro economic 
# indicators in the last 20 years.


# Check for required arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 TICKER"
    exit 1
fi

ticker="$1"
output_file="/data/data.txt" # should feed this into curler

functions=("INCOME_STATEMENT" "BALANCE_SHEET" "CASH_FLOW" "OVERVIEW")

# Loop through the functions and call curler.sh with a 5-second delay
for func in "${functions[@]}"; do
    echo "Calling curler.sh with function: $func for ticker: $ticker"
    ./curler.sh "$func" "$ticker" # "$output_file"
                                        # need to modify better curler to save it to an output file
    sleep 5
done

echo "All functions called for ticker: $ticker"
