#!/usr/bin/env nextflow

process BGZIP {
    label 'process_single'
    container 'ghcr.io/bf528/samtools:latest'
    publishDir params.outdir

    input:
    

    output:
    

    shell:
    """

    """

    stub:
    """
    touch fa.bgz
    """
}