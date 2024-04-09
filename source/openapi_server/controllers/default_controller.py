import connexion
import six

from openapi_server.models.inline_response400 import InlineResponse400  # noqa: E501
#from openapi_server import util
from openapi_server.support import util


def get_processes_for_collection_id(collection_id):  # noqa: E501
    """List processes applicable to a collection specified by collection id

    Get processes for collection id # noqa: E501

    :param collection_id: id of a collection
    :type collection_id: str

    :rtype: List[str]
    """
    return util.get_processes_for_collection_id(collection_id)


def get_time_series_for_collection_id(collection_id, bbox, datetime):  # noqa: E501
    """Get time series by spatial and temporal constraints for a collection specified by collection id

    Get time series for collection id # noqa: E501

    :param collection_id: id of a collection
    :type collection_id: str
    :param bbox: bounding box
    :type bbox: str
    :param datetime: start and end time
    :type datetime: str

    :rtype: List[float]
    """
    return util.get_time_series_for_collection_id(collection_id, bbox, datetime)
