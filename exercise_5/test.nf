workflow {

    Channel.of(tuple('P0_rep1', 'P0_rep1.exon.txt'), tuple('P0_rep2', 'P0_rep2.exon.txt'), tuple('P4_rep1', 'P4_rep1.exon.txt'), tuple('P4_rep2', 'P4_rep2.exon.txt'))
    | map {name, file -> file}
    | toList()
    | view ()
    | set { verse_out }

}