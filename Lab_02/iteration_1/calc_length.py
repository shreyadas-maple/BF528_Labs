#!/usr/bin/env python

import gzip

# This is only specific to the genome that we load only
# Modularity would be really good for a program liek this
with gzip.open('/projectnb/bf528/students/dshreya/lab02-workflow-basics-shreyadas-maple/GCF_000005845.2_ASM584v2_genomic.fna.gz', 'rt') as f:
    sequence = ''.join(line.strip() for line in f if not line.startswith('>'))

# This is not saving the length of the sequence -> it would be better if there was an output file to save
# the value
print(len(sequence))