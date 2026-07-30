workflow {

    Channel.of(tuple('Carsonella_rudii','region_of_interest.txt'))
    | set { extract_region_out }

    Channel.of(tuple('Carsonella_rudii', 'GCF_000287275.1_ASM28727v1_genomic.fna', 'GCF_000287275.1_ASM28727v1_genomic.fna.fai'))
    | set { samtools_faidx_out }

    extract_region_out.view()
    samtools_faidx_out.view()
    //samtools_faidx_out.join(extract_region_out)
    //|view ()

    


}