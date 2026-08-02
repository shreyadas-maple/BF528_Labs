#!/usr/bin/env python

import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", dest="input", required=True)
parser.add_argument("-t", "--transcript", dest="transcript", required=True)
parser.add_argument("-o", "--output", dest="output", required=True)

args = parser.parse_args()

import csv

coords = []
cols = ['chr', 'start', 'end', 'transcript', 'score', 'strand']
with open(args.input, 'rt') as csvfile:
    reader = csv.reader(csvfile, delimiter='\t')
    for line in reader:
        rec = dict(zip(cols, line))
        if args.transcript in rec['transcript']:
            coords.extend([int(rec['start']), int(rec['end'])])
            chr = rec['chr']

with open(args.output, 'wt') as w:
    w.write('{}:{}-{}'.format(chr, str(min(coords)), str(max(coords))))
