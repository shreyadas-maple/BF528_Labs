#!/usr/bin/bash nextflow

process FASTQC {

    container 'ghcr.io/bf528/fastqc:latest'
    publishDir params.outdir, mode: "copy"

    input:
    tuple val(sample), path(reads)
    output:
    path("*.html")

    script:
    """
    fastqc $reads[0] $reads[1]
    """

}