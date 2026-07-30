#!/usr/bin/env nextflow

process NCBI_DATASETS_CLI {
    label 'process_single'
    conda 'envs/ncbidatasets_env.yml'

    input:
    tuple val(name), val(assembly)

    output:
    // dataset/**/*.fna tells nf to look through the dataset directory
    // then look through the directories for a file that ends in .fna
    tuple val(name), path("dataset/**/*.fna")

    script:
    """
    datasets download genome accession $assembly --include genome
    unzip ncbi_dataset.zip -d dataset
    """
    
    stub:
    """
    mkdir -p dataset/stub/
    touch dataset/stub/stub.fna
    """

}
