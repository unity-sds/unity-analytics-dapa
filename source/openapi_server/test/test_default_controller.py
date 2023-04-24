# coding: utf-8

from __future__ import absolute_import
import unittest

from flask import json
from six import BytesIO

from openapi_server.models.inline_response400 import InlineResponse400  # noqa: E501
from openapi_server.test import BaseTestCase


class TestDefaultController(BaseTestCase):
    """DefaultController integration test stubs"""

    def test_get_processor_list_by_id(self):
        """Test case for get_processor_list_by_id

        Get processor list by collection id
        """
        headers = { 
            'Accept': 'application/json',
        }
        response = self.client.open(
            '/process-mapper/v0/Collection/{collection_id}'.format(collection_id='collection_id_example'),
            method='GET',
            headers=headers)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_time_series_by_collection_id(self):
        """Test case for get_time_series_by_collection_id

        Get time series by collection id
        """
        headers = { 
            'Accept': 'application/json',
        }
        response = self.client.open(
            '/process-mapper/v0/Collection/{collection_id}/timeSeries'.format(collection_id='collection_id_example'),
            method='POST',
            headers=headers)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    unittest.main()
