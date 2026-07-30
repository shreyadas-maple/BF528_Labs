workflow {

    
    Channel.of(tuple('GenomeA', 'genomeA.fa', 'genomeA.fa.fai'), tuple('GenomeB', 'genomeB.fa', 'genomeB.fa.fai'))
    | set { idx_ch }


    Channel.of(tuple('GenomeA', 'region_of_interest_A.txt'), tuple('GenomeB', 'region_of_interest_B.txt'))
    | set { region_ch }

    idx_ch
    | mix(region_ch)
    | groupTuple()
    | map {it.flatten()}
    | view()




}