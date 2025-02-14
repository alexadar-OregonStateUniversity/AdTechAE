#!/bin/bash

ORIGINATION="../1b-Collection-Data"
DESTINATION="../1b-Collection-Data"

# Download & Extract 
for url in \
  "https://fetch-hiring.s3.amazonaws.com/analytics-engineer/ineeddata-data-modeling/receipts.json.gz" \
  "https://fetch-hiring.s3.amazonaws.com/analytics-engineer/ineeddata-data-modeling/users.json.gz" \
  "https://fetch-hiring.s3.amazonaws.com/analytics-engineer/ineeddata-data-modeling/brands.json.gz"; do

  file="$DESTINATION/$(basename "$url")"

  # Downloading Files
  echo "Downloading $file"
  curl -L -o "$file" "$url"

  # Extracting Files
  echo "Extracting $file"
  gunzip -f "$file"
  
done

echo "Collect Stage Complete"
