#!/usr/bin/env nextflow

process DOWNLOAD {

    output:
    path("GCF_000005845.2_ASM584v2_genomic.fna.gz")

    script:
    """
    wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
    """

}

process GC_CONTENT {

    // This is defining the sepcific environment that you need for this process, you need biopython
    // so we use a yml file that defines the creation of the environment including biopython package
    conda 'envs/biopython_env.yml'

    // The input is the genome file that we get from the DOWNLOAD process
    input:
    path(genome)

    // We define the output file to be called gc_content.txt
    output:
    path("gc_content.txt")

    // The script here is based on the argparse that was defined the gc_content.py python file
    script:
    """
    gc_content.py -i $genome -o gc_content.txt
    """
    
}

workflow {
    DOWNLOAD()

    GC_CONTENT(DOWNLOAD.out)

}