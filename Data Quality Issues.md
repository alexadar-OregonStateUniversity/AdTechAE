#### Data Quality Process 

Data quality issues were identified and mitigated throughout the Data Engineering (DE), Analytics Engineering (AE), and Data Analytics (DA) phases, ensuring a clean, structured, and reliable dataset for analytics and reporting.  

- Data Engineering (DE): Raw JSON data was extracted and structured into staging tables (`stg_receipt_order`, `stg_receipt_items`, `stg_users`, `stg_brands`). Here, issues such as missing values, duplicate records, and foreign key violations were identified.  
- Analytics Engineering (AE): Data from DE was refined into stage, inter, core, and mart models, that enforce data integrity, a process that flushed out many issues in the data. 
- Data Analytics (DA): This phase focused on first developing and then leveraging the Mart data model. But it was also here that the cost of strict cleaning was the clearest.

More information can be found in each phase's respective directory.  

---

#### Dirty Data Detection 


```bash

# Invalid JSON text preceding JSON Lines 
head -5 "../1b-Collection-Data/users.json"
# Invalid JSON File Format Type (JSONL)
jq . users.json
# Deep Nesting Via Arrays In Receipts.jsonl 
sed -n 5p ../2b-Correction-Data/brands.jsonl | jq "."
# Even More Columns Present Than Thought
jq -r 'paths | join(".")' ../2b-Correction-Data/receipts.jsonl | sort -u
# Many Columns Seem To Overlap Information 
jq -r 'paths | map(tostring) | join(".")' ../2b-Correction-Data/receipts.jsonl | sed -E 's/\.[0-9]+/./g' | sort -u
# Enforcing Primary Keys is Challenging
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f Analytic-Engineering/1-Staging-Models/Explore.sql
# Documentation Is Missing For Important Data
wget -O - https://fetch-hiring.s3.amazonaws.com/analytics-engineer/ineeddata-data-modeling/data-modeling.html

```

---

1. JSON Formatting Issues  
   - Problem: Invalid JSON objects causing parsing failures.  
   - Solution: Used FormatJ.py to clean and convert to JSONL.  

2. JSON Nesting Complexity  
   - Problem: The JSON files, particularly the receipts dataset, contained deeply nested structures that obscured key transactional data crucial for Fetch's analytics. Essential details, such as itemized purchases, pricing, and metadata, were embedded within complex substructures, making direct extraction inefficient.  
   - Solution: Focused efforts on systematically parsing, flattening, and restructuring the data to surface the most valuable purchase details. Applied JSON normalization techniques to extract nested elements into a relational format, ensuring seamless integration with downstream processing and analytical models.  

3. Input Data Column Inconsistency  
   - Problem: There were several fields or attributes that had data that was not consistently available, but the fields are not consistently shown.  
   - Solution: Reviewed all available data and all attributes seen in the data to create a map of possible fields. This enabled easier coalescing.  

4. Incomplete Documentation  
   - Problem: Data dictionaries (fields and definitions) are invaluable tools in data analysis and many of the fields for the most valuable data are not in the documentation shared.  
   - Solution: Documentation and data dictionaries were created in the Analytic Engineering phase of the project for ease of use in the future.  

5. Missing Business Logic  
   - Problem: For much of the data there is ambiguity regarding what to do with values and fields like 'BRAND' brand code and 'Test Item'. This can make it difficult to ID the preferred solution.  

6. Several Missing or Null Values  
   - Problem: Key fields (brand_code, receipt_id, item_price_mod, user_id) contain many null values.  
   - Impact: Breaks foreign key relationships and analytics.  
   - Solution: Collecting more data from external sources, drawing from other-field inference.  

7. Duplicate Records  
   - Problem: Found in all tables, but especially in brands.  
   - Impact: Inflates metrics and can make it impossible to connect other datasets.  
   - Solution: In some cases, where possible, implementing deduplication.  

8. Truncated or Inconsistent Data  
   - Problem: Inconsistent casing, spacing, and truncation in brand names and category codes. category_code values contain leading or trailing whitespace.  

9. Foreign Key Violations  
   - Problem: brand_code, receipt_id, item_hash_id reference missing records.  
   - Impact: Foreign key constraint failures during inserts.  
   - Records not conforming to expected relationships.  

10. Logical Data Integrity Issues  
   - Problem: brand_code existing in receipt_items but missing in core_brands.  

11. Incorrectly Categorized Data  
   - Problem: Missing mappings for brand_code and category_code.  
   - rewards_status ambiguities (Finished vs. Accepted).  