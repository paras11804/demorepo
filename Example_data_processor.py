# example_usage.py

from pyspark.sql import SparkSession
from data_processor import DataProcessor

# Create a Spark session
spark = SparkSession.builder \
    .appName("PySpark Example Usage") \
    .getOrCreate()

# Create an instance of DataProcessor
data_processor = DataProcessor(spark)

# Create a sample DataFrame
data = [("Alice", 30), ("Bob", 25), ("Catherine", 20)]
df = data_processor.create_dataframe(data)

# Show the DataFrame
print("Original DataFrame:")
df.show()

# Filter the DataFrame by age
filtered_df = data_processor.filter_by_age(df, 25)

# Show the filtered DataFrame
print("Filtered DataFrame (Age >= 25):")
filtered_df.show()

# Count the rows in the filtered DataFrame
row_count = data_processor.count_rows(filtered_df)
print(f"Number of rows in filtered DataFrame: {row_count}")

# Stop the Spark session
spark.stop()

