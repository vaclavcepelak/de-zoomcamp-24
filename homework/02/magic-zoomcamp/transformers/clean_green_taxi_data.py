import re


if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


def camel_to_snake(name):
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', name).lower()


@transformer
def transform(data, *args, **kwargs):
    condition = (
        (data['passenger_count'] > 0) 
        & (data['trip_distance'] > 0)
    )
    data = data.loc[condition, :].drop(columns=['month'])

    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    data.columns = [camel_to_snake(col) for col in data.columns]
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert 'vendor_id' in output.columns, 'vendor_id is missing'
    assert output.loc[output['passenger_count'] == 0].shape[0] == 0, 'contains records with 0 passenger_count'
    assert output.loc[output['trip_distance'] == 0].shape[0] == 0, 'contains records with 0 trip_distance'
