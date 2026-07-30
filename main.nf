// Instead of writing processes in our script `main.nf`
// We can specify each process separately in the modules/
// directly. We can then use include to make them available
// to our workflow. The name within the {} has to be the same
// as what's listed after the process. The path after from
// is the relative path to the process. 

// Include the other processes in modules after this one

include {NCBI_DATASETS_CLI} from './modules/ncbi_datasets_cli'
include {PROKKA} from './modules/prokka'
include {EXTRACT_REGION} from './modules/extract_region'
include {SAMTOOLS_FAIDX} from './modules/samtools_faidx'
include {SAMTOOLS_FAIDX_SUBSET} from './modules/samtools_faidx_subset'

workflow {

    // Make a channel from the samplesheet.csv that is a
    // tuple containing the name of the bacteria and the
    // assembly name (GCF_*)
    genomes = Channel.fromPath(params.samplesheet)
    // Split the csv using the comma and it has a header row
    | splitCsv(header: true)
    // Use the map operator to get the species name and the assembly id to be used for NCBI
    | map {row -> tuple(row.name, row.assembly)}
    // Name the channel to download_ch using the set operator 
    | set{download_ch}

    // After you make the initial channel from the spreadsheet
    // Link the correct processes together to perform the
    // listed steps in our workflow

    // Use NCBI_DATASETS_CLI to download all the FASTA files 
    NCBI_DATASETS_CLI(download_ch)

    // Send the output of NCBI (FASTA files) to Prokka to create a gene
    // annotation files (gff files)
    PROKKA(NCBI_DATASETS_CLI.out)

    // Send the gff files from Prokka to the process with the python script
    // to extract the interesting regions of the genome which are the 
    // forward strands of the genes to a txt file called "region_of_interest"
    EXTRACT_REGION(PROKKA.out.gff)

    // Generate a FASTA index file from the downloaded FASTA files, this 
    // annotates the FASTA files with the chromosome numbers and gene numbers
    SAMTOOLS_FAIDX(NCBI_DATASETS_CLI.out)

    // Create a channel that includes the name of the bacteria, the FASTA files
    // FASTA index files, and the "region_of_interest.txt" file and call it
    // subset_ch
    SAMTOOLS_FAIDX.out.join(EXTRACT_REGION.out)
    | set {subset_ch}

    // Pass the subset_ch to find the specific regions from the "region_of_interest.txt"
    // file and the FASTA index file in the FASTA file 
    SAMTOOLS_FAIDX_SUBSET(subset_ch)

}