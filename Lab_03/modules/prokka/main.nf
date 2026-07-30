#!/usr/bin/env nextflow

process PROKKA {
    label 'process_single'
    conda 'envs/prokka_env.yml'
    publishDir params.outdir, mode:'copy'

    input:
    tuple val(name), path(fna)

    output:
    tuple val(name), path("**/*.gff"), emit: gff

    shell:
    """
    prokka --outdir $name --prefix $name $fna
    """

    stub:
    """
    mkdir -p ${name}/
    touch ${name}/stub.gff
    """
}