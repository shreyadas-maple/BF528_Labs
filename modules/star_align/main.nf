#!/usr/bin/env nextflow

process STAR_ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir, pattern: "*.Log.final.out"

    input:
    tuple val(sample), path(reads)
    path(index)

    output:
    tuple val(sample), path("${sample}.Aligned.out.bam"), emit: bam
    tuple val(sample), path("${sample}.Log.final.out"), emit: log

    script:
    """
    STAR --runThreadN $task.cpus --genomeDir $index --readFilesIn $reads --readFilesCommand zcat --outFileNamePrefix ${sample}. --outSAMtype BAM Unsorted
    """

    stub:
    """
    touch ${sample}.Aligned.out.bam
    touch ${sample}.Log.final.out
    """
}