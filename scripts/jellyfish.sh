#!/bin/bash

nulls=$2
baseNull=$(basename -s .fasta $nulls)

IN_DIR="${baseNull}/mapped-deduped-filtered-trimmed-neomer-fastq"
OUT_DIR="${baseNull}/jellyfish"
SAMPLES=$1
KMER_LENGTH=$3

mkdir -p $OUT_DIR

for sample in $SAMPLES
do
	jellyfish count -C -m $KMER_LENGTH -s 100M -t 10 --if $nulls -o ${OUT_DIR}/${sample}.jf ${IN_DIR}/${sample}.mapped.sam 
	jellyfish dump -c ${OUT_DIR}/${sample}.jf > ${OUT_DIR}/${sample}.counts.txt
	jellyfish histo ${OUT_DIR}/${sample}.jf > ${OUT_DIR}/${sample}.histo.txt

done
