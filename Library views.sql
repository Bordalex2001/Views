Create view [Teachers borrowed books from library] as
select t.first_name as ���, t.last_name as �������, b.name as �����
from Teacher t join Book b
on t.id = b.id

Create view [Students borrowed books but did not return them] as
select s.first_name as ���, s.last_name as �������
from Student s join S_Cards b
on s.id = b.id
where b.date_in is null

Alter view [Students borrowed books but did not return them] as
select s.first_name as ���, s.last_name as �������
from S_Cards b join Student s
on b.id_student = s.id
where b.date_in is null

Create view [Students have never borrowed books] as 
select s.first_name as ���, s.last_name as �������
from Student s 
where s.id not in (Select id from S_Cards)

Create view [Librarian issued the most books] as
select l.first_name as ���, l.last_name as �������
from Librarian l 
where exists (Select top 1 s.id_librarian, t.id_librarian 
from S_Cards s, T_Cards t)

Alter view [Librarian issued the most books] as
select top 1 l.first_name as ���, l.last_name as �������, 
count(*) as ��������_���� 
from (select * from S_Cards union select * from T_Cards)
as books join Librarian l on books.id_librarian = l.id
group by l.first_name, l.last_name
order by ��������_����

Create view [Librarian had the most books been returned] as
select l.first_name as ���, l.last_name as �������
from Librarian l
where exists (Select top 1 s.id_librarian, t.id_librarian
from S_Cards s, T_Cards t
where s.date_in is not null and t.date_in is not null)

Alter view [Librarian had the most books been returned] as
select top 1 l.first_name as ���, l.last_name as �������,
count(*) as ������������_����
from (select * from S_Cards where date_in is not null
union select * from T_Cards where date_in is not null)
as books join Librarian l on books.id_librarian = l.id
group by l.first_name, l.last_name
order by ������������_����
