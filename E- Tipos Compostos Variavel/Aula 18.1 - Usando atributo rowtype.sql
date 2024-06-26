--
-- Seção 10 - Tipos Compostos - Variável Tipo PL/SQL Record
--
-- Aula 2 - Utilizando atributo %ROWTYPE
--

-- Criando um PL/SQL Record utilizando atributo %ROWTYPE

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite o Id do empregado: '
DECLARE
employee_record   employees%rowtype; --cria o record 
vEmployee_id      employees.employee_id%type := &pemployee_id;--recebe o valor do id do empregado digitado
 
BEGIN
SELECT  * 
INTO    employee_record --chama o record
FROM    employees
WHERE   employee_id = vEmployee_id; --filtra apenas o valor do id digitado
DBMS_OUTPUT.PUT_LINE(employee_record.employee_id || ' - ' || 
                     employee_record.first_name || ' - ' || 
                     employee_record.last_name || ' - ' || 
                     employee_record.phone_number || ' - ' ||
                     employee_record.job_id);
END;