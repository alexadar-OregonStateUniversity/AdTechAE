#!/bin/bash

# Users
jq -r 'paths | join(".")' ../2b-Correction-Data/users.jsonl | sort -u > ../2b-Correction-Data/users_paths.txt

# Brands
jq -r 'paths | join(".")' ../2b-Correction-Data/brands.jsonl | sort -u > ../2b-Correction-Data/brands_paths.txt

# Receipts
jq -r 'paths | join(".")' ../2b-Correction-Data/receipts.jsonl | sort -u > ../2b-Correction-Data/receipts_paths.txt

# -------
# Focused 
# -------

jq -r 'paths | map(tostring) | join(".")' ../2b-Correction-Data/receipts.jsonl | sed -E 's/\.[0-9]+/./g' | sort -u > ../2b-Correction-Data/receipts_paths.txt

