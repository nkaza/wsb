#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  3 15:19:40 2022

@author: jjg
"""

# Libraries
import pandas as pd
import numpy as np


# Clean up columns
def clean_up_columns(df):
    """ 
    Remove table names from column headers and set to lower case.
    
    Args:
        df : data frame for transformation
        
    Output:
        df_clean : cleaned data frame
        
    """    
    # Remove column header issues
    df.columns = (df.columns.str.replace('.*\\.', '', regex = True))
    
    # set all names to lowercase
    df.columns = df.columns.str.lower()
        
    # remove column extras
    df = df.dropna(axis = 1, how = "all")
    
    return df


# Standardize date columns
def date_type(df, date_columns):
    """ 
    Clean up date columns using pandas datetime
    
    Args:
        df : data frame for transformation
        
    Output:
        df : cleaned data frame
        
    """
    # set date columns to date
    for x in date_columns:
        df[x] = df[x].apply(pd.to_datetime, format = "%d-%b-%y")
        df[x] = df[x].dt.normalize()    
        
    return df

# Trims all white space
def trim_whitespace(df: pd.DataFrame):
    
    df = df.copy()

    for col in df.select_dtypes(include=[object]):
        df[col] = df[col].str.strip()

    return df