/************************   HR����
���ϸ�: Or08GroupBy
�׷��Լ� :  ��ü ���ڵ�(row)���� ������� ����� ���ϱ�����
            �ϳ��̻��� ���ڵ带 �׷����� ��� 
            ������ ����� ��ȯ�ϴ� �Լ� Ȥ�� ������
���⼭ ���� �Լ����� �׷� �ȿ��� ��밡�� �ϴ� ��� �����ϸ� ����
having count OO  where count XX
************************/
--������̺��� ������ ���� : ��107�� 
select job_id from employees;


--distinct : ������ ���� �ִ� ��� �ߺ��� ���ڵ带 ������ �� �ϳ��� ���ڵ常 �����ͼ� �����ش�. ��谪 ���� X
select distinct job_id from employees;

--group by : ������ ���� �ִ� ���ڵ带 �ϳ��� �׷����� ��� �����´�. 
--           �������� ���� ���ڵ����� �ټ��� ���ڵ尡 �ϳ��� �׷����� ������ ����̹Ƿ� 
--           ������� ����� ������ �� �ִ�. Ex �հ� �ִ� �ּ� ��� ���� ������ ���� �׷캰

--�������� �������� ������� count �غ��ϴ�.

select job_id, count(*) from employees group by job_id;

--������ ���� �ش������ ���� select �ؼ� ����Ǵ� ���� ������ ���غ���.
select first_name, job_id from employees where job_id = 'FI_ACCOUNT'; 
select first_name, job_id from employees where job_id = 'ST_CLERK';

-- group���� ���Ե� select��
-- select �÷�1, �÷�2, *
--    from ���̺��
--      where ���� N
--         groupby �����ͱ׷�ȭ�� ���� �÷���
--             having �׷쿡�� ã�� ����
--               orderby ����������

--sum() : �հ踦 ���Ҷ� ����ϴ� �Լ� numberŸ���� �÷������� ����� �� �ִ�. 
--select sum(�� Ȥ�� �÷�) from ���̺��;
-- ��ü ������ �޿��� �հ踦 ����Ͻÿ� 

select 
    sum(salary)tosal,
    to_char(sum(salary),'990,000')tosal2,
    ltrim(to_char(sum(salary),'$990,000'))tosal3,
    ltrim(to_char(sum(salary),'L990,000'))tosal4
from employees;

--10�� �μ��� �ٹ��ϴ� ������� �޿��� �հ�� ������ ����Ͻÿ�
--select 
--    sum(salary)�޿��հ�, 
--    to_char(sum(salary),'990,000')�հ�ǥ��
--    from employees
--    where department_id = 80
--    group by DE

--count() : �׷�ȭ�� ���ڵ��� ������ ī��Ʈ�Ҷ� ����ϴ� �Լ�
select count(*) from employees;
select count(employee_id) from employees;

--count() �� ����Ҷ��� �� �ΰ��� ��� ��� ���������� * �� ����Ұ��� �����մϴ�. 
--  �÷��� Ư�� Ȥ�� �������� ���� ���ظ� ���� �����Ƿ� ����ӵ��� ������  
--  ?  Ư���׸��� ���ϰԵǸ� ã�ư��°����߻� ������ �߻��Ҽ� �����Ƿ� �̷����� �ƽ�Ÿ�� ����ϴ°� �� ������ ����
--   count( all �÷���) : �������� �÷� ��ü�� ���ڵ带 �������� ī��Ʈ�մϴ�.
--   count( distinct �÷���) :  �ߺ��� ������ �ѻ��¿��� ī��Ʈ�մϴ�.

select 
    count(job_id)"������ ��ü ����1",
    count(all job_id)"������ ��ü ����2",
    count(distinct job_id)"������ ����3"
from employees;

--avg() : ��հ��� ���� �� ����ϴ� �Լ�
--��ü ����� ��� �޿��� ������ query���� �ۼ��Ͻÿ�

select 
    count(*)"��ü������",
    sum(salary)"��ü�޿�",
    sum(salary)/ count(*)"��ձ޿�",
    avg(salary),
    trim(to_char(avg(salary),'$999,999'))"���İ�������"
from employees;

--������ SALES �� ��ձ޿��� ���Ͻÿ�.
-- �����˻��� ��ҹ��� Ȥ�� ������ ���Ե� ��� ��� ���ڵ忡 ���� ���ڿ��� Ȯ���ϴ� ���� �Ұ����մϴ�.
-- �ϰ����� ��Ģ�� ������ ���� lower,upper() �� ���� ��ȯ �Լ��� ����Ͽ� �˻��ϴ� ���� ����. 
select * from departments where lower(department_name) = lower('sales');
--�μ���ȣ�� 80�� ���� Ȯ������ ���� query���� �ۼ��Ѵ�.
select 
    ltrim(to_char(avg(salary),'$999,000.00'))
    from employees where department_id = 80;
    
-- max() min() �ִ밪 �ּҰ��� ã���� ����ϴ� �Լ�
--   ��ü ����� ���� ���� �޿��� ���ΰ���

select 
    min(salary),
    max(salary)
    from employees;
--��ü ����� �޿��� ���� ���� ������ �����ΰ���?
select first_name, last_name, salary from employees where salary = min(salary);
-- ������ �߻��Ѵ�. �׷��Լ��� �Ϲ��÷��� ����� �� �����ϴ�. min(salary)


-- ������̺��� ���� ���� �޿��� 2100�� �޴»���� �����Ѵ�.
select 
    first_name, last_name, salary
    from employees
    where salary = 2100;
--����� ���� ���� �޿��� min() ���Ҽ� ������ ���� ���� �޿��� �޴� ����� �Ʒ��� ���� ���������� ���� ���Ҽ� �ֽ��ϴ�.
-- ���� ������ ���� ���� ������ ������� ���θ� �����ؾ��մϴ�. 
select 
    first_name, salary from employees 
    where salary = (select min(salary) from employees);  -- �������� �����
    
--group by : �������� ���ڵ带 �ϳ��� �׷����� �׷�ȭ�Ͽ� ������ ����� ��ȯ�ϴ� query��
--    distinct�� �ܼ��� �ߺ����� �����ϴ°��̱� ������ ȥ������ 

-- ������̺��� �� �μ��� �޿��� �հ�� ���ΰ���?

-- ���� ���� �μ��� �޿� 
select to_char(sum(salary), '999,000') from employees where department_id = 60;
select sum(salary) from employees where department_id = 100;

--�׷�ȭ�� �̿��� �� �μ��� �޿� 
-- �μ��� ���� ��� ������ �μ����� Ȯ���� �� �����Ƿ� �μ��� �׷�ȭ �մϴ�. 
-- �ߺ��� ���ŵ� ����� �������� ������ ���ڵ� �ϳ��� �׷����� ������ ����� ����˴ϴ�.
-- �� �μ����� �޿��� �հ踦 ���� �� �ִ�. 4�ڸ��� �Ѿ�� ��� �������� �������Ƿ� ������ �̿��ؼ� ���ڸ����� ,�� ǥ���մϴ�.
select department_id from employees group by department_id;  -- �ϴ� �׷�ȭ

select department_id , trim(to_char(sum(salary),'999,000'))"tosal" 
    from employees 
    group by department_id
    order by sum(salary) desc; 
    
-- ������̺��� �� �μ��� ������� ��� �޿��� ������ ���Ͻÿ� 
-- ��°�� : �μ���ȣ,  �޿�����, �������, ��ձ޿�
-- ��½� �μ����� ��������

select
    department_id �μ���ȣ,
    rtrim(to_char(sum(salary),'999,000'))�޿�����,
    count(*)����� , 
    rtrim(to_char(avg(salary),'999,000'))��ձ޿� 
    from employees 
    group by department_id
    order by department_id asc ;


-- groupby ���� ����� �÷��� select������ ����Ҽ� ������, �׿��� �����÷��� select ������ ����Ҽ������ϴ�.
--�׷�ȭ�� ���¿��� Ư�� ���ڵ� �ϳ��� �����ϴ� ���� �ָ��ϱ� �����̴�  
select department_id, sum(salary), count(*), avg(salary), first_name  --  �����÷�first_name �׷�ȭ department_id
    from employees 
    group by department_id
    order by department_id asc ;


--�μ����̵� 50�� ������� ��������, ��ձ޿�, �޿������� ���Ͻÿ�
select '50�� �μ�', count(*), round(avg(salary)), sum(salary)
    from employees
    where department_id = 50 
    group by department_id;
    
    
--group by having �� : ���������� �����ϴ� �÷��� �ƴ� �׷��Լ��� ���� �������� ������ �÷��� ������ �߰��Ҷ� ����մϴ�.
-- �ش������� where���� �߰��ϸ� ������ �߻��մϴ�.

--@@ ������̺��� �� �μ����� �ٹ��ϰ� �ִ� ������ �������� 
--   ������� ��ձ޿��� ������ ���Ͻÿ�
-- ��, ������� 10�� �ʰ��ϴ� ���ڵ常 �����Ͻÿ�.

--���� �μ��� �ٹ��ϴ��� �������� �ٸ��� �����Ƿ� �̹��������� group by ���� 2���� �÷��� ����ؾ��Ѵ�. 
-- �� �μ��� �׷�ȭ �� �� �ٽ� ���������� �׷�ȭ �Ѵ�.

select department_id ,job_id, count(*), avg(salary)
    from employees
    where count(*) >= 2 -- �����߻�!  �������� ������� ���������� �����ϴ� �÷��� �ƴϹǷ� where ���� ����ϸ� �����߻� 
    group by department_id, job_id;
    
--  Ex �޿��� 3000�� ��� -->  ���������� �����ϴ� salary���̺�� �÷��̹Ƿ� where���� ���
--      ��� �޿��� 3000�� ��� ---> ���� �������� �����ϹǷ�  having ���� ���
--                                                        ��, �׷��Լ��� ���� ���Ҽ� �ִ� ��������. 
    
    
    
select department_id ,job_id, count(*), avg(salary)
    from employees
    group by department_id, job_id;
    having count(*);  --�׷��� ������ having���� ���
    
-- �������� ����� �����޿��� ����Ͻÿ� 
-- ��, �����ڰ� ���� ����� �����޿��� 3000�̸��� �׷��� ���ܽ�Ű�� ,����� �޿��� ������������ ����Ͻÿ� 

select 
    job_id, min(salary)
    from employees
    where manager_id is not null
    group by job_id
    having not min(salary) < 3000
    order by min(salary) desc;
    
--select 
--    job_id, min(salary), salary --  �̷��� �ǵ� salary�� �����÷��̹Ƿ� �׷���� �Ұ��� 
--    from employees
--    where manager_id is not null
--    group by job_id
--    having not min(salary) < 3000
--    order by salary desc;  -- ���⼭ ����!
--    
/*******************************************
��������
*******************************************/

--#�ش� ������ hr������ employees ���̺��� ����մϴ�.

/*
1. ��ü ����� �޿��ְ��, ������, ��ձ޿��� ����Ͻÿ�. �÷��� ��Ī�� 
�Ʒ��� ���� �ϰ�, ��տ� ���ؼ��� �������·� �ݿø� �Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
*/
--round(), to_char() : �ݿø� ó�� �Ǿ� ��µ�
--trunc() : �Ҽ� ���ϸ� �߶� ��µ�. �ݿø����� ����.


/*
2. �� ������ �������� �޿��ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. 
�÷��� ��Ī�� �Ʒ��� �����ϰ� ��� ���ڴ� to_char�� �̿��Ͽ� ���ڸ����� 
�ĸ��� ��� �������·� ����Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
�޿��Ѿ� -> SumPay
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
    


/*
3. count() �Լ��� �̿��Ͽ� �������� ������ ������� ����Ͻÿ�.
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
--���������� �����ϴ� �÷��� �ƴ϶�� �Լ� Ȥ�� ������ �״�� order by����
--����ϸ�ȴ�.
--������ �ʹ� ��ٸ� ��Ī�� ����ص� �ȴ�. 


/*
4. �޿��� 10000�޷� �̻��� �������� �������� �հ��ο����� ����Ͻÿ�.

/*
5. �޿��ְ�װ� �������� ������ ����Ͻÿ�. 
*/


/*
6. �� �μ��� ���� �μ���ȣ, �����, �μ� ���� ��� ����� ��ձ޿��� 
����Ͻÿ�. ��ձ޿��� �Ҽ��� ��°�ڸ��� �ݿø��Ͻÿ�.
*/



    






