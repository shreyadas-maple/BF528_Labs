include {FASTQC} from './modules/fastqc'

workflow {

    // Use Channel.fromFilePairs to make a channel
    // with the reads. Channel.fromFilePairs will
    // make a channel with the same structure as you
    // did in your test.nf

    Channel.fromFilePairs(params.sample_dir)
    | view()
    | set {fastqc_reads}
    

    // Run FASTQC on the channel

    FASTQC(fastqc_reads)

}