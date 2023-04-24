import connexion
import six

from openapi_server.models.inline_response400 import InlineResponse400  # noqa: E501
#from openapi_server import util

from openapi_server.support import util


def get_processor_list_by_id(collection_id):  # noqa: E501
    """Get processor list by collection id

    Get processor list by collection id # noqa: E501

    :param collection_id: id of a collection
    :type collection_id: str

    :rtype: List[str]
    """
    #return 'do some magic!'
    return util.get_processor_list_by_id(collection_id)


def get_time_series_by_collection_id(collection_id):  # noqa: E501
    """Get time series by collection id

    Get time series by collection id # noqa: E501

    :param collection_id: id of a collection
    :type collection_id: str

    :rtype: List[float]
    """
    #return 'do some magic!'
    return util.get_time_series_by_collection_id(collection_id)
