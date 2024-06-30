# data_processor.py

from pyspark.sql import SparkSession
from pyspark.sql.functions import col

class DataProcessor:
    def __init__(self, spark):
        self.spark = spark

    # Create dataframe
    def create_dataframe(self, data):
        return self.spark.createDataFrame(data, ["Name", "Age"])

    # Comment 2 for ymltest
    def filter_by_age(self, df, min_age):
        return df.filter(col("Age") >= min_age)

    # Adding Comment-3
    def count_rows(self, df):
        return df.count()
