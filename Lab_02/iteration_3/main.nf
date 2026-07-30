#!/usr/bin/env nextflow

process DOWNLOAD {

    // We want the output to be a fasta file of the download 
    output:
    path("GCF_000005845.2_ASM584v2_genomic.fna.gz")

    // Run this script to download the file from the internet using
    // a URL
    script:
    """
    wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
    """

}

process GC_CONTENT {

    // This is creating the environment from the biopython yml file
    // This is telling nextflow which yml to use to build the conda environment
    conda 'envs/biopython_env.yml'

    // The input here is the parameter of GC_CONTENT process
    input:
    path(genome)

    // The output here is the text file that would contain the output of
    // the python script and call it gc_content.txt. We are telling NF that
    // this file should exist after the excution of the python script
    output:
    path("gc_content.txt")

    // This is the bash script to run the python file
    script:
    """
    gc_content.py
    """
}



workflow {
    // We call the DOWNLOAD process to download the fasta file
    DOWNLOAD()

    // We call the GC_CONTENT process to run the python script on the
    // file that we downloaded
    GC_CONTENT(DOWNLOAD.out)
}