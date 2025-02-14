from datetime import datetime 
import json
import csv 
import sys

def Users_ETL(input_file: str, output_file: str) -> None:
    """
    Extracts Traffic data from the users.jsonl file(s) and appends the data to the Traffic table.
    This function will always assume that the input file is valid JSON.

    Function Process:
        - Opens input JSONL file for reading. Example: `../2b-Correction-Data/users.jsonl`
        - Extracts target data from each line from the input file
        - Transforms the target data for processing
        
    This function does not return anything.  
    """

    # Open JSONL Input File
    infile = open(input_file, "r", encoding="utf-8")
    
    # Open CSV Output File
    with open(output_file, 'w', newline='') as outfile:
        writer = csv.writer(outfile, delimiter=';')

        # Process JSONL File Line by Line
        for line in infile:
            
            # Extract Desired Data                        
            line_json = json.loads(line)

            user_id = line_json.get("_id", {}).get("$oid", "")
            active = line_json.get("active", "")
            create_dt = line_json.get("createdDate", {}).get("$date", "")
            login_ts = line_json.get("lastLogin", {}).get("$date", "")
            user_role = line_json.get("role", "")
            signup_src = line_json.get("signUpSource", "")
            user_state = line_json.get("state", "")

            # Transform Target Data
            try:
                create_dt_str = str(datetime.utcfromtimestamp(create_dt / 1000))
            except: 
                create_dt_str = ""
                
            try:
                login_ts_str = str(datetime.utcfromtimestamp(login_ts / 1000))                
            except:
                login_ts_str = ""

            data = [user_id, 
                    active, 
                    create_dt_str, 
                    login_ts_str, 
                    user_role, 
                    signup_src, 
                    user_state
                   ]

            # print(data)

            # Load Transformed Data
            writer.writerow(data) 

    infile.close() 
    outfile.close()  

    print("Users ETL Complete")
    return


if __name__ == "__main__":

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    Users_ETL(input_file, output_file)