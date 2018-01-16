--------------------------------------------------------------------------------
-- tbConfig.sql
-- Data   : 14/08/2013
-- Autor  : Amauri
-- Criar a tabela de configuração
--------------------------------------------------------------------------------

Create Table Config ( 
  PastaCS28           Varchar(512),
  PastaCS48           Varchar(512),
  PastaCS13           Varchar(512),
  PastaCS47           Varchar(512),
  PastaCS25           Varchar(512),
  PastaBA01           Varchar(512),
  PastaPP37_Carga     Varchar(512),
  PastaPP37_Cadastro  Varchar(512),
  PastaPP86           Varchar(512),
  PastaPP28           Varchar(512),          
  PastaBR67_FS1       Varchar(512),                         
  PastaBR67_FS3       Varchar(512),                 
  PastaBR66_FS22      Varchar(512),                
  PastaBR66_FS23      Varchar(512),
  
  CaminhoArqFmt       Varchar(512),
  
  PastaArqsLidos      Varchar(512),
  PastaArqsErros      Varchar(512),
  
  MaxLinhasErros      Int  ) -- Quantidade máxima permitida de linhas com erros
  
  -- Servidor            Varchar(30),     -- Precisaremos ?
  -- UserId              Varchar(30),     -- Precisaremos ?
  -- Password            Varchar(30) );   -- Precisaremos ?
  
GO

Insert Into Config ( PastaCS28,
                     PastaCS48,
                     PastaCS13,
                     PastaCS47,
                     PastaCS25,
                     PastaBA01,
                     PastaPP37_Carga,
                     PastaPP37_Cadastro,
                     PastaPP86,
                     PastaPP28,          
                     PastaBR67_FS1,                         
                     PastaBR67_FS3,                 
                     PastaBR66_FS22,                
                     PastaBR66_FS23,
                     PastaBA01,
  
                     CaminhoArqFmt,
                     
                     PastaArqsLidos,
                     PastaArqsErros,
                     
                     MaxLinhasErros )
  
                     --Servidor,
                     --UserId,
                     --Password );
                     
                     
                     
            Values ( 'C:\Tmp\ArqsAvon\CS28',                                
                     'C:\Tmp\ArqsAvon\CS48',            
                     'C:\Tmp\ArqsAvon\CS13',            
                     'C:\Tmp\ArqsAvon\CS47',            
                     'C:\Tmp\ArqsAvon\CS25',            
                     'C:\Tmp\ArqsAvon\BA01',            
                     'C:\Tmp\ArqsAvon\PP37_Carga',      
                     'C:\Tmp\ArqsAvon\PP37_Cadastro',   
                     'C:\Tmp\ArqsAvon\PP86',            
                     'C:\Tmp\ArqsAvon\PP28',            
                     'C:\Tmp\ArqsAvon\BR67_FS1',        
                     'C:\Tmp\ArqsAvon\BR67_FS3',        
                     'C:\Tmp\ArqsAvon\BR66_FS22',       
                     'C:\Tmp\ArqsAvon\BR66_FS23',
                     
                     'C:\Tmp\ArqsAvon\Fmt\Formatacao.fmt',
                     
                     'C:\Tmp\ArqsAvon\Lidos',
                     'C:\Tmp\ArqsAvon\Erros',
                     
                     10 );  -- MaxLinhasErros

GO

-- FIM
                            

