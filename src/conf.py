import os

envs = {'default', 'dev', 'stage', 'prod'}
for _ in envs: exec("{}='{}'".format(_, _))

config_map = {
    'db_endpoint':{
        prod:    'prod-mysql',
        stage:   'stage-mysql',
        dev:     'dev-mysql',
        default: 'local-mysql'
    },
    's3_bucket':{
        default: 'test_bucket'
    },
    's3_key_prefix':{
        default: 'prefix_string'
    }
}

def get_conf(environment_variable='ENVIRONMENT', assign_environment=None):
    if assign_environment == None:
        env = os.getenv(environment_variable, default)
    else:
        if assign_environment in envs:
            env = assign_environment
        else:
            env = default
    
    config = {}
    print('Use config: {}'.format(env))

    for key in config_map.keys():
        if env in config_map[key].keys():
            config[key] = config_map[key][env]
        else: 
            config[key] = config_map[key][default]
    return config
