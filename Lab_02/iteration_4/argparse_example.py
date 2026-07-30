#!/usr/bin/env python

import argparse

parser = argparse.ArgumentParser(description='Description of your script')
parser.add_argument('-i', dest='input', help='Description of input', required=True)
parser.add_argument('-o', dest='output', help='Description of output', required=True)
args = parser.parse_args()

print(f"This is the value provided after -i on the CLI: {args.input}")
print(f"This is the value provided after -o on the CLI: {args.output}")