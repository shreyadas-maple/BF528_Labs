workflow {
    
    Channel.fromFilePairs(params.sample_dir)
    | transpose()
    | set { read_ch }

    read_ch.view()

}