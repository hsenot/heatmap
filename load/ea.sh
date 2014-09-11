# This scripts extracts information from an EnergyAustralia CSV file

# Removing first 5 lines - it's a header
tail -n +6 $1 > $2/nmi.txt

# Loading the content of this temporary file in the staging table
psql -U ee_app -d ee -c "truncate table staging_ea"
psql -U ee_app -d ee -c "copy staging_ea (typ,date,start_time,end_time,usage,units,notes) from '$2/nmi.txt' HEADER CSV"

# Cleaning up
rm $2/nmi.txt
