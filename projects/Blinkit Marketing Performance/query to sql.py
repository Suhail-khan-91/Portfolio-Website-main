import pandas as pd
from sqlalchemy import create_engine

username = 'your_username'
password = 'your_password'
host = 'localhost'  
port = 3306
database = 'blinkit'

engine = create_engine(f'mysql+pymysql://{username}:{password}@{host}:{port}/{database}')

query = """
SELECT *, 
ROUND((revenue_generated / spend), 2) AS ROAS
FROM marketing_performance ORDER BY date;
"""

df = pd.read_sql(query, engine)

df.to_csv("Blinkit_Marketing_Performance.csv", index=False)

print("Exported successfully to Blinkit_Marketing_Performance.csv")
