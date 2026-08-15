USE Hospital_Analytics_DB;

alter table doctors
modify column table_name date not null;