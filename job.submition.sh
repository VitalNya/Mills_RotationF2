#!/bin/bash
# ------------------------------------------------------------
# Purpose:
#   Automate PALMER runs for multiple long-read sequencing datasets.
#   For each long-read sample, submit SLURM jobs across chromosomes 1–22.
#   Each job calls 'palmer.sh' with arguments: (data_path, workdir, chr)
# ------------------------------------------------------------

# Path to text file containing list of dataset names (one per line)
LIST="/home/vitalnya/vitalnya/Mills_rotation/long_reads.list"

# Directory containing actual long-read data
DATA_BASE="/home/vitalnya/DATA.smart"

# Directory where SMaHT output folders will live
OUTPUT_BASE="/home/vitalnya/vitalnya/Mills_rotation/SMaHT"

# Save the current working directory
CUR_WKD=$(pwd)

# Loop through each long-read dataset
while read -r LONG_READ; do
    [[ -z "$LONG_READ" || "$LONG_READ" == \#* ]] && continue

    # Full path to this dataset’s data
    DATA_PATH="${DATA_BASE}/${LONG_READ}"

    # Define parent directory for this dataset
    PARENT_DIR="${OUTPUT_BASE}/${LONG_READ}_workingdir"
    mkdir -p "$PARENT_DIR"

    # Loop through chromosomes 1–22 and submit jobs
    for CHR in {1..22}; do
        WORKDIR="${PARENT_DIR}/workingdir_chr${CHR}"
        mkdir -p "$WORKDIR"
        sbatch PALMER_pipline.sh "$DATA_PATH" "$WORKDIR" "chr${CHR}"
    done

    # Return to the original directory before processing the next dataset
    cd "$CUR_WKD"

done < "$LIST"
