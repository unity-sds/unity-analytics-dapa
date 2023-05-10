import connexion

#from openapi_server.models.archival_information_package     import ArchivalInformationPackage
#from openapi_server.models.archival_information_package_min import ArchivalInformationPackageMin

import logging

import json

import uuid

import os

LOGGER = logging.getLogger(__name__)

RES = {'data': [{'iso_time': '2018-01-01T09:00:00Z',
           'lats': [{'cnt': 27,
                     'latitude': 35.125,
                     'max': 23.985992431640625,
                     'mean': 20.459851300274885,
                     'min': 10.618988037109375,
                     'std': 3.1210128018288916},
                    {'cnt': 28,
                     'latitude': 35.375,
                     'max': 23.951995849609375,
                     'mean': 19.137821742466517,
                     'min': 7.498992919921875,
                     'std': 4.428031393356866},
                    {'cnt': 23,
                     'latitude': 35.625,
                     'max': 24.0780029296875,
                     'mean': 20.333522630774457,
                     'min': 11.97601318359375,
                     'std': 2.984152309372665}]}],
 'meta': {'bounds': {'east': -70.0,
                     'north': 42.0,
                     'south': 35.0,
                     'west': -77.0},
          'shortName': 'MUR25-JPL-L4-GLOB-v4.2_analysed_sst',
          'time': {'iso_start': '2018-01-01T00:00:00+0000',
                   'iso_stop': '2018-12-31T00:00:00+0000',
                   'start': 1514764800,
                   'stop': 1546214400}},
 'stats': {}}


def get_processes_for_collection_id(collectionId):
    LOGGER.debug("collection id: %s", collectionId)
    return ["time-series"]


def get_time_series_for_collection_id(collectionId, bbox, timespan):
    LOGGER.debug("collection id: %s", collectionId)
    return RES
