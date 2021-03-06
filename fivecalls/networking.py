"""
Provides a layer of indirection for web requests.
"""
import sys
import requests

from fivecalls.sim8xx_manager import SIM8XXManager


def http_get_json(url, params={}):
    phone = SIM8XXManager()
    data = None

    # if sys.platform == 'linux':
        # phone.ppp_up()

    try:
        response = requests.get(
                url=url,
                params=params,
        )
    except requests.exceptions.RequestException as e:
        print(f'HTTP Request failed: {e}')
        return False

    else:
        if response.ok:
            data = response.json()

    # finally:
        # if sys.platform == 'linux':
            # phone.ppp_down()

        return data
