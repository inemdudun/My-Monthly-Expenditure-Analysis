---Dataset Cleaning
---Creating back_up table
select *
from bank_statement2;
create table expenses
like bank_statement2;
select *
from expenses;
insert into expenses
select *
from bank_statement2;
----Removing Unwanted _Columns
alter table expenses
drop column `MyUnknownColumn_[1]`;
alter table expenses
drop column `MyUnknownColumn_[0]`;
alter table expenses
drop column `MyUnknownColumn_[2]`;
----Removing Unwanted _Rows
delete 
from expenses 
where balance = '';
delete
from expenses
where remarks = 'remarks';
------Standardizing the _table changing _type and correcting spellings
alter table expenses
rename column `Trans. Date` to Trans_date;
alter table expenses
rename column `Value. Date` to Value_date;
describe expenses;
alter table expenses
add column trans_date_new date;
select *
from expenses;
update expenses
set trans_date_new = str_to_date(Trans_date, '%d-%b-%Y');
update expenses
set Trans_date = trans_date_new;
alter table expenses
drop column trans_date_new;
alter table expenses
add column value_date_new date;
update expenses
set value_date_new = str_to_date(value_date, '%d-%b-%Y');
update expenses
set Value_date = value_date_new;
alter table expenses
drop column value_date_new;
select *
from expenses;
select `reference`
from expenses;
select `reference`, replace('0245401566061520 9732GTW', "'", '') AS cleaned_string
from expenses;
update expenses
set `reference` = replace('0245401566061520 9732GTW', "'", '') AS cleaned_string
where `reference` like "%'%";
alter table expenses
add column reference_new text;
update expenses
set reference_new =  replace('0245401566061520 9732GTW', "'", '');
update expenses
set `reference` = reference_new;
alter table expenses
drop column reference_new;
describe expenses;
ALTER TABLE expenses 
CHANGE COLUMN `Originating Branch` `Originating_branch` text;
select remarks
from expenses;
UPDATE expenses
SET remarks = CONCAT(UPPER(SUBSTRING(remarks, 1, 1)), LOWER(SUBSTRING(remarks, 2)));
UPDATE expenses
SET originating_branch = CONCAT(UPPER(SUBSTRING(originating_branch, 1, 1)), LOWER(SUBSTRING(originating_branch, 2)));

Select *
from expenses;
-----Grouping my expenses
update expenses
set credits = null
where credits = '';
select *, 
case
    when remarks  like '%airtime%' or remarks like '%happiness%' then 'Airtime % Data'
    when remarks  like '%ighodalo%' or remarks like '%leticia%' or remarks like '%maria%' then 'street shops'
    when remarks  like '%cash withdrawals%' or remarks like '%andorgie%' then 'market'
    when remarks  like '%happiness%' and debits < 7000 then 'Airtime $ Electricity'
    when remarks  like '%meekness%' or remarks like '%victoria%' or remarks like '%uto%' or remarks like '%itoro%' or remarks like 'margaret' then 'family'
    when remarks  like '%george%'  or '%solaristique' then 'Rent $ Maintenance'
    when remarks  like '%chicken republic%' or remarks like '%vicky Classi%s' or remarks like '%oche%' then 'Restaurant'
    when remarks  like '%tqv%' then 'Supermarket'
    when remarks  like '%vat%' or remarks like '%charge%' then 'Bank Charge'
    when credits is not null then 'Earnings' else 'miscellanous'
    end as expense_evaluation
from expenses;    

select *,
case
   when remarks  like '%george%'  or remarks like '%solaristique' then 'Rent $ Maintenance'
    when remarks  like '%chicken republic%' and remarks like '%vicky Classi%s' and remarks like '%oche%' then 'Restaurant'
     when remarks  like '%meekness%' and remarks like '%victoria%' and remarks like '%uto%' and remarks like '%itoro%'  and remarks like 'margaret' then 'family'
     when remarks  like '%ighodalo%' and remarks like '%leticia%' and remarks like '%maria%' then 'street shops'
    when remarks  like '%ighodalo%' and '%leticia%' and '%maria%' then 'street shops'
    when remarks  like '%cash withdrawals%' and '%andorgie%' then 'market'
from expenses;











