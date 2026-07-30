#!/usr/bin/env nextflow

process JELLYFISH {
    container 'ghcr.io/bf528/jellyfish-kmer:latest'
    label 'process_medium'
    publishDir params.outdir, pattern: '*.stats'

    input:
    tuple val(name), path(assembly), val(nmer)

    output:
    tuple val(name), path('*.stats')

    script:
    """
    jellyfish count -m $nmer -s 2M -t 4 $assembly -o kmer_cts.jf
    jellyfish stats kmer_cts.jf > ${name}_${nmer}mer_cts.stats
    """

    stub:
    """
    touch ${name}_${nmer}mer_cts.stats
    """

}
