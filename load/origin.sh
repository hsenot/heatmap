# This scripts extracts information from an Origin PDF file

# Requirement: pdfminer is installed and pdf2txt tool is accessible
# 

# M 10 parameter required so that each line in the input PDF is maintained as a line in the text output 
pdf2txt.py -o /tmp/nmi.txt -M 10 $1

# Extracting only lines that start with a day of the week abbreviation
cat /tmp/nmi.txt | grep '^Mon \|^Tue \|^Wed \|^Thu \|^Fri \|^Sat \|^Sun ' > out/nmi.txt

