include {MULTIQC} from './modules/multiqc'

workflow {

    Channel.of('P0rep1subsample_R1_fastqc.zip', 'P0rep1subsample_R2_fastqc.zip','P4rep2subsample_R1_fastqc.zip', 'P4rep2subsample_R2_fastqc.zip')
    | set {fastqc_ch}

    fastqc_ch.collect().view()

    
}