# Boilerplate main file
````python
#!/usr/bin/env python3
import logging

logging.basicConfig(level=logging.DEBUG,
                    style='{',
                    format='{asctime} [{levelname}] {message} ({name}:{module})',
                    handlers=[logging.StreamHandler()])

logger = logging.getLogger(__name__)

# Argparse http://kitakitsune.org/argparse_builder/
````

# Dates
````python
from datetime import datetime
current_date_local_tz = datetime.now().astimezone()
print(current_date_local_tz.strftime('%Y-%m-%dT%H:%M:%S.%f%z'))  # 2024-04-12T12:59:45.310264+0200
print(current_date_local_tz.strftime('%Y-%m-%d'))  # 2024-04-12
current_date_no_tz = datetime.now()  # please don't use
print(current_date_no_tz.strftime('%Y-%m-%dT%H:%M:%S.%f%z')) # 2024-04-12T12:59:45.310337
````
# JSON
````python
import json
with open('path_to_file/person.json', 'r') as f:
  data = json.load(f)
person = '{"name": "Bob", "languages": ["English", "French"]}'
person_dict = json.loads(person)
````
# Logging
````python
import logging
logger = logging.getLogger(__name__)

# if main file, basicConfig if lazy,
# https://docs.python.org/3/library/logging.config.html#configuration-dictionary-schema
logging.config.dictConfig(LOGGING_CONFIG)

#  or dictconfig
logging.basicConfig(level=logging.DEBUG,
                    style='{'
                    format='{asctime} [{levelname}] {message} ({name}:{module})',
                    handlers=[
                              # logging.FileHandler(f"{os.path.basename(__file__)}.log"),
                              logging.StreamHandler()
                              ])

logger.debug(f"Debug from {__name__})
````

