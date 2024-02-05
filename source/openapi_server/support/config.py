import os

PROCESSOR_DICT = {
    "time-series:area": [],
    "hovmoller": [],
    "time-average:yearly": []
}

SDAP_SERVER_URL_PREFIX = "http://127.0.0.1/timeSeriesSpark"
if os.environ.get("SDAP_SERVER_URL_PREFIX") is not None:
    SDAP_SERVER_URL_PREFIX = os.environ["SDAP_SERVER_URL_PREFIX"]
