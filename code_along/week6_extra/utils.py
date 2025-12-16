import pandas as pd
import duckdb


def query_database(
    query: str, db_path: str = "data/lecture_13_15.duckdb"
) -> pd.DataFrame:
    """conveniece funtion to open a duckdb database connection and query it"""
    with duckdb.connect(db_path) as conn:
        return conn.execute(query=query).df()