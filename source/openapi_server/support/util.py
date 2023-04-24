import connexion

#from openapi_server.models.archival_information_package     import ArchivalInformationPackage
#from openapi_server.models.archival_information_package_min import ArchivalInformationPackageMin

import logging

import json

import uuid

import os

LOGGER = logging.getLogger(__name__)


def get_processor_list_by_id(collectionId):
    LOGGER.debug("collection id: %s", collectionId)
    return ["TimeSeries", "Average"]


def get_time_series_by_collection_id(collectionId):
    LOGGER.debug("collection id: %s", collectionId)
    return [1.0, 2.0, -1.0]
