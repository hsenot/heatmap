# This scripts extracts information from an Origin PDF file

# Requirement: xlsx2csv (https://github.com/dilshod/xlsx2csv) Python tool is accessible
# pip install xlsx2csv

# ssconvert can detect file types automatically based on file extension
xlsx2csv $1 $2/nmi.csv

# Loading the content of this temporary file in the staging table
psql -U ee_app -d ee -c "truncate table staging_notsure"
psql -U ee_app -d ee -c "copy staging_notsure (nmi, day, \"interval\", endtime, kwh, net_kwh, kvarh, net_kvarh, kva, kw, quality_status, timeslice, peak, offpeak, shoulder) from '$2/nmi.csv' CSV HEADER"

# Cleaning up after oneself
#rm $2/nmi.csv
