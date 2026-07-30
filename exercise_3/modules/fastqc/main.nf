#!/usr/bin/bash nextflow

process FASTQC {

    container 'ghcr.io/bf528/fastqc:latest'
    publishDir params.outdir, mode: "copy", pattern: "*.html"

    input:
    tuple val(sample), path(reads)

    output:
    path("*.zip"), emit: zip
    path("*.html")

    script:
    """
    fastqc $reads
    """

}