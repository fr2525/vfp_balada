'***************************************************************************************
'***************************   CRIA A TABELA DE ANIMAIS   ******************************
'***************************************************************************************
'                              
strsql = "CREATE TABLE tab_animais  (ID integer NOT NULL
								, Id_Cli integer NOT NULL
								, Nome  character(50) NOT NULL
								, Tipo_ani Int not null
								, dt_nasc date
								, pedigree CHAR(1)
								, observacoes varchar(200)
								, cuidados_especiais varchar(100)
								, foto varchar(100)
								, dt_ult_visita date
								, operador character(10)
								, dt_Atualiza timestamp
								, primary key (ID) )"
Cnn.Execute strsql
Cnn.CommitTrans
        
'cria GENERATOR
strsql = "CREATE GENERATOR GEN_ANI_ID1 "
Cnn.Execute strsql
Cnn.CommitTrans

strsql = "SET GENERATOR GEN_ANI_ID1 TO 0"
Cnn.Execute strsql
Cnn.CommitTrans

strsql = " CREATE TRIGGER TAB_ANIMAIS_BI FOR TAB_ANIMAIS ACTIVE BEFORE INSERT POSITION 0 AS BEGIN "
strsql = strsql & "if (NEW.ID is NULL) then NEW.ID = GEN_ID(GEN_ANI_ID1, 1); END; "
Cnn.Execute strsql
Cnn.CommitTrans


'****************************************************************************************
'****************   CRIA A TABELA DE TIPOS DE ANIMAL (CÃO/GATO/COELHO)  *****************
'****************************************************************************************
'                              
strsql = "CREATE TABLE tab_tipos_an (ID integer NOT NULL
								, Descricao character(50) NOT NULL
								, operador character(10)
								, dt_Atualiza timestamp
								, primary key (ID) )"
Cnn.Execute strsql
Cnn.CommitTrans
        
'cria GENERATOR
strsql = "CREATE GENERATOR GEN_TPA_ID1 "
Cnn.Execute strsql
Cnn.CommitTrans

strsql = "SET GENERATOR GEN_TPA_ID1 TO 0"
Cnn.Execute strsql
Cnn.CommitTrans

strsql = " CREATE TRIGGER TAB_TIPOS_AN_BI FOR TAB_TIPOS_AN ACTIVE BEFORE INSERT POSITION 0 AS BEGIN "
strsql = strsql & "if (NEW.ID is NULL) then NEW.ID = GEN_ID(GEN_TPA_ID1, 1); END; "
Cnn.Execute strsql
Cnn.CommitTrans

'****************************************************************************************
'*****************  CRIA A TABELA DE SERVICOS - BANHO/TOSA/VACINAS/ETC  *****************
'****************************************************************************************
'                              
strsql = "CREATE TABLE tab_servicos (ID integer NOT NULL
								, Descricao character(50) NOT NULL
								, valor NUMERIC(12,2)
								, TEMPO_EST NUMERIC(12,2)
								, vacina CHAR(1)
								, operador character(10)
								, dt_Atualiza timestamp
								, primary key (ID) )"
Cnn.Execute strsql
Cnn.CommitTrans
        
'cria GENERATOR
strsql = "CREATE GENERATOR GEN_SERV_ID1 "
Cnn.Execute strsql
Cnn.CommitTrans

strsql = "SET GENERATOR GEN_SERV_ID1 TO 0"
Cnn.Execute strsql
Cnn.CommitTrans

strsql = " CREATE TRIGGER TAB_SERVICOS_BI FOR TAB_SERVICOS ACTIVE BEFORE INSERT POSITION 0 AS BEGIN "
strsql = strsql & "if (NEW.ID is NULL) then NEW.ID = GEN_ID(GEN_SERV_ID1, 1); END; "
Cnn.Execute strsql
Cnn.CommitTrans

'****************************************************************************************
'********************    CRIA A TABELA DE ATENDIMENTOS    *******************************
'****************************************************************************************
'                              
strsql = "CREATE TABLE tab_atendimentos (Dt_atend timestamp NOT NULL" & _ 
									", IdAnimal integer NOT NULL" & _ 
									", Tipo_Atend integer NOT NULL" & _ 
									', valor NUMERIC(12,2)" & _ 
									", valor_recebido NUMERIC(12,2)" & _ 
									", hora_saida CHAR(5)" & _ 
									", observa varCHAR(150)" & _ 
									', operador char(10)" & _ 
									", dt_Atualiza timestamp" & _ 
									", primary key (dt_atend) )"
Cnn.Execute strsql
Cnn.CommitTrans
        
'Não tem auto incremento porque o campo chave é TIMESTAMP


'****************************************************************************************
'********************       CRIA A TABELA DE VACINAS      *******************************
'****************************************************************************************
'                              
strsql = "CREATE TABLE tab_vacinas (ID integer NOT NULL " & _ 
								",IdAnimal integer NOT NULL " & _ 
								",Dt_atend timestamp NOT NULL " & _ 
								",Descricao VARCHAR(100) NOT NULL " & _ 
								",valor NUMERIC(12,2) " & _ 
								",DT_PROXIMA DATE " & _ 
								",operador character(10) " & _ 
								",dt_Atualiza timestamp " & _ 
								",primary key (id)  )"
Cnn.Execute strsql
Cnn.CommitTrans
        
'cria GENERATOR
strsql = "CREATE GENERATOR GEN_TVAC_ID1 "
Cnn.Execute strsql
Cnn.CommitTrans

strsql = "SET GENERATOR GEN_TVAC_ID1 TO 0"
Cnn.Execute strsql
Cnn.CommitTrans

strsql = " CREATE TRIGGER TAB_VACINAS_BI FOR TAB_VACINAS ACTIVE BEFORE INSERT POSITION 0 AS BEGIN "
strsql = strsql & "if (NEW.ID is NULL) then NEW.ID = GEN_ID(GEN_TVAC_ID1, 1); END; "
Cnn.Execute strsql
Cnn.CommitTrans


'****************************************************************************************
'********************       CRIA A TABELA DE PROMOCOES      *******************************
'****************************************************************************************
'                              
strsql = "CREATE TABLE tab_promocoes (ID integer NOT NULL" & _  
								  ",Dt_inicio timestamp  NOT NULL" & _ 
								  ",Dt_fim timestamp NOT NULL" & _ 
								  ",IdAnimal integer" & _ 
								  ",IdTipoAten integer" & _ 
								  ",Descricao VARCHAR(100) NOT NULL" & _ 
								  ",Valor NUMERIC(12,2)" & _ 
								  ",porcent NUMERIC(2,2)" & _ 
								  ",operador character(10)" & _ 
								  ",Dt_Atualiza timestamp" & _ 
								  ",primary key (ID)  )
/*
Cnn.Execute strsql
Cnn.CommitTrans

'cria GENERATOR
strsql = "CREATE GENERATOR GEN_TPRO_ID1 "
Cnn.Execute strsql
Cnn.CommitTrans

strsql = "SET GENERATOR GEN_TPRO_ID1 TO 0"
Cnn.Execute strsql
Cnn.CommitTrans

strsql = " CREATE TRIGGER TAB_PROMOCOES_BI FOR TAB_PROMOCOES ACTIVE BEFORE INSERT POSITION 0 AS BEGIN "
strsql = strsql & "if (NEW.ID is NULL) then NEW.ID = GEN_ID(GEN_TPRO_ID1, 1); END; "
Cnn.Execute strsql
Cnn.CommitTrans
*/



