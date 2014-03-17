# This scripts extracts information from a CLICK CSV file

# Loading the content of this temporary file in the staging table
psql -U ee_app -d ee -c "truncate table staging_click"
psql -U ee_app -d ee -c "copy staging_click (c1, date, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48,c2,c3,c4,c5) from '$1' CSV HEADER"
