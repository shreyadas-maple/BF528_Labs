#!/usr/bin/env nextflow

process SAMTOOLS_FAIDX_SUBSET {
    label 'process_single'
    conda 'envs/samtools_env.yml'
    publishDir params.outdir, mode: 'copy'

    input:

    tuple val(name), path(fna), path(fai), path(region)

    output:
    tuple val(name), path("*region.subset.fna")

    shell:
    """
    samtools faidx $fna -r $region > ${name}_region.subset.fna
    """

    stub:
    """
    touch ${name}_region.subset.fna
    """
}