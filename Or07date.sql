/************************   HR����
���ϸ�: Or07Date
��¥ ���� �Լ�  
���� : ��, ��, ��, ��, ��, ���� �������� ��¥������ �����ϰų� 
��¥�� ����� �� Ȱ���ϴ� �Լ��� 
************************/


-- Month_between() : ���� ��¥�� ���� ��¥ ������ �������� ��ȯ�մϴ�.
-- month_between( ���糯¥, ���س�¥[���� ��¥])
-- 2020�� 1�� 20��( �ڷγ� ù �ߺ���) ���� ���ݱ��� ���� ��������??

select 
    months_between(sysdate, '2020-01-20')"�⺻��¥����",
    months_between(sysdate,to_date('2020�� 01�� 20��','yyyy"��" mm"��" dd"��"')),
   ceil(months_between(sysdate,to_date('2020�� 01�� 20��','yyyy"��"mm"��"dd"��"')))
    from dual;

--employees  ���̺� �Էµ� �������� �ټӰ������� ����Ͽ� ����Ͻÿ�. �ټӰ������� ��������

select
    first_name,hire_date,
    ceil(months_between(sysdate, hire_date))�ټӰ�����1
    from employees
    order by �ټӰ�����1;
--select ����� �����ϱ� ���� order by�� ����� �� �÷����� ���Ͱ��� 2���� ���·� ����Ҽ� �ִ�.



--next_day ���糯¥�� �������� ���ڷ� �־��� ���Ͽ� �ش��ϴ� �̷��� ��¥�� ��ȯ�ϴ� �Լ�
-- next_day(���糯¥, �̷����ڿ���) -- ������ �������� �����ϱ��

select 
    to_char(sysdate, 'yyyy-mm-dd')���ó�¥,
    next_day(sysdate,'������')�����ֿ�����    
    from dual;
select   -- �Լ��ȿ� �Լ� �־ ǥ���ϱ�
    to_char(next_day(sysdate, '������'),'yyyy"��" mm"��" dd"��"')
    from dual;
    
--last_day() �ش���� ������ ��¥�� ��ȯ �մϴ�.
select  -- 23�� 12���� ������ 31��
    last_day('23-12-01')
    from dual;

--�ܼ� ��¥ ���� : ��¥�� �����Ϳ� ���ڸ� ���ϰų� ����, �� �Ⱓ��ŭ�� ��¥�� ����� �� �ִ�.
select
    sysdate"����" ,sysdate+1"����",sysdate -1 "����",sysdate+15"������"
    from dual;




















