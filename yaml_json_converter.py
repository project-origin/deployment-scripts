import sys
import yaml
import json

CONVERSION = sys.argv[1]
SOURCEFILE = sys.argv[2]
DESTINATIONFILE = sys.argv[3]

print(CONVERSION, SOURCEFILE, DESTINATIONFILE)

def represent_none(self, _):
    return self.represent_scalar('tag:yaml.org,2002:null', '')

yaml.add_representer(type(None), represent_none)

if CONVERSION == 'yaml_to_json':
    with open(SOURCEFILE, 'r') as file:
        data = yaml.load(file.read())

    with open(DESTINATIONFILE, 'w') as file:
        json.dump(data, file, indent=2)


elif  CONVERSION == 'json_to_yaml':
    with open(SOURCEFILE, 'r') as file:
        data = json.load(file)

    with open(DESTINATIONFILE, 'w') as file:
        file.write(yaml.dump(data, default_flow_style=False))

else:
    exit(1)
