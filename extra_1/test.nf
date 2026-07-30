workflow {

    Channel.of('P0_rep1_fastqc.html', 'P0_rep2_fastqc.html', 'P4_rep1_fastqc.html', 'P0_rep2_fastqc.html')
    | set { fastqc_ch }

    Channel.of(tuple('P0_rep1', 'P0_rep1.trimlog.txt'), tuple('P0_rep2', 'P0_rep2.trimlog.txt'), tuple('P4_rep1', 'P4_rep1.trimlog.txt'), tuple('P4_rep2', 'P4_rep2.trimlog.txt'))
    | set { trim_ch }

    trim_ch
    | map {row -> row[1]}
    | mix (fastqc_ch)
    | view()
    | set {output_ch}

}