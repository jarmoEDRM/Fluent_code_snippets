import pandas as pd 
from pathlib import Path
import re
import os

def srp_to_csv(filename):
    """Convert srp file data to CSV format

    Parameters
    ----------
    filename : str or Path-like
        Path to .srp file

    Returns
    -------
    dataframe: pd.Dataframe()
        dataframe containing id and values. id corresponds to location, value header is file name without suffix
    """
    
    with open(filename,"r") as f:
        lines = f.readlines()

    # Remove newlines
    lines = [line[:-1] for line in lines]

    # Remove extra whitespaces and empty lines
    lines = [' '.join(line.split()) for line in lines if line != ""]
    

    # Get result type
    header_result_type = re.search('"(.+?)"', "\t".join(lines)).group(1)
    header_result_of = re.search('"\t(.+?)\t-', "\t".join(lines)).group(1)

    # Remove empty spaces
    header_result_of = ' '.join(header_result_of.split()) 
    data = re.search('-\t(.+?)\t-', "\t".join(lines)).group(1).split("\t")
    data_result_type = [x.split()[0] for x in data]
    data_result_of = [y.split()[1] for y in data]


    # Data value header is the name of the file without .srp
    # Data id is the name of the surface/cell-zone
    data_header = str(filename)[:-4]

    pandas_data_format = {
        "id": data_result_type, 
        data_header: data_result_of
        }
    dataframe = pd.DataFrame(data=pandas_data_format)
    
    return dataframe

def combine_dir_srp_to_one_csv(target_directory_path="."):
    """Get .srp files from a folder and combines them into one csv

    Parameters
    ----------
    target_directory_path : str, optional
        Path folder with .srp files, by default working directory
    """
    
    file_list = os.listdir(".")
    file_list = [name for name in file_list if ".srp" in name]

    if file_list == []:
        raise FileNotFoundError("No srp files where found in target directory")

    else:
        dataframes = [srp_to_csv(filename).set_index('id') for filename in file_list]
        merged = pd.concat(dataframes, axis=1)
        merged.to_csv("srp_combined.csv")


if __name__ =="__main__":
    combine_dir_srp_to_one_csv()

    
    
    

  
