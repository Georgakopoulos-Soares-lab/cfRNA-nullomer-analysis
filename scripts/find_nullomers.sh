#!/bin/sh

INPUT=$1
IFS=','
nulls=$2
KMER_LENGTH=$3
baseNull=$(basename -s .fasta $nulls)

OUT_DIR="${baseNull}/neomer-fastq"

mkdir -p $OUT_DIR

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read -r sample fastq_1 fastq_2 strandedness
do
	bbduk.sh in1=$fastq_1 in2=$fastq_2 \
		outm1=${OUT_DIR}/${sample}_1.fastq.gz outm2=${OUT_DIR}/${sample}_2.fastq.gz \
		k=$KMER_LENGTH \
		mm=f \
		ref=$nulls
done < <(tail -n+2 $INPUT)
