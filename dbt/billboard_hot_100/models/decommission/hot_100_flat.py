# DEPRECATED: This Python model has been replaced by an SQL model (hot_100_flat.sql).
# The functionality remains the same, but the SQL model is more efficient.

import pandas as pd
import re

def model(dbt, session):
    
    # Load the billboard dataset
    """
    Process the billboard and artist datasets to flatten and split artist information.

    This function loads data from two sources: 'billboard_hot_100' and 'artist_data'.
    It then processes the artist names by conditionally splitting them based on the 
    presence of '&' or 'Feat.' and checks against a known set of artist names. Artists 
    are split into separate rows, and whitespace is stripped from artist names.

    Args:
        dbt: The dbt object for interacting with the database.
        session: The database session object.

    Returns:
        pd.DataFrame: A pandas DataFrame with one row per artist per entry in the 
        'billboard_hot_100' dataset.
    """
    
    # Load tables from snowflake
    df_bb = dbt.source('my_snowflake_source', 'billboard_hot_100').to_pandas()
    df_artist = dbt.source('my_snowflake_source', 'artist_data').to_pandas()
    
    # Convert artist names to a set for faster membership testing
    artist_set = set(df_artist['ARTIST_NAME'].str.lower())
    
    # Define a function to conditionally split artists
    def conditional_split(artist):
        # Split artist by & or Feat.
        potential_artists = re.split(r' & | Feat\. ', artist)
        # Check if any split part is in artist_set
        if any(part.strip().lower() in artist_set for part in potential_artists):
            return potential_artists  # Return list if any part is recognized
        else:
            return [artist]  # Return original artist as a single-item list if no matches
    
    # Apply the conditional split function
    df_bb['ARTIST'] = df_bb['ARTIST'].apply(conditional_split)
    
    # Explode into new rows if multiple artists
    df_bb = df_bb.explode('ARTIST')
    
    # Stip whitespaces
    df_bb['ARTIST'] = df_bb['ARTIST'].str.strip()

    # Return the flattened DataFrame
    return df_bb
