# This scripts extracts information from an AGL CSV file

# Removing trailing commas as they mess around with the CSV import
DIR=$(cd $(dirname "$0"); pwd)
cat $1 | sed 's/"A",/"A"/' > $2/nmi.txt

# Loading the content of this temporary file in the staging table
psql -U ee_app -d ee -c "truncate table staging_agl1"
psql -U ee_app -d ee -c "copy staging_agl1 (accountnumber,nmi,devicenumber,devicetype,registercode,ratetypedescription,startdate,enddate,profilereadvalue,registerreadvalue,qualityflag) from '$2/nmi.txt' HEADER CSV"

# Cleaning up
rm $2/nmi.txt
