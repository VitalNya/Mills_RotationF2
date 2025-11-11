#!/bin/bash
# ------------------------------------------------------------
# Purpose:
#   Automate PALMER runs for multiple long-read sequencing datasets.
#   For each long-read sample, submit SLURM jobs across chromosomes 1–22.
#   Each job calls 'palmer.sh' with arguments: (long_read, workdir, chr)
#
# Dependencies:
#   - PALMER executable in working directory
#   - SLURM job scheduler (sbatch command available)
#   - Reference FASTA files in specified paths
# ------------------------------------------------------------

# Directory containing list of long-read dataset names (one per line)
LIST="./SMaHT_list_directory/sample_list.txt"

# Loop through each long-read dataset listed in LIST
while read -r LONG_READ; do
    # Skip empty lines or comment lines
    [[ -z "$LONG_READ" || "$LONG_READ" == \#* ]] && continue

    # Define the working directory for this sample
    WORKDIR="/SMaHT/${LONG_READ}_workingdir"
    mkdir -p "$WORKDIR"

    # Loop through chromosomes 1–22
    for CHR in {1..22}; do
        echo "Submitting PALMER job for ${LONG_READ} on chr${CHR}..."
        sbatch palmer.sh "$LONG_READ" "$WORKDIR" "chr${CHR}"
    done

done < "$LIST"
