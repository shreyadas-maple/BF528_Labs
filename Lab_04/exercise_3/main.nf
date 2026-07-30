include {FASTQC} from './modules/fastqc'
include {MULTIQC} from './modules/multiqc'

workflow {

    // Make a channel for FASTQC
    Channel.fromFilePairs(params.full_dir)
    | transpose ()
    | set { file_ch }

    FASTQC(file_ch)
    
    // Use the .zip output of FASTQC and group 
    // all of the outputs into a single list using the operator
    // .collect()

    fastqc = FASTQC.out.zip.collect()


    // Run MultiQC on the list of FASTAQC outputs
    MULTIQC(fastqc)
}