/************************HR����
���ϸ�: Or05String
���ڿ� ó�� ���� �Լ� 
���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴ� �� ���ڿ��� �����ϴ� �Լ�
************/



--concat(S,S)  || �ε� ��밡�� ���ڿ��� ���ڿ��� �����ؼ� ����ϴ� �Լ� 3���̻��� || ���
select concat('a','b') from dual;
select 'a'||'b' from dual;
select 'sun'||'woo'||'sun' from dual;
--������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�.
select first_name||last_name"�̸�",salary, job_id from employees; -- ������ �ϳ� �������� ������ ����
select first_name||' '||last_name"�̸�",salary, job_id from employees;

--initcap() ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ� 
-- ù���ڸ� �ν��ϴ� ����: ���鹮�� ������ ������ ù���ڸ� ��ȯ!
--                         ���ĺ��� ���ڸ� ������ ������ ���� ������ ������ ù��° ���ڸ� �빮�ڷ� ��ȯ�մϴ�.???
--                         ���ĺ��� ���� �ٷεڿ����� ���ڴ� ��ȯ�����ʴ´�. ??����! 
-- hi, hello �� ù��°�� �빮�ڷ� ���� 
select initcap('hi hello �ȳ�') from dual;  --Hi Hello �ȳ�
select initcap('or5hi hello �ȳ�') from dual;  
select initcap('good/bad/mornig') from dual; -- g b m �� �빮�ڷ� ��ȯ
select initcap('naver6say*good��bye') from dual; --���ڹٷεڿ����� ���ڴ� ��ȯ�����ʴ´�.
--������̺��� fistname �� john�� ����� ã�� �����Ͻÿ�
select * from employees where first_name = initcap('john');
--�̿Ͱ��� query�ϸ� ����� ��������ʽ��ϴ�. �����ʹ� ��ҹ��ڸ� �����ϱ⶧�� initcap�� �����ָ� ���� �̸�������쿡��!


--lower() ���ڿ��� �ҹ��ڷ� ��ȯ
--upper() ���ڿ��� �빮�ڷ� ��ȯ 
select lower('SUNWOO') from dual;
select upper('sunwoo') from dual;
--���� ���� john�� �˻� �ϱ����� ������ ���� Ȱ���� �� �ֽ��ϴ�.
--�̸� �̳� ���� �˻��� ���� �̿�� 
select * from employees where lower(first_name)='john';  --�ҹ��ڷ� �ٲ� �ڷ� = �ҹ���
select * from employees where upper(first_name)='JOHN'; -- �÷���ü�� �Ҵ빮�ڷ� ������ �� query�մϴ�.

--lpad() rpad() ���ڿ��� ���� �������� Ư���� ��ȣ�� ä�ﶧ ����Ѵ�.
-- ���� lpad('���ڿ�',��ü�ڸ���,'ä�� ���ڿ�')
-- ��ü�ڸ��߿��� ���忭�� ���̸�ŭ�� ä���ִ� �Լ�
select 'good',lpad('good',7,'#'), rpad('good',7,'#'), lpad('good',7) from dual; --�߰����ڿ��ڸ��� ����� �����߰�
select lpad('���ڿ�',7, 'L') from dual;    --??
--�̸� ��ü�� 12�ڷ� �����Ͽ� �̸��� ������ ������ �κ��� *�� ä���
select rpad(first_name,12, '*') from employees;
select rpad(first_name,12) || rpad(last_name,12) from employees;  -- Ȱ�����
--!!������̺��� first_name �� ù���ڸ� ������ ������ �κ� *�� ����ŷ ó���ϴ� query���� �ۼ��Ͻÿ�

--select lpad(first_name ,1)||substr(first_name,2)


--substr() ���ڿ����� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����մϴ�.
--  substr(�÷�,�����ε���,����) from dual;  
-- ����Ŭ�� �ε����� 1���� �����Ѵ�.
-- ������ �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��մϴ�.
-- �����ε����� ������ ���� ������ �������� �ε����� �����մϴ�.  (�տ� ���̳ʽ��θ��� �ݴ��)
select substr('good morning john' ,8,4 )from dual;
select substr('abcdefg',1,1)from dual;
select substr(first_name,1,1)from dual;
select rpad('ellen',5,'*')from dual;
--lenght() ���ڿ� Ȥ�� �÷��� ���̸� ��ȯ�Ѵ�.
-- ���� ��
select first_name,
    rpad(substr(first_name,1,1), length(first_name), '*') "����ŷ" 
    from employees;



--trim() : ������ �����Ҷ� ����Ѵ�.
-- �ɼ�   trim([leading | trailing | both] �����ҹ��� from �÷���)
--leading : ���ʿ��� ������
--trailing : �����ʿ��� ������
--both : ���ʿ��� ������. �������� ������ both�� ����Ʈ
--  ���� : ���ʿ� ���ڸ� ���ŵǰ� �߰��� �ִ� ���ڴ� ���ŵ����ʽ��ϴ�.
--         ���ڸ� ������ �� �ְ� '���ڿ�'�� ������ �� �����ϴ�. �����߻�
--         �߰��� ���ڴ� ������ �� ����, ������ ���ڸ� ������ �� �ִ�.

select ' ���������׽�Ʈ' trim1,
        trim(' ���������׽�Ʈ ')trim2,  -- ���ʰ������� 
        trim('��' from '�ٶ��㰡 ������ ž�ϴ�')trim3,  -- both �����̱⶧���� ���� �� ����
        trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�')trim4,  -- 3�� ����
        trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�')trim5, -- ���� ���ڿ��� �� ����
        trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�')trim6 from dual;  -- ������ ���ڿ��� �� ����
--      trim(trailing '�ٶ���' from '�ٶ��㰡 ������ ž�ϴ�')trim6 from dual;  -- ���ڿ����Ŵ� �Ұ��� ���ڸ� ����!!
        
--ltrim() rtrim() : ����, ���� ���� Ȥ�� ���ڿ��� ������ �� ����մϴ�.
--trim �� ���ڿ� ���� �Ұ��������� lrtrim�� ���� Ȥ�� ���ڿ� ���ŵ� �����ϴ�.
--�¿��� ���ڿ����� ������ ������ ���ڿ��� �¾Ƶ� ���ŵ��� �ʴ´�. 
-- ���ڿ��� �¿������� ������ ������Ѵ�.
-- ���ڿ� �߰��� ���ŵ����ʴ´�.
select ltrim(' ������������ '),-- ������ �ִ� ���鸸 ����
       ltrim(' ������������ ','����')trim1,
       ltrim(' ������������','����')trim2,
       ltrim('������������ ','����')trim3,
       rtrim(' ������������','����')trim4,
       rtrim(' ������������','����')trim5 from dual;

--substrb() ���ڿ��� ����Ʈ(byte) ������ �߶�
-- ���� : substrb(���ڿ�, ������ġ, ����)
select substrb('�ȳ��ϼ���',1,4) from dual;  -- �����ڵ� �ϳ��� 4byte�̱� ������ '��' �� �߶󳽰�  ���ϼ���???
--                                                    4����Ʈ���� ���    
select substrb('JONES',2,4) from dual;
-- substrb �� ���۸����� Ȯ�� ## �ʿ��ϴٸ� @@



--replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�� �� ����մϴ�
-- ���� �������� ���ڿ��� ��ü�Ѵٸ� ���ڿ��� �����Ǵ� ����� �˴ϴ�. 
-- replace( �÷� Ȥ�� ���ڿ� , '���� �� ���� ', '���� �� ����')
-- trim ltrim rtrim �Լ��� ����� replace �Լ� �ϳ��� ��ü�� �� �����Ƿ� trim�Լ��� ���� replace�Լ��� �� ���� ����
select replace('good morning sun', 'morning', 'evening') from dual;  --���ڿ� ���� 
select replace('good morning sun','sun','') from dual; --  ������ ���ڿ��� ''��.�� ���� ��������

select trim('   good morning sun   ') ���� from dual; --trim �� ������ ���鸸 ���ŵȴ�.
select replace('   good morning sun   ',' ','') ���� from dual; ---  ���ڿ� ���� ��� ���� ����

-- 102�� ����� ���ڵ带 ������� ���ڿ� ������ �غ���.
select first_name, last_name,
    ltrim(first_name,'L')����L����,
    rtrim(first_name,'ex')����ex����,
    replace(last_name,' ', '')����������,
    replace(last_name,'De', 'Dea')��ǥ�⺯�� from employees where employee_id =102;

-- instr() : �ش� ���ڿ����� Ư�����ڰ� ��ġ�� �ε������� ��ȯ 
--  (�÷���, 'ã������')   ���ڿ��� ó������ ���ڸ� ã�´�
-- (�÷���, 'ã������' ,�˻����� �ε���)
-- (�÷���, 'ã������',Ž�������� �ε��� ,'���° ����') 
-- Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� �ִ� �������� ������ ���ִ�.
--Ž���� ������ �ε����� ������ ��� �������� �������� ã�Եȴ�. 

--n�� �߰ߵ� ù��° �ε��� ��ȯ 
select instr('good morning john', 'h') from dual;

select instr('good morning john', 'h',1,2) from dual;

select instr('good morning john', 'h',8, 1) from dual;






