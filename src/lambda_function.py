import conf
import numpy

def lambda_handler(event, content):
    config = conf.get_conf()
    print( numpy.arange(15).reshape(3, 5))
    return 'Success'
