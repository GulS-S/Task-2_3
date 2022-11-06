--// Task 1 Создать таблицу с основной информацией о сотрудниках: ФИО, дата рождения, дата начала работы, должность, 
--// уровень сотрудника (jun, middle, senior, lead), уровень зарплаты, идентификатор отдела, наличие/отсутствие прав(True/False). 
--//При этом в таблице обязательно должен быть уникальный номер для каждого сотрудника.


CREATE TABLE employees
(
    Id SERIAL PRIMARY KEY,
    tab_number integer UNIQUE,
    fio text ,
    birthday_date date,
    start_date date,
    employee_level character varying(30),
    department_id character varying(100),
    availability_or_absence_of_rights boolean,
    salary_level numeric
    );


--// Task 2 Для будущих отчетов аналитики попросили вас создать еще одну таблицу с информацией по отделам – 
--//в таблице должен быть идентификатор для каждого отдела, название отдела (например. Бухгалтерский или IT отдел), 
--//ФИО руководителя и количество сотрудников.

CREATE TABLE departments
(
    Id SERIAL PRIMARY KEY,
    name_department character varying(50),
    head_of_department text,
    number_of_employees numeric
    );



--//Task 3 На кону конец года и необходимо выплачивать сотрудникам премию. Премия будет выплачиваться по совокупным оценкам, 
--//которые сотрудники получают в каждом квартале года. Создайте таблицу, в которой для каждого сотрудника 
--//будут его оценки за каждый квартал. Диапазон оценок от A – самая высокая, до E – самая низкая.

CREATE TABLE rating
(
    Id SERIAL PRIMARY KEY,
    employee character(50),
    rating character(1)    
);



--Task 4
--Несколько уточнений по предыдущим заданиям – в первой таблице должны быть записи как минимум о 5 сотрудниках, 
--которые работают как минимум в 2-х разных отделах. Содержимое соответствующих атрибутов остается на совесть вашей фантазии, но, желательно соблюдать осмысленность 
--и правильно выбирать типы данных (для зарплаты – числовой тип, для ФИО – строковый и т.д.)

-- сотрудники

INSERT INTO public.employees(
	tab_number, fio, birthday_date, start_date, employee_level, department_id, availability_or_absence_of_rights, salary_level)
	VALUES 

	(123,	'Семенов',	'1957-02-12',	'1999-05-12',	'lead',	'Бухгалтерия',	true,	300000),
	(132,	'Иванова',	'1980-05-14',	'2008-07-30',	'lead',	'Отдел кадров',		250000),
	(142,	'Петрова',	'1969-02-16',	'2012-03-15',	'lead',	'Аналитический отдел',	true,	350000),
	(1132,	'Добрянский',	'1999-09-17',	'2019-08-18',	'middle',	'Аналитический отдел',	true,	150000),
	(1243,	'Николаева',	'1992-03-16',	'2014-06-19',	'middle',	'Отдел кадров',true,	75000);



--отделы

INSERT INTO public.departments(
	 name_department, head_of_department, number_of_employees)
	VALUES 

	('Бухгалтерия',	'Семенов',	5),
	('Отдел кадров', 'Иванова',	4),
	('Аналитический отдел',	'Петрова', 5);


--рейтинг

INSERT INTO public.rating(employee, rating)
	VALUES 
	('Семенов' , 'B'),
	('Добрянский', 'C'),
	('Николаева','E'),
	('Петрова', 'A'),
	('Иванова', 'B');


--// Task 5 Ваша команда расширяется и руководство запланировало открыть новый отдел – отдел Интеллектуального анализа данных.
-- // На начальном этапе в команду наняли одного руководителя отдела и двух сотрудников. 
 --// Добавьте необходимую информацию в соответствующие таблицы.

INSERT INTO public.departments (name_department, head_of_department, number_of_employees)
VALUES
('отдел Интеллектуального анализа данных', 'Сидоров', 2);


INSERT INTO public.rating (employee,rating)
VALUES
('Сидоров', 'A'),
('Субботин','A');


INSERT INTO public.employees (tab_number, fio, birthday_date, start_date, employee_level, department_id, availability_or_absence_of_rights, salary_level)
VALUES
(1432,	'Сидоров',	'1987-09-17',	'2022-06-23',	'lead',	'отдел Интеллектуального анализа данных', true, 200000),
(1433,	'Субботин',	'1992-09-17',	'2022-06-23',	'middle',	'отдел Интеллектуального анализа данных', true, 150000);




--// Task 6.1 Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании

SELECT tab_number, fio, (current_date-start_date ) as experience  FROM public.employees

--// Task 6.2 Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
SELECT tab_number, fio, (current_date-start_date ) as experience  FROM public.employees LIMIT 3;

--// Task 6.3 Уникальный номер сотрудников - водителей

SELECT tab_number, fio FROM public.employees WHERE availability_or_absence_of_rights=TRUE

--// Task 6.4 Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E

select* FROM public.rating WHERE rating='E' OR rating='D';

--// Task 6.5 Выведите самую высокую зарплату в компании

SELECT MAX (salary_level) FROM public.employees 

