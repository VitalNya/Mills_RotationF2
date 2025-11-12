  GNU nano 2.9.8                                                                                                                                                                       PALMER_pipline.sh

#!/bin/bash

# ====================================================================================================
# PALMER Pipline: Multi-sample, Multi-chromosome
# Author: Vital Nyabashi
# PALMER Credit: https://github.com/WeichenZhou/PALMER
# Date: 11/07/2025
#
# Description:
#       The piple runs PALMER on multiple long read BAM files across all the 22 autosomes (ch1-ch22)
#       to detect NUMTS (nuclear mitochondrial DNA insertions).
#
# Output:
#       - PALMER files located in the SMaHT_folder
#       - Reference genome: GRch38
#       - Custom sequence: Human mitochondrial DNA fasta
#
# Requirements:
#       - PALMER (https://github.com/WeichenZhou/PALMER)
#       - samtools
#       - blast-plus
#
# Usage:
#       - sbatch PALMER_pipline.sh
#       - sbatch palmer_job.sh "$DATA_PATH" "$WORKDIR" "chr${CHR}"
# ====================================================================================================


#!/bin/bash
#SBATCH --job-name=PALMER
#SBATCH --mail-user=vitalnya@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --account=remills0
#SBATCH --partition=standard
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4g

# Accept arguments: data_path, workdir, chromosome
DATA_PATH="$1"
WORKDIR="$2"
CHR="$3"

# Make sure working directory exists
mkdir -p "$WORKDIR"

# Run PALMER
/home/vitalnya/vitalnya/Mills_rotation/PALMER/PALMER \
  --input "$DATA_PATH" \
  --workdir "$WORKDIR" \
  --ref_ver other \
  --output "${WORKDIR}/output_${CHR}" \
  --chr "$CHR" \
  --mode raw \
  --ref_fa /home/vitalnya/vitalnya/Mills_rotation/reference/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
  --type CUSTOMIZED \
  --custom_seq /home/vitalnya/vitalnya/Mills_rotation/reference/human_mitochondrion.fna
