#!/usr/bin/env nextflow

process STAR_BUILD {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    path genome
    path gtf

    output:
    path "star", emit: index

    script:
    """
    mkdir star
    STAR --runThreadN $task.cpus --runMode genomeGenerate --genomeDir star --genomeFastaFiles $genome --sjdbGTFfile $gtf --genomeSAindexNbases 11
    """

    stub:
    """
    mkdir star
    """
}