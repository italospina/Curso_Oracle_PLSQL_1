--
-- Seção 15 - Funções de Banco de Dados
--
-- Aula 1 - Criando Funções de Banco de Dados
--
/*
Funções e procedures servem propósitos diferentes.

Uma função, pensando na sua definição matemática, é usada normalmente para calcular um valor com base num determinado input. Uma função não permite alterações fora do seu "scope" (escopo), isto é, não pode ser utilizada para alterar o estado global da base de dados (por exemplo, através das instruções INSERT, UPDATE, DELETE).

As funções podem ser incorporada directamente numa instrução de SQL caso retornem um valor escalar

SELECT udf_DiaSemana(data_hoje) 
Ou podem ser usadas numa junção caso retornem uma tabela

SELECT t1.Var1, f1.Var2
FROM tbl_tabela1 t1
INNER JOIN udf_Exemplo(parametro) f1
   ON f1.Var1 = t1.Var1
Por seu lado, as procedures podem ser vistas como programas/scripts (se fizermos uma analogia com uma qualquer linguagem de programação). Uma procedure permite alterar o estado global da base de dados (por exemplo, a utilização das instruções INSERT, UPDATE, DELETE). Procedures são utilizadas normalmente para juntar várias queries numa única transacção.

Pequenas diferenças entre os dois conceitos:

Podemos executar uma função a partir de uma procedure, mas não podemos fazer o inverso.

Podemos usar funções em conjunto com as instruções SELECT, WHERE, HAVING mas não é possível fazer o mesmo com procedures.

Procedures permitem efectuar o tratamento de excepções, via try/catch. Já o mesmo não é possível numa função.
*/
-- Criando Funções de Banco de Dados

CREATE OR REPLACE FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO
  (pemployee_id   IN NUMBER)
   RETURN NUMBER
IS 
  vSalary  employees.salary%TYPE;
BEGIN
  SELECT salary
  INTO   vsalary
  FROM   employees
  WHERE employee_id = pemployee_id;
  RETURN (vsalary);
EXCEPTION
  WHEN NO_DATA_FOUND THEN 
    RAISE_APPLICATION_ERROR(-20001, 'Empregado inexistente');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || ' - ' || SQLERRM);
END;

-- Executando a Função pelo Bloco PL/SQL

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite o Id do empregado: '
DECLARE
  vEmployee_id  employees.employee_id%TYPE := &pemployee_id;
  vSalary       employees.salary%TYPE;
BEGIN
  vsalary := FNC_CONSULTA_SALARIO_EMPREGADO(vEmployee_id);
  DBMS_OUTPUT.PUT_LINE('Salario: ' || vsalary);
END;