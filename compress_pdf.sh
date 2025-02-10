#!/bin/bash

# Description:
# This script compresses all PDF files in the current directory using Ghostscript.
# Compressed files are saved with a "_compressed.pdf" suffix.
# If the compressed file is smaller than the original, the original is moved to a subfolder.
# If the compressed file is not smaller, it is removed.

# You can change the PDFSETTINGS for different compression levels:
# /screen (screen-view-only quality, smallest size)
# /ebook (low quality, medium size)
# /printer (high quality, larger size)
# /prepress (high quality, suitable for prepress)
# /default (balance between quality and size)

PDFSETTINGS="/screen"  # Change this as needed

# Create directories for compressed PDFs and original PDFs
COMPRESSED_DIR="compressed_pdfs"
ORIGINAL_DIR="original_pdfs"
mkdir -p "$COMPRESSED_DIR"
mkdir -p "$ORIGINAL_DIR"

# Loop through all PDF files in the current directory
for pdf in *.pdf; do
    # Check if there are any PDF files
    if [ ! -e "$pdf" ]; then
        echo "No PDF files found in the current directory."
        exit 1
    fi

    # Define output file name
    filename=$(basename "$pdf" .pdf)
    output_file="${COMPRESSED_DIR}/${filename}_compressed.pdf"

    echo "Compressing $pdf -> $output_file"

    # Compress the PDF using Ghostscript
    gs -sDEVICE=pdfwrite \
       -dCompatibilityLevel=1.4 \
       -dPDFSETTINGS="$PDFSETTINGS" \
       -dNOPAUSE \
       -dQUIET \
       -dBATCH \
       -sOutputFile="$output_file" \
       "$pdf"

    # Check if compression was successful
    if [ $? -eq 0 ]; then
        # Compare file sizes
        original_size=$(stat -c%s "$pdf")
        compressed_size=$(stat -c%s "$output_file")

        if [ "$compressed_size" -lt "$original_size" ]; then
            echo "Successfully compressed $pdf (Original: $original_size bytes, Compressed: $compressed_size bytes)"
            # Move the original file to the original_pdfs directory
            mv "$pdf" "$ORIGINAL_DIR/"
        else
            echo "Compressed file is not smaller. Removing $output_file"
            rm "$output_file"
        fi
    else
        echo "Failed to compress $pdf"
    fi
done

echo "All PDF files have been processed. Compressed files are in the '$COMPRESSED_DIR' directory."
echo "Original files of successful compressions are in the '$ORIGINAL_DIR' directory."