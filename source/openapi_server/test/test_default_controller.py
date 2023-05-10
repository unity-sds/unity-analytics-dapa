# coding: utf-8

from __future__ import absolute_import
import unittest

from flask import json
from six import BytesIO

from openapi_server.models.inline_response400 import InlineResponse400  # noqa: E501
from openapi_server.test import BaseTestCase


class TestDefaultController(BaseTestCase):
    """DefaultController integration test stubs"""

    def test_get_processes_for_collection_id(self):
        """Test case for get_processes_for_collection_id

        List processes applicable to a collection specified by collection id
        """
        headers = { 
            'Accept': 'application/json',
        }
        response = self.client.open(
            '/unity/v0/collections/{collection_id}/processes'.format(collection_id='collection_id_example'),
            method='GET',
            headers=headers)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_time_series_for_collection_id(self):
        """Test case for get_time_series_for_collection_id

        Get time series by spatial and temporal constraints for a collection specified by collection id
        """
        query_string = [('bbox', 'bbox_example'),
                        ('timespan', 'timespan_example')]
        headers = { 
            'Accept': 'application/json',
        }
        response = self.client.open(
            '/unity/v0/collections/{collection_id}/processes/time-series:averaged-over-area'.format(collection_id='collection_id_example'),
            method='GET',
            headers=headers,
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    unittest.main()
