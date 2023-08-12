#!/usr/bin/env bash

# this builds urls and calls them

### Usage:

# - call like this:
# ./alphavantage_query.sh --function TIME_SERIES_DAILY --symbol EWZ

base_url="https://www.alphavantage.co/query"

#load apikey
if [ -f .env ]; then
    source .env
fi

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --function)
            function="$2"
            shift;shift #better than shift 2
            ;;
        --symbol)
            symbol="$2"
            shift;shift
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

# Check if required arguments are provided
if [ -z "$function" ] || [ -z "$symbol" ]; then
    echo "Usage: $0 --function FUNCTION --symbol SYMBOL"
    exit 1
fi


# Build the query URL
query_url="$base_url?function=$function&symbol=$symbol&apikey=$API_KEY"


# Print the query URL
curl "$query_url"