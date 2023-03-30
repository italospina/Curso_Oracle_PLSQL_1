--
-- Seção 17 - Gerenciando Dependências de Objetos
--
-- Aula 1 - Gerenciando Dependências de Objetos
--
/*
Sempre que foi alterado um objeto do banco de dados que dependem diretamente ou indiretamente serão invalidados
       Direta: procedure ou funcao faz referencia ao bloco plsql
       Indireta: Referencia um objeto intermediaroo que faz referencia ao bloco plsql
       Local: Objeto que referencia outro objeto do mesmmo banco de dados
       Remota: Objeto referencia objeto em outro banco atraves de um database link
Apos alteracoes fazer analise se houve impacto

*/
-- Gerenciando Dependências de Objetos

-- Consultando Dependencias Diretas dos objetos do seu schema utilizando a visão USER_DEPENDENCIES 

DESC user_dependencies

SELECT *
FROM   user_dependencies
WHERE  referenced_name = 'EMPLOYEES' AND
       referenced_type = 'TABLE';
       
-- Consultando Dependencias Diretas e Indiretas dos objetos do seu schema utilizando a visão USER_DEPENDENCIES 
-- Consulta hierarquica

SELECT      *
FROM        user_dependencies
START WITH  referenced_name = 'EMPLOYEES' AND
            referenced_type = 'TABLE'
CONNECT BY PRIOR  name = referenced_name AND
                  type = referenced_type;
                  

-- Consultando Dependencias Diretas e Indiretas dos objetos de todos schemas utilizando a visão DBA_DEPENDENCIES        

-- Conecte-se como SYS

DESC DBA_DEPENDENCIES

SELECT      *
FROM        dba_dependencies
START WITH  referenced_owner = 'HR' AND
            referenced_name = 'EMPLOYEES' AND
            referenced_type = 'TABLE'
CONNECT BY PRIOR  owner = referenced_owner AND
                  name =  referenced_name   AND
                  type =  referenced_type;
                  
-- Consultando objetos Inválidos do schema do seu usuário 

DESC USER_OBJECTS

SELECT object_name, object_type, last_ddl_time, timestamp, status
FROM   user_objects
WHERE  status = 'INVALID';




