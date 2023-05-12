#!/bin/bash

nulls=$2
baseNull=$(basename -s .fasta $nulls)

IN_DIR="${baseNull}/deduped-filtered-trimmed-neomer-fastq"
OUT_DIR="${baseNull}/mapped-deduped-filtered-trimmed-neomer-fastq"

REF="/storage/home/abm6702/izg5139/abm6702/genome_references/NR99_GRCh38_viruses-edited.fasta.gz"
SAMPLES=$1

mkdir -p $OUT_DIR

for sample in $SAMPLES
do
	bbmap.sh in=${IN_DIR}/${sample}.filtered.dedup.fastq.gz \
		outm=${OUT_DIR}/${sample}.mapped.sam \
		ref=${REF} \
		maxindel=100000 \
		minid=0.9 \
		kfilter=25 \
		trimq=10 \
		ordered=t \
		idtag=t \
		scoretag=t
done
		
