include {FASTQC} from './modules/fastqc'
include {TRIM} from './modules/trimmomatic'
include {MULTIQC} from './modules/multiqc'

workflow {

    // Channel of reads
    Channel.fromFilePairs(params.sample_dir)
    | set { read_ch }

    // Run FASTQC and TRIM
    FASTQC(read_ch.transpose())
    TRIM(read_ch)

    // Create a single list with the
    // .zip and .log outputs from FASTQC
    // and TRIM
    TRIM.out.log
    | map {row -> row[1]}
    | mix(FASTQC.out.zip)
    | set {multiqc_ch}

    //multiqc_ch.view()

    // Run MULTIQC on the grouped outputs
    MULTIQC(multiqc_ch)
    
}