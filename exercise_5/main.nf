include {VERSE} from './modules/verse'
include {CONCAT} from './modules/concat'


workflow {

    Channel.fromPath(params.samplesheet)
    | splitCsv(header: true)
    | map { row -> tuple(row.sample, file(row.bam))}
    | set { bam_ch }

    // Run VERSE using the bam_ch and the GTF in the config
    VERSE(bam_ch, params.gtf)

    // Group all of the outputs of VERSE into a single list
    VERSE.out.counts
    | map {name, file -> file}
    | toList()
    | set { verse_out }
    
    // Run the CONCAT process on the list of VERSE outputs
    CONCAT(verse_out)

}