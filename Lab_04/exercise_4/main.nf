include {NCBI_DATASETS_CLI} from './modules/ncbi_datasets_cli'
include {JELLYFISH} from './modules/jellyfish'

workflow {

    Channel.fromPath(params.samplesheet)
    | splitCsv(header: false)
    | map { row -> tuple(row[0], row[1])}
    | set { genome_ch }

    Channel.of(1..9)
    | set { nmer_ch }

    // Download the genomes 
    NCBI_DATASETS_CLI(genome_ch)

    // Use the right operator to generate
    // channels with the genome and every value in
    // nmer_ch
    jellyfish_ch = NCBI_DATASETS_CLI.out.combine(nmer_ch)
    
    // Run Jellyfish on the new channel
    JELLYFISH(jellyfish_ch)
    
}