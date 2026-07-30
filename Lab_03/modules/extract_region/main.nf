#!/usr/bin/env nextflow

process EXTRACT_REGION {
    label 'process_single'
    conda 'envs/biopython_env.yml'

    publishDir params.outdir, mode: "copy"

    input:
    tuple val(name), path(gff)

    output:
    tuple val(name), path("region_of_interest.txt")

    script:
    """
    extract_region.py -i $gff -o region_of_interest.txt
    """

    stub:
    """
    touch region_of_interest.txt
    """

}