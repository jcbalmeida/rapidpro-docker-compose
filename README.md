# rapidpro-docker-compose

## Running step-by-step
1. Clone recursively this repo:
    - > $ git clone --recursive git@github.com:jcbalmeida/rapidpro-docker-compose.git
    - > $ cd rapidpro-docker-compose
2. (Optional) If already cloned without the `--recursive` flag, can be updated with:
    - > $ git submodule update --init --recursive
3. Copy `setting.py.dev`
    - > $ cp src/rapidpro/temba/settings.py.dev src/rapidpro/temba/settings.py
4. Install NPM Modules
    - > $ cd src/rapidpro
    - > $ npm install 
5. Update connections from local to Docker config, in file: `src/rapidpro/temba/settings_common.py`
    1. Redis:
        - Update the constant `REDIS_HOST` value to _"redis"_
        - `REDIS_HOST = "redis"`
    2. PostgreSQL:
        - Update the `_default_database_config` value, updating the key `host` from _"localhost"_ to _"db"_
        -   ```
                _default_database_config = {
                    # [...]
                    "HOST": "db",
                    # [...]
                }
            ```
