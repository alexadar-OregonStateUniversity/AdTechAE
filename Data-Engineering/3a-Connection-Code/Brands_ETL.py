import json
import csv 
import sys

def Brands_ETL(input_file: str, output_file: str) -> None:
    """
    Extracts Brands data from the users.jsonl file(s) and appends the data to the Brands table.
    This function will always assume that the input file is valid JSON.

    Function Process:
        - Opens input JSONL file for reading. Example: `../2b-Correction-Data/brands.jsonl`
        - Extracts target data from each line from the input file
        - Transforms the target data for processing
        
    This function does not return anything.  
    """

    # Open JSONL Input File
    infile = open(input_file, "r", encoding="utf-8")
    
    # Open CSV Output File
    with open(output_file, 'w', newline='', encoding="utf-8") as outfile:
        writer = csv.writer(outfile, delimiter=';')

        # Process JSONL File Line by Line
        for line in infile:
            
            # Extract Desired Data                        
            line_json = json.loads(line)

            user_id = line_json.get("_id", {}).get("$oid", "")            
            barcode = line_json.get("barcode", "")
            brand_code = line_json.get("brandCode", "")
            category = line_json.get("category", "")
            category_code = line_json.get("categoryCode", "")
            cpg_code = line_json["cpg"]["$id"].get("$oid", "")
            cpg_name = line_json["cpg"].get("$ref", "")
            top_brand = line_json.get("topBrand", "")
            brand_name = line_json.get("name", "")

            # Transform Target Data
            data = [user_id, 
                    barcode, 
                    brand_code, 
                    category, 
                    category_code, 
                    cpg_code, 
                    cpg_name,
                    top_brand,
                    brand_name
                   ]

            # print(data)

            # Load Transformed Data
            writer.writerow(data) 

    infile.close() 
    outfile.close()  

    print("Brands ETL Complete")
    return

if __name__ == "__main__":

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    Brands_ETL(input_file, output_file)