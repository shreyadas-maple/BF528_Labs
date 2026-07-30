#!/usr/bin/bash nextflow

process FASTQC {

    container 'ghcr.io/bf528/fastqc:latest'
    publishDir params.outdir, mode: "copy", pattern: '*.html'

    input:
    tuple val(sample), path(fastq)
    
    output:
    path("*.html")
    path('*.zip'), emit: zip

    script:
    """
    fastqc $fastq
    """

}