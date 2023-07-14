#!/usr/bin/env python3

import sys

import logging

import connexion

from openapi_server import encoder


def main():
    logLevel = logging.DEBUG
    #logLevel = logging.INFO
    logging.basicConfig(stream=sys.stdout, level=logLevel)

    app = connexion.App(__name__, specification_dir='./openapi/')
    app.app.json_encoder = encoder.JSONEncoder
    app.add_api('openapi.yaml',
                arguments={'title': 'Unity DAPA Process Mapper'},
                pythonic_params=True)
    app.run(port=8080)


if __name__ == '__main__':
    main()
