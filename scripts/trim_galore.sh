#!/bin/bash

nulls=$2
baseNull=$(basename -s .fasta $nulls)

IN_DIR="${baseNull}/neomer-fastq"
OUT_DIR="${baseNull}/trimmed-neomer-fastq"

SAMPLES=$1

mkdir -p ${OUT_DIR}

for sample in $SAMPLES
do

	trim_galore \
		--paired \
		--cores 4 \
		--fastqc \
		--output_dir ${OUT_DIR} \
		${IN_DIR}/${sample}_1.fastq.gz ${IN_DIR}/${sample}_2.fastq.gz
done
