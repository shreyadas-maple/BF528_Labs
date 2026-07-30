workflow {

    Channel.of(1..9)
    | set { kmer_count }

    Channel.of(tuple('Carsonella ruddii', 'GCF_2919291.fna'), tuple('Alteromonas macleodii', 'GCF_292811.2.fna'))
    | set { bacteria_ch }

    kmer_count.combine(bacteria_ch)
               .view()

}