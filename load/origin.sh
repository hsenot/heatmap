# This scripts extracts information from an Origin PDF file

# Requirement: pdf2txt tool is accessible
# sudo apt-get install python-pdfminer

# M 10 parameter required so that each line in the input PDF is maintained as a line in the text output 
pdf2txt -o /tmp/nmi.txt -M 10 $1

# Extracting only lines that start with a day of the week abbreviation
cat /tmp/nmi.txt | grep '^Mon \|^Tue \|^Wed \|^Thu \|^Fri \|^Sat \|^Sun ' > /tmp/nmi2.txt
START_DATE_STR=`cat /tmp/nmi.txt | grep 'Date Range .* to ' | cut -d " " -f3`

# Loading the content of this temporary file in the staging table
DIR=$(cd $(dirname "$0"); pwd)
psql -U ee_app -d ee -c "truncate table staging_origin1"
psql -U ee_app -d ee -c "copy staging_origin1 (content) from '/tmp/nmi2.txt'"

# Cleaning up after oneself
rm /tmp/nmi.txt
rm /tmp/nmi2.txt

# Returns the start date string
echo $START_DATE_STR
