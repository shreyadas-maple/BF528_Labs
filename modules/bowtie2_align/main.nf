#!/usr/bin/env nextflow

process BOWTIE2_ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/bowtie2:latest'

    input:
    tuple val(sample), path(reads)
    path bt2
    val name

    output:
    tuple val(sample), path('*bam'), emit: bam

    script:
    """
    bowtie2 -p 8 -x $bt2/$name -1 ${reads[0]} -2 ${reads[1]} | samtools view -bS - > ${sample}.bam
    """

    stub:
    """
    touch ${sample}.bam
    """
}