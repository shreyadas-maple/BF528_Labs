#!/usr/bin/env nextflow

process TRIM {

    container 'ghcr.io/bf528/trimmomatic:latest'
    publishDir params.outdir, mode: 'copy'
    
    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*R*P.fastq.gz"), emit: trimmed_reads
    tuple val(sample_id), path("*.log"), emit: log

    shell:
    """
    trimmomatic PE \\
    ${reads[0]} ${reads[1]} \\
    ${sample_id}_R1P.fastq.gz ${sample_id}_R1U.fastq.gz ${sample_id}_R2P.fastq.gz ${sample_id}_R2U.fastq.gz \\
    ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 2>${sample_id}.trim_out.log
    """

    stub:
    """
    touch ${sample_id}_R1P.fastq.gz
    touch ${sample_id}_R2P.fastq.gz
    touch ${sample_id}.trim_out.log
    """
}
