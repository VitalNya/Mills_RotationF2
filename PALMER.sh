#!/bin/bash
#SBATCH --job-name=HAPMAPMIX.dac.30x
#SBATCH --mail-user=vitalnya@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --account=remills0
#SBATCH --partition=standard
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=6g
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2

# ------------------------------------------------------------
# PALMER run script
# Usage: sbatch palmer.sh <input_long_read> <workdir> <chromosome>
# Example: sbatch palmer.sh sample1.bam sample1_workingdir chr1
# ------------------------------------------------------------

# Parse arguments
INPUT=$1
WORKDIR=$2
CHR=$3

# Optional: print info for logging
echo "Running PALMER on:"
echo "Input file: $INPUT"
echo "Workdir: $WORKDIR"
echo "Chromosome: $CHR"
echo "------------------------------------------------------------"

# Run PALMER
./PALMER --input "$INPUT" \
  --workdir "$WORKDIR"/ \
  --ref_ver other \
  --output "hapmap_${CHR}_numts" \
  --chr "$CHR" \
  --mode raw \
  --ref_fa /home/vitalnya/vitalnya/Mills_rotation/reference/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
  --type CUSTOMIZED \
  --custom_seq /home/vitalnya/vitalnya/Mills_rotation/reference/human_mitochondrion.fna
