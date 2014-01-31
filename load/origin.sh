# This scripts extracts information from an Origin PDF file

# Requirement: pdf2txt tool is accessible
# sudo apt-get install python-pdfminer

# M 10 parameter required so that each line in the input PDF is maintained as a line in the text output 
pdf2txt -o $2/nmi.txt -M 10 $1

# Extracting only lines that start with a day of the week abbreviation
cat $2/nmi.txt | grep '^Mon \|^Tue \|^Wed \|^Thu \|^Fri \|^Sat \|^Sun ' > $2/nmi2.txt
START_DATE_STR=`cat $2/nmi.txt | grep 'Date Range .* to ' | cut -d " " -f3`

# Loading the content of this temporary file in the staging table
DIR=$(cd $(dirname "$0"); pwd)
psql -U ee_app -d ee -c "truncate table staging_origin1"
psql -U ee_app -d ee -c "copy staging_origin1 (content) from '$2/nmi2.txt'"

# Cleaning up after oneself
rm $2/nmi.txt
rm $2/nmi2.txt

# Returns the start date string
echo $START_DATE_STR
