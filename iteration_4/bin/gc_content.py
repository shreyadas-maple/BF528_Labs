#!/usr/bin/env python

from Bio import SeqIO
from Bio.SeqUtils import gc_fraction
import gzip

import argparse


parser = argparse.ArgumentParser(description='Calculate the GC Content of a sequence')
parser.add_argument('-i', dest='input', help='The Fasta file to analyze', required=True)
parser.add_argument('-o', dest='output', help='Output of the GC content python script', required=True)
args = parser.parse_args()

print(f"This is the value provided after -i on the CLI: {args.input}")
print(f"This is the value provided after -o on the CLI: {args.output}")

with gzip.open(args.input, 'rt') as f:
    record = SeqIO.read(f, 'fasta')

with open(args.output, 'wt') as w:
    w.write(f"{gc_fraction(record.seq)}")