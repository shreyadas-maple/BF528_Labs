#!/usr/bin/env nextflow

include {BOWTIE2_BUILD} from './modules/bowtie2_build'
include {STAR_BUILD} from './modules/star_index'
include {BOWTIE2_ALIGN} from './modules/bowtie2_align'
include {STAR_ALIGN} from './modules/star_align'
include {SAMTOOLS_SORT} from './modules/samtools_sort'
include {SAMTOOLS_IDX} from './modules/samtools_idx'
include {BAMCOVERAGE} from './modules/deeptools_bamcoverage'


workflow {

    // Make a channel using the path to the reads in the param
    // Use Channel.fromFilePairs
    Channel.fromFilePairs(params.reads)
    | set{reads_ch}

    // Build both of the genome indexes - pass the GTF and FA as
    // params
    STAR_BUILD(params.genome_chr16, params.gtf)
    BOWTIE2_BUILD(params.genome_chr16)

    // Use a nextflow operator to separate the reads in the channel
    // by their name.
    reads_ch
           .branch{ it ->
            star: it[0].contains('star')
            bowtie2: it[0].contains('bowtie2')
           }.set{files}

    // Align the FASTQS called star with STAR
    STAR_ALIGN(files.star, STAR_BUILD.out.index)

    // Align the FASTQS called bowtie2 with bowtie2
    BOWTIE2_ALIGN(files.bowtie2, BOWTIE2_BUILD.out.index, BOWTIE2_BUILD.out.name)

    // Group all of the BAMS together into a single channel
    STAR_ALIGN.out.bam.concat(BOWTIE2_ALIGN.out).set{bams_ch}

    // Sort all of the bams
    SAMTOOLS_SORT(bams_ch)

    // Index all of the bams
    SAMTOOLS_IDX(SAMTOOLS_SORT.out.sorted)

    // Convert all of the BAMs into a bigwig
    BAMCOVERAGE(SAMTOOLS_IDX.out.index)

}