workflow {

    Channel.of(tuple('WT', 'WT_rep1.bam'), tuple('WT', 'WT_rep2.bam'), tuple('KO', 'KO_rep1.bam'), tuple('KO', 'KO_rep2.bam'))
    | set { bam_ch }

    bam_ch
    | map {row -> row[1]}
    | filter (~/WT_.*/)
    | view()

}