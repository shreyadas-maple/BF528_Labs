#!/usr/bin/env nextflow

process EXTRACT_COORDS {
    label 'process_single'
    container 'ghcr.io/bf528/biopython:latest'
    
    input:


    output:


    shell:
    """

    """
    
    stub:
    """
    touch transcript.region.txt
    """
}