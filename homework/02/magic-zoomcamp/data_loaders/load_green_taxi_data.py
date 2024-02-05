import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

months_to_load = [
    '2020-10',
    '2020-11',
    '2020-12'
]

@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    url = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green'
    taxi_dtypes = {
        'VendorID': pd.Int64Dtype(),
        'passenger_count': pd.Int64Dtype(),
        'trip_distance': float,
        'RatecodeID': pd.Int64Dtype(),
        'store_and_fwd_flag': str,
        'PULocationID': pd.Int64Dtype(),
        'DOLocationID': pd.Int64Dtype(),
        'payment_type': pd.Int64Dtype(),
        'fare_amount': float,
        'extra': float,
        'mta_tax': float,
        'tip_amount': float,
        'tolls_amount': float,
        'improvement_surcharge': float,
        'total_amount': float,
        'congestion_surcharge': float 
    }

    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    lst_df = []

    for month in months_to_load:
        url_df = f'{url}/green_tripdata_{month}.csv.gz'
        print(url_df)
        df = pd.read_csv(
            url_df,
            sep=',',
            compression='gzip',
            dtype=taxi_dtypes,
            parse_dates=parse_dates
        )
        df['month'] = month
        lst_df.append(df)

    return pd.concat(lst_df)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    pickup_months = output['month'].drop_duplicates().sort_values().tolist()
    assert pickup_months == months_to_load, 'Not all months included'
