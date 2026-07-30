#!/usr/bin/env nextflow

process NCBI_DATASETS_CLI {
    container 'ghcr.io/bf528/ncbi_datasets_cli:latest'

    input:
    tuple val(name), val(assembly)

    output:
    tuple val(name), path('dataset/**/*.fna')

    script:
    """
    datasets download genome accession $assembly --include genome
    unzip ncbi_dataset.zip -d dataset/
    """

    stub:
    """
    mkdir -p dataset/stub/
    touch dataset/stub/stub.fna
    """

}
