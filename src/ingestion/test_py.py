import os
from dotenv import load_dotenv
from databricks.sdk import WorkspaceClient

# Load the latest values from .env
load_dotenv(override=True)

host = os.getenv("DATABRICKS_HOST", "").strip().rstrip("/")
token = os.getenv("DATABRICKS_TOKEN", "").strip()

if not host or not token:
    raise ValueError("Missing Databricks credentials")

# Verify the host without revealing your token
print("Host:", repr(host))
print("Token loaded:", bool(token))

client = WorkspaceClient(
    host=host,
    token=token
)

try:
    user = client.current_user.me()
    print("Authentication successful!")
    print("User:", user.user_name)

except Exception as e:
    print("Error type:", type(e).__name__)
    print("Error details:", str(e))