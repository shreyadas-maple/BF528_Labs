include {FASTQC} from './modules/fastqc'

workflow {
    
    Channel.fromFilePairs(params.sample_dir)
    | transpose()
    | set { read_ch }

    read_ch.view()

    // Use an operator to transform the read_ch
    // to the appropriate shape for FASTQC

    FASTQC(read_ch)

    

}