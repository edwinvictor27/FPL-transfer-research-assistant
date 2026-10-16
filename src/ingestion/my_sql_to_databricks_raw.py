import io
import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, inspect
from databricks.sdk import WorkspaceClient
from databricks.sdk.service.workspace import ImportFormat

# Load local credentials
load_dotenv(override=True)

# Databricks configuration
host = os.getenv("DATABRICKS_HOST", "").strip().rstrip("/")
token = os.getenv("DATABRICKS_TOKEN", "").strip()

if not host or not token:
    raise ValueError("Missing Databricks credentials in .env")

client = WorkspaceClient(host=host, token=token)

# Destination folder in Databricks Workspace
raw_folder = (
    "/Workspace/Users/edwinvictor73@gmail.com/"
    "FPL-transfer-research-assistant/src/Raw_Data"
)

# Local MySQL connection
mysql_url = "mysql+pymysql://root:@localhost/fpl_database"
engine = create_engine(mysql_url)

try:
    # Verify that the destination folder exists and is accessible
    folder = client.workspace.get_status(path=raw_folder)
    print("Databricks destination:", folder.path)

    inspector = inspect(engine)
    table_names = inspector.get_table_names()

    print(f"Found {len(table_names)} MySQL tables.")

    for table_name in table_names:
        try:
            # Read one table from MySQL
            df = pd.read_sql_table(table_name, con=engine)

            # Convert to CSV in memory
            csv_buffer = io.BytesIO()
            df.to_csv(
                csv_buffer,
                index=False,
                encoding="utf-8"
            )
            csv_buffer.seek(0)

            # Upload CSV into the Databricks Workspace folder
            destination = f"{raw_folder}/{table_name}.csv"
            
            csv_buffer.seek(0)
            client.workspace.upload(
                path=destination,
                content=csv_buffer,
                format=ImportFormat.RAW,
                overwrite=True
            )


            print(
                f"SUCCESS: {table_name} -> "
                f"{destination} ({len(df)} rows)"
            )

        except Exception as exc:
            print(
                f"FAILED: {table_name}: "
                f"{type(exc).__name__}: {exc}"
            )

finally:
    engine.dispose() 
