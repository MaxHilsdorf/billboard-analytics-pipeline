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


# This part is user provided model code
# you will need to copy the next section to run the code
# COMMAND ----------
# this part is dbt logic for get ref work, do not modify

def ref(*args, **kwargs):
    refs = {}
    key = '.'.join(args)
    version = kwargs.get("v") or kwargs.get("version")
    if version:
        key += f".v{version}"
    dbt_load_df_function = kwargs.get("dbt_load_df_function")
    return dbt_load_df_function(refs[key])


def source(*args, dbt_load_df_function):
    sources = {"my_snowflake_source.artist_data": "BB_DATABASE.BB_SCHEMA.artist_data", "my_snowflake_source.billboard_hot_100": "BB_DATABASE.BB_SCHEMA.billboard_hot_100"}
    key = '.'.join(args)
    return dbt_load_df_function(sources[key])


config_dict = {}


class config:
    def __init__(self, *args, **kwargs):
        pass

    @staticmethod
    def get(key, default=None):
        return config_dict.get(key, default)

class this:
    """dbt.this() or dbt.this.identifier"""
    database = "BB_DATABASE"
    schema = "BB_SCHEMA"
    identifier = "hot_100_flat_depr"
    
    def __repr__(self):
        return 'BB_DATABASE.BB_SCHEMA.hot_100_flat_depr'


class dbtObj:
    def __init__(self, load_df_function) -> None:
        self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
        self.ref = lambda *args, **kwargs: ref(*args, **kwargs, dbt_load_df_function=load_df_function)
        self.config = config
        self.this = this()
        self.is_incremental = False

# COMMAND ----------

# To run this in snowsight, you need to select entry point to be main
# And you may have to modify the return type to text to get the result back
# def main(session):
#     dbt = dbtObj(session.table)
#     df = model(dbt, session)
#     return df.collect()

# to run this in local notebook, you need to create a session following examples https://github.com/Snowflake-Labs/sfguide-getting-started-snowpark-python
# then you can do the following to run model
# dbt = dbtObj(session.table)
# df = model(dbt, session)

