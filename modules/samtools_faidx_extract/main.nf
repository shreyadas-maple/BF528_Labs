#!/usr/bin/env nextflow

process SAMTOOLS_FAIDX_EXTRACT {
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
    touch transcript.subset.fa
    """
}