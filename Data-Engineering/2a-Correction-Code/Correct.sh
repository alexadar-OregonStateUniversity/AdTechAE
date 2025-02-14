#!/bin/bash

ORIGINATION="../1b-Collection-Data"
DESTINATION="../2b-Correction-Data"

# Process JSON Files: Copy, Convert, Clean
for file in "$ORIGINATION"/*.json; do
    jsonl_file="$DESTINATION/$(basename "$file" .json).jsonl"
    temp_file="${jsonl_file%.*}_v2.jsonl"

    # Copy File Over From Collection
    echo "Copying $file --> $jsonl_file"
    cp "$file" "$jsonl_file"

    # Clean JSON File, Save As JSONL
    echo "Formatting $jsonl_file --> $temp_file"
    python3 FormatJ.py "$jsonl_file" "$temp_file"

    # Replace File Old w/ New
    mv "$temp_file" "$jsonl_file"

done

echo "Correct Stage Complete"
