#!/usr/bin/env nextflow

process SAMTOOLS_FAIDX {
    label 'process_single'
    conda 'envs/samtools_env.yml'

    input:
    tuple val(name), path(fna)

    output:
    tuple val(name), path(fna), path("*.fai")

    shell:
    """
    samtools faidx $fna
    
    """

    stub:
    """
    touch stub.fai
    """ 
}
