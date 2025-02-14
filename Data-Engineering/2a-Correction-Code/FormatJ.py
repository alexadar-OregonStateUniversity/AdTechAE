import json
import sys

def JSON_formatter(input_file: str, output_file: str) -> None:
    """
    Reads a JSONL (JSON Lines) file, removes invalid JSON entries, and saves the cleaned data.

    Function Process:
        - Opens input JSONL file for reading Example: `file.jsonl` or `../2b-Correction-Data/users.jsonl`
        - Opens output JSONL file for writing. Example: `file_v2.jsonl` or `../2b-Correction-Data/users_v2.jsonl`
        - Reads each line while checking if JSON is valid.
        - Writes valid JSON objects back to the output file.
        - Skips lines that are invalid JSON.

    The function does not return anything but saves the cleaned JSON data to `users_v2.jsonl`.
    The function is a simple and blunt solution for addressing invalid JSON.  

    Demonstration:

        python FormatJ.py ../2b-Correction-Data/users.jsonl ../2b-Correction-Data/users_v2.jsonl

    """

    # Open JSONL Input & Output Files
    infile = open(input_file, "r", encoding="utf-8")
    outfile = open(output_file, "w", encoding="utf-8")

    # JSONL Processing
    for line in infile:
        try:
            data = json.loads(line.strip())  # Validate JSON
            outfile.write(json.dumps(data) + "\n")  # Vaild JSON
        except json.JSONDecodeError:
            continue  # Skip Invalid JSON

    # Clean Up Files
    infile.close()
    outfile.close()

    print("JSON Formatter Completed")

if __name__ == "__main__":

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    JSON_formatter(input_file, output_file)