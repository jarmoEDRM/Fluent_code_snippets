# Fluent_code_snippets
 Python, scheme and TUI snippets for working with ANSYS Fluent

## Current snippets:
    Python: 
        *srp_to_csv.py - Combine all target folder .srp files into one CSV. First column "id" corresponds to location. Second column is value and labeled by .srp filename without suffix 
    Scheme:
        *(csv_script_timer taskname dt_end dt_start) - Add fluent scheme timer.  Function csv_scipt_timer measures time of a task in hh,mm,ss. Define starting time and ending time of a task and run the function as instructed in the file.