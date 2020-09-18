import os
import sys
import yaml
import json

PREFIX = 'HELMVALUES__'
SEPERATOR = '__'
UPPERCASE = '_'

values={}

def upper_case(name):
    
    for i in [m.start() for m in re.finditer(UPPERCASE, name)]:
        name = name[:i+1] + name[i+1].upper() + name[i+2:]
    name = name.replace(UPPERCASE, '')

    return name


for env in os.environ:
    if env.startswith(PREFIX):

        name = env[len(PREFIX):].lower()

        ref = values

        if len(name) > 0:
            lst = name.split(SEPERATOR)
            for level in lst[:-1]:
                key = upper_case(level)
                if key not in ref:
                    ref[key] = {}
                ref = ref[key]
            
            key = upper_case(lst[-1])
            ref[key] = os.environ[env]

with open(sys.argv[1], 'w') as file:
    documents = yaml.dump(values, file, default_flow_style=False)
