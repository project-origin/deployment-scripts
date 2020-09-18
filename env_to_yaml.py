import os
import sys
import yaml

prefix = 'secret2_'
seperator= '_'

values={}

for env in os.environ:
    if env.startswith(prefix):

        name = env[len(prefix):]

        ref = values

        if len(name) > 0:
            lst = name.split(seperator)
            for level in lst[:-1]:
                if level not in ref:
                    ref[level] = {}
                ref = ref[level]
            
            ref[lst[-1]] = os.environ[env]

with open(sys.argv[1], 'w') as file:
    documents = yaml.dump(values, file)
