# test_data_processor.py

import pytest
from data_processor import DataProcessor
from pyspark.sql import SparkSession

@pytest.fixture(scope="module")
def spark():
    spark = SparkSession.builder \
        .appName("PySpark Test") \
        .getOrCreate()
    yield spark
    spark.stop()

@pytest.fixture
def data_processor(spark):
    return DataProcessor(spark)

def test_create_dataframe(data_processor):
    data = [("Alice", 30), ("Bob", 25), ("Catherine", 20)]
    df = data_processor.create_dataframe(data)
    
    assert df.count() == 3
    assert df.columns == ["Name", "Age"]

def test_filter_by_age(data_processor):
    data = [("Alice", 30), ("Bob", 25), ("Catherine", 20)]
    df = data_processor.create_dataframe(data)
    filtered_df = data_processor.filter_by_age(df, 25)
    
    assert filtered_df.count() == 2
    assert filtered_df.filter(filtered_df.Name == "Catherine").count() == 0

def test_count_rows(data_processor):
    data = [("Alice", 30), ("Bob", 25), ("Catherine", 20)]
    df = data_processor.create_dataframe(data)
    
    
    assert data_processor.count_rows(df) == 3

