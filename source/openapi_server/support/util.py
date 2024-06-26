import connexion

#from openapi_server.models.archival_information_package     import ArchivalInformationPackage
#from openapi_server.models.archival_information_package_min import ArchivalInformationPackageMin

import logging

import json

import uuid

import os

import requests

LOGGER = logging.getLogger(__name__)

from openapi_server.support.config import PROCESSOR_DICT, SDAP_SERVER_URL_PREFIX
from openapi_server.support.mockup import RES

def get_processes_for_collection_id(collectionId):
    LOGGER.debug("collection id: %s", collectionId)
    return list(PROCESSOR_DICT.keys())

# ref
# https://docs.ogc.org/per/20-025r1.html#_query_parameters_8
# https://docs.ogc.org/per/20-025r1.html#_parameters_11
from datetime import datetime as dt
def figure_out_start_end(datetimeString):
    startTime = None
    endTime = None
    if "/" not in datetimeString:
        startTime = datetimeString
        endTime = datetimeString
    else:
        startTime, endTime = datetimeString.split('/')
        if startTime == "..":
            startTime = "1970-01-01T00:00:00Z"
        if endTime == "..":
            endTime = dt.now().strftime('%Y-%m-%dT%H:%M:%SZ')
    return [startTime, endTime]

# ref: https://github.com/ceos-coverage/coverage-jupyter-examples/blob/main/coverage-sdap/coverage-sdap.ipynb
# https://coverage.ceos.org/nexus/longitudeTimeHofMoellerSpark?ds=MUR25-JPL-L4-GLOB-v4.2_analysed_sst&minLon=-77.0&minLat=35.0&maxLon=-70.0&maxLat=42.0&startTime=2018-01-01T00:00:00Z&endTime=2018-12-31T00:00:00Z
def get_time_series_for_collection_id(collectionId, bbox, datetime):
    LOGGER.debug("collection id: %s", collectionId)
    minLon, minLat, maxLon, maxLat = bbox.split(",")
    startTime, endTime = figure_out_start_end(datetime)
    LOGGER.debug("startTime: %s, endTime: %s", startTime, endTime)
    sdapUrl = "{}?ds={}&minLon={}&minLat={}&maxLon={}&maxLat={}&startTime={}&endTime={}".format(SDAP_SERVER_URL_PREFIX, collectionId, minLon, minLat, maxLon, maxLat, startTime, endTime)
    r = requests.get(sdapUrl)
    LOGGER.debug("sdap url: %s", sdapUrl)
    return json.loads(r.text)
