import os

env = os.environ

config = {
    "database": {
        "provider": env.get("DATABASE_PROVIDER"),
        "host": env.get("DATABASE_HOST"),
        "port": env.get("DATABASE_PORT"),
        "password": env.get("DATABASE_PASSWORD"),
        "user": env.get("DATABASE_USER"),
        "database": env.get("DATABASE_DB"),
    }
}
