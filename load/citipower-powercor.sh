# This scripts extracts information from an EnergyAustralia CSV file

# Loading the content of this temporary file in the staging table
psql -U ee_app -d ee -c "truncate table staging_citipower_powercor"
psql -U ee_app -d ee -c "copy staging_citipower_powercor (nmi,date,end_time,field4,field5,field6,field7,kwh,field9,state,field11,field12) from '$1' CSV"

