# Lab 07 - Genome Browsers

## Objectives
- Develop a nextflow workflow to align using both bowtie2 and STAR, sort and index the BAMs, and generate bigWig coverage tracks
- Use IGV to visualize the alignments and compare the difference between splice-aware and splice-unaware aligners on mRNAseq data

## Directions
I have provided you with modules that will run the various processes. These modules also include a stub run so that you can troubleshoot your workflow logic before running this on the actual data. 

You will need to:

1. Finish the modules for samtools sort, samtools index, and bamCoverage
2. Complete the workflow logic in the `main.nf`
3. Run the workflow with `nextflow run main.nf -profile singularity,cluster`

Use the name in the tuple to name your files using the value provided to you 
by the Channel.fromFilePairs function. Remember to pass static files (reference
fasta and GTF as params).

samtools sort
- The input should be able to take the output from either bowtie2_align or star_align
- Name the new file with the same prefix but ending in '.sorted.bam'

samtools index
- The input should be the output from samtools sort
- Ensure that your output includes both the sorted bam and the created index file (.bai)

bamCoverage
- The input should be the output from samtools index
- Name the output file with the name of the method used to align it (i.e. star.bw or bowtie2.bw)

## IGV Tutorial

For more information on IGV and paired end reads, you can refer to their
[official documentation](https://igv.org/doc/desktop/#UserGuide/tracks/alignments/paired_end_alignments/)