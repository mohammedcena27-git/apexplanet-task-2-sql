# apexplanet-task-2-sql
# ApexPlanet Task 2: SQL for Data Extraction

## Objective
Use SQL and SQLite to extract business insights from the cleaned Superstore Sales dataset.

## Tools Used
- Python
- Pandas
- SQLite
- SQLAlchemy
- Jupyter Notebook
- VS Code

## Dataset
The cleaned Superstore Sales dataset from Task 1.

## Database Structure
- `customers`: customer ID, name, and segment
- `sales_orders`: sales order, product, date, sales, profit, discount, and regional data
- `monthly_sales_summary`: reusable SQL view for monthly performance

## SQL Skills Demonstrated
- SELECT, WHERE, ORDER BY, LIMIT
- GROUP BY and HAVING
- JOIN
- CTE
- Window function using ROW_NUMBER()
- SQL view creation
- Python and SQLite integration using SQLAlchemy

## Files
- `notebooks/task_2_sql_analysis.ipynb`: Python and SQL analysis
- `sql/task_2_queries.sql`: all SQL queries
- `scripts/database_utils.py`: reusable database connection utility
- `data/database/superstore.db`: SQLite database
- `data/processed/superstore_cleaned.csv`: cleaned source dataset

## How to Run
1. Clone the repository.
2. Create and activate a Python virtual environment.
3. Run `pip install -r requirements.txt`.
4. Open the notebook in VS Code.
5. Select the `.venv` kernel.
6. Run the cells from top to bottom.