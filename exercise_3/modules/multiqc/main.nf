#!/usr/bin/bash nextflow

process MULTIQC {
    
    container 'ghcr.io/bf528/multiqc:latest'
    publishDir params.outdir, mode: "copy", pattern: "*.html"

    // MULTIQC is smart in that if you provide a directory with the
    // FASTQC.zip files it will recognize it automatically and produce
    // the multiqc report
    input:
    path("*")

    // This is similar to FASTQC in that it produces a .html file
    output:
    path("*.html")

    script:
    """
    multiqc .
    """

}