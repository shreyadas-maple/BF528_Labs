#!/usr/bin/env nextflow

process SAMTOOLS_FAIDX {
    label 'process_single'
    container 'ghcr.io/bf528/samtools:latest'

    input:


    output:
    

    shell:
    """

    """

    stub:
    """
    touch stub.bgz.fai
    """
}