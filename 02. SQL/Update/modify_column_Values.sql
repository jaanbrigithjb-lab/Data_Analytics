select gender,
case
when LOWER(Trim(gender)) in ('male','m')
then 'Male'
when LOWER(Trim(gender)) in ('female','f')
then 'Female'
else gender
end as cleaned_gender
from doctors;

update doctors
set gender=
case
when LOWER(Trim(gender)) in ('male','m')
then 'Male'
when LOWER(Trim(gender)) in ('female','f')
then 'Female'
else gender
end;

