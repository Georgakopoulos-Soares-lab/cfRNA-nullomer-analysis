#!/bin/bash
#SBATCH --time=48:00:00
#SBATCH --job-name='cfRNA-main'
#SBATCH --mem=128GB
#SBATCH --output=cfRNA.out
#SBATCH --mail-user=abm6702@psu.edu

#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --array=1-230

config=main_config.txt

INPUT=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' FS=',' $config)
NULLS="../nullomers/pancan_WES_neomers_16bp.fasta"

SAMPLE=$(cut -f1 -d, $INPUT | tail -n+2)

conda run -n bbmap bash scripts/find_nullomers.sh $INPUT $NULLS
conda run -n trim-galore bash scripts/trim_galore.sh $SAMPLE $NULLS
conda run -n bbmap bash scripts/bbseal.sh $SAMPLE $NULLS
conda run -n bbmap bash scripts/bbmap.sh $SAMPLE $NULLS
conda run -n jellyfish bash scripts/jellyfish.sh $SAMPLE $NULLS
