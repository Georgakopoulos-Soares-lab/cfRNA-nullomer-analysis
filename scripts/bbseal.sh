#!/bin/bash

nulls=$2
baseNull=$(basename -s .fasta $nulls)

IN_DIR="${baseNull}/trimmed-neomer-fastq"
OUT_DIR="${baseNull}/deduped-filtered-trimmed-neomer-fastq"

SAMPLES=$1

mkdir -p $OUT_DIR

for sample in $SAMPLES
do
	seal.sh in=${IN_DIR}/${sample}_1_val_1.fq.gz in2=${IN_DIR}/${sample}_2_val_2.fq.gz \
		outu=${OUT_DIR}/${sample}_1.filtered.fastq.gz outu2=${OUT_DIR}/${sample}_2.filtered.fastq.gz \
		ref=/storage/home/abm6702/izg5139/abm6702/genome_references/UniVec.fa,/storage/home/abm6702/izg5139/abm6702/genome_references/ERCC92.fa,/storage/home/abm6702/izg5139/abm6702/genome_references/bacterial_contaminants.fasta,/storage/home/abm6702/izg5139/abm6702/genome_references/human_rrna.fa,/storage/home/abm6702/izg5139/abm6702/genome_references/rfam-5.8s-database-id98.fasta,/storage/home/abm6702/izg5139/abm6702/genome_references/rfam-5s-database-id98.fasta,/storage/home/abm6702/izg5139/abm6702/genome_references/silva-arc-16s-id95.fasta,/storage/home/abm6702/izg5139/abm6702/genome_references/silva-arc-23s-id98.fasta,/storage/home/abm6702/izg5139/abm6702/genome_references/silva-euk-18s-id95.fasta,/storage/home/abm6702/izg5139/abm6702/genome_references/silva-euk-28s-id98.fasta \
		refnames=t \
		stats=${OUT_DIR}/${sample}.bbseal.stats.txt

	dedupe.sh in=${OUT_DIR}/${sample}_1.filtered.fastq.gz,${OUT_DIR}/${sample}_2.filtered.fastq.gz \
	       out=${OUT_DIR}/${sample}.filtered.dedup.fastq.gz

done
