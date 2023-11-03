#!/bin/sh

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input.md output.html"
  exit 1
fi

# Input and output files
input_file="$1"
output_file="$2"

# Check if the input Markdown file exists
if [ ! -f "$input_file" ]; then
  echo "Input file does not exist: $input_file"
  exit 1
fi

# Convert Markdown to HTML
markdown < "$input_file" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' > "$output_file"

# Reverse the entity substitutions
sed -i 's/\&lt;/</g; s/\&gt;/>/g' "$output_file"

# Check if the conversion was successful
if [ $? -eq 0 ]; then
  echo "Conversion complete. HTML output saved to: $output_file"
else
  echo "Conversion failed."
  exit 1
fi
