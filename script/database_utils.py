from pathlib import Path
from sqlalchemy import create_engine
import pandas as pd

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATABASE_PATH = PROJECT_ROOT / "data" / "database" / "superstore.db"

def get_engine():
    """Return a connection engine for the local SQLite database."""
    return create_engine(f"sqlite:///{DATABASE_PATH}")

def run_query(query):
    """Run a SQL query and return the result as a Pandas DataFrame."""
    engine = get_engine()
    return pd.read_sql_query(query, engine)