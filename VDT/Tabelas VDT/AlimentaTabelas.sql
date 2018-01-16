-- Alimentação inicial das tabelas de suporte

Declare @Cliente_Alianz_ID  Int
      , @Cliente_Renault_ID Int

--------------------------------------------------------------------------------
-- Cliente - Clientes
--------------------------------------------------------------------------------
Insert Into Cliente ( Nome ) Values ('Alianz');
Set @Cliente_Alianz_ID = SCOPE_IDENTITY();

Insert Into Cliente ( Nome ) Values ('Renault');
Set @Cliente_Renault_ID = SCOPE_IDENTITY();


--------------------------------------------------------------------------------
-- Marca - Marcas
--------------------------------------------------------------------------------
Insert Into Marca ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID,  'GM'      );
Insert Into Marca ( Cliente_ID, Nome ) Values ( @Cliente_Renault_ID, 'Renault' );

Select * From Marca;

--------------------------------------------------------------------------------
-- Modelo - Modelos
--------------------------------------------------------------------------------
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Cobalt' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Cruze' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Cruze Sport6' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Onix' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Onix Activ' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Prisma' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Spin Activ' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Spin' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Onix Joy' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Prisma Joy' );

Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Captiva' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Trailblazer' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Tracker' );

Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'Montaba' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'S10 Cabine Dupla' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'S10 High Country' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'S10 Chassi' );
Insert Into Modelo ( Cliente_ID, Nome ) Values ( @Cliente_Alianz_ID, 'S10 Cabine Simples' );

Select * From Modelo;

--------------------------------------------------------------------------------
-- AvArea - Áreas
--------------------------------------------------------------------------------
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '01' , 'Antena'                                     , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '02' , 'Bateria'                                    , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '03' , 'Parachoque'                                 , 'Dianteiro'                 , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '04' , 'Parachoque'                                 , 'Traseiro'                  , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '05' , 'Caixa de Ar'                                , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '06' , 'Caixa de Ar'                                , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '07' , 'Caixa de Ar'                                , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '08' , 'Caixa de Ar'                                , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '09' , 'Caçamba (Interior)'                         , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '10' , 'Porta'                                      , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '11' , 'Porta'                                      , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '12' , 'Porta'                                      , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '13' , 'Porta'                                      , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '14' , 'Paralama'                                   , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '15' , 'Lateral'                                    , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '16' , 'Paralama'                                   , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '17' , 'Lateral'                                    , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '18' , 'Lanterna'                                   , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '19' , 'Lanterna'                                   , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '20' , 'Parabrisa '                                 , 'Dianteiro'                 , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '21' , 'Vidro'                                      , 'Traseiro'                  , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '22' , 'Grade Frontal (radiador)'                   , 'Dianteiro'                 , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '23' , 'Suporte Fixaçao Farois'                     , 'Dianteiro'                 , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '24' , 'Farol'                                      , 'Dianteiro'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '25' , 'Farol '                                     , 'Dianteiro'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '26' , 'Farol de Neblina'                           , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '27' , 'Capô'                                       , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '28' , 'Chave Principal'                            , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '29' , 'Chave Reserva'                              , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '30' , 'Retrovisor Externo'                         , NULL                        , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '31' , 'Retrovisor Externo'                         , NULL                        , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '32' , 'Radio'                                      , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '33' , 'Soleira'                                    , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '34' , 'Soleira'                                    , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '35' , 'Soleira'                                    , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '36' , 'Soleira'                                    , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '37' , 'Teto'                                       , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '38' , 'Estribo'                                    , ''                          , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '39' , 'Estribo'                                    , ''                          , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '40' , 'Estepe'                                     , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '41' , 'Maçaneta Porta'                             , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '42' , 'Maçaneta Porta'                             , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '43' , 'Maçaneta Porta'                             , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '44' , 'Maçaneta Porta'                             , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '45' , 'Chave de roda'                              , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '46' , 'Cartão de memória'                          , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '47' , 'Tapetes'                                    , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '48' , 'Retrovisor Intero'                          , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '50' , 'Tanque Combustível'                         , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '52' , 'Tampa Porta-malas'                          , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '53' , 'Teto Solar'                                 , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '54' , 'Limpador Para-brisa'                        , 'Dianteiro'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '55' , 'Limpador Para-brisa'                        , 'Dianteiro'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '56' , 'Limpador Vidro'                             , 'Traseiro'                  , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '57' , 'Santo Antônio'                              , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '58' , 'Auto-falantes'                              , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '59' , 'Capota Conversível'                         , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '60' , 'Calota'                                     , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '61' , 'Calota'                                     , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '62' , 'Calota'                                     , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '63' , 'Calota'                                     , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '64' , 'Aerofolio'                                  , 'Traseira'                  , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '65' , 'Bagageiro'                                  , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '66' , 'Painel de Intrumentos'                      , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '67' , 'Carpete'                                    , 'Dianteiro'                 , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '68' , 'Carpete'                                    , 'Traseiro'                  , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '69' , 'Coluna'                                     , 'Central'                   , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '70' , 'Coluna'                                     , 'Central'                   , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '71' , 'Coluna'                                     , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '72' , 'Coluna'                                     , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '73' , 'Coluna'                                     , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '74' , 'Coluna'                                     , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '75' , 'Macaco'                                     , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '76' , 'Infocard'                                   , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '77' , 'Chave de fenda'                             , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '78' , 'Parafusos fixação da placa'                 , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '79' , 'Triângulo'                                  , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '80' , 'Manual'                                     , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '81' , 'Tampa do Tanque'                            , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '82' , 'Pneu'                                       , 'Dianteiro'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '83' , 'Pneu'                                       , 'Traseiro'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '84' , 'Pneu'                                       , 'Dianteiro'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '85' , 'Pneu'                                       , 'Traseiro'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '86' , 'Roda'                                       , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '87' , 'Roda'                                       , 'Traseirt'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '88' , 'Roda'                                       , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '89' , 'Roda'                                       , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '90' , 'Capota marítima'                            , NULL                        , NULL );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '91' , 'Sistema de Escapamento'                     , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '92' , 'Painel Fixaçao Placa'                       , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '93' , 'Sistema Suspensao'                          , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '94' , 'Banco'                                      , 'Dianteiro'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '95' , 'Banco'                                      , 'Dianteiro'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '96' , 'Banco'                                      , 'Traseiro'                  , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '97' , 'Acendedor de cigarros'                      , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '98' , 'Break Light'                                , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '99' , 'Compartimento do Motor'                     , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '100', 'Friso da Porta'                             , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '101', 'Friso da Porta'                             , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '102', 'Friso da Porta'                             , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '103', 'Friso da Porta'                             , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '104', 'Vidro da Porta'                             , 'Dianteira'                 , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '105', 'Vidro da Porta'                             , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '106', 'Vidro da Porta'                             , 'Dianteira'                 , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '107', 'Vidro da Porta'                             , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '108', 'Vidro fixo da Porta'                        , 'Traseira'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '109', 'Vidro fixo da Porta'                        , 'Traseira'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '110', 'Vidro Fixo'                                 , 'Traseiro'                  , 'Esquerdo' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '111', 'Vidro Fixo'                                 , 'Traseiro'                  , 'Direito' );
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '112', 'Maçaneta da tampa'                          , 'Traseira'                  , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '113', 'Encosto de cabeça'                          , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '114', 'Extintor'                                   , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '115', 'Forro do teto'                              , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '116', 'Kit Multimidia'                             , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '117', 'Tampa da caixa de fusíveis'                 , NULL                        , NULL);
Insert Into AvArea ( Cliente_ID, Codigo, Area_Pt, Local_Pt, Lado_Pt ) Values ( @Cliente_Alianz_ID, '118', 'Volante'                                    , NULL                        , NULL);

Select * From AvArea;

--------------------------------------------------------------------------------
-- AvDano - Tipos de Danos
--------------------------------------------------------------------------------
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '01', 'Pintura Trincada' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '02', 'Quebrado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '03', 'Cortado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '04', 'Amassado c/ Pintura Danificada' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '05', 'Lascado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '06', 'Risco sem mudança de cor' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '07', 'Risco com mudança de cor' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '08', 'Faltante' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '09', 'Raspado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '10', 'Furado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '11', 'Rachado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '12', 'Rasgado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '13', 'Amassado s/ Pintura Danificada' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '14', 'Borda Lascada' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '15', 'Metal exposto corrosão' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '16', 'Molhado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '17', 'Fluído Derramado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '18', 'Mancha' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '19', 'Pintura Áspera' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '20', 'Solto / Mal montado (Necessidade de Ferramenta)' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '21', 'Reparo mal executado' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '22', 'Desplacamento' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '23', 'Tinta escorrida' );
Insert Into AvDano ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '24', 'Parte incorreta ou opção não faturada' );

Select * From AvDano;

--------------------------------------------------------------------------------
-- AvSeveridade - Graus de severidade
--------------------------------------------------------------------------------
Insert Into AvSeveridade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '1', 'Zero à 2mm' );
Insert Into AvSeveridade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '2', 'Acima de 2mm à 4mm' );
Insert Into AvSeveridade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '3', 'Acima de 4mm à 5mm' );
Insert Into AvSeveridade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '4', 'Acima de 5mm à 10mm' );
Insert Into AvSeveridade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '5', 'Acima de 10mm' );
Insert Into AvSeveridade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '6', 'Faltante' );

Select * From AvSeveridade;

--------------------------------------------------------------------------------
-- AvQuadrante - Quadrantes
--------------------------------------------------------------------------------
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '1', 'Esquerda Superior' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '2', 'Centro Superior' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '3', 'Direita Superior' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '4', 'Esquerda' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '5', 'Centro' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '6', 'Direita' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '7', 'Esquerda Inferior' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '8', 'Centro Inferior' );
Insert Into AvQuadrante ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, '9', 'Direita Inferior' );

Select * From AvQuadrante;

--------------------------------------------------------------------------------
-- AvGravidade - Graus de gravidade
--------------------------------------------------------------------------------
Insert Into AvGravidade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, 'S', 'Superficial' );
Insert Into AvGravidade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, 'Y', 'Leve' );
Insert Into AvGravidade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, 'Z', 'Moderado' );
Insert Into AvGravidade ( Cliente_ID, Codigo, Nome_Pt ) Values ( @Cliente_Alianz_ID, 'W', 'Grave' );

Select * From AvGravidade;

--------------------------------------------------------------------------------
-- AvCondicao - Condições das inspeções
--------------------------------------------------------------------------------
Insert Into AvCondicao ( Codigo, Nome_Pt ) Values ( '1', 'Inspeção diurna' );
Insert Into AvCondicao ( Codigo, Nome_Pt ) Values ( '2', 'Inspeção diurna c/chuva' );
Insert Into AvCondicao ( Codigo, Nome_Pt ) Values ( '3', 'Inspeção Noturna' );
Insert Into AvCondicao ( Codigo, Nome_Pt ) Values ( '4', 'Inspeção Noturna c/chuva' );
Insert Into AvCondicao ( Codigo, Nome_Pt ) Values ( '5', 'Veículo sujo' );

Select * From AvCondicao;

--------------------------------------------------------------------------------
-- Local - Locais de inspeção Rio Grande, Santos, Guarujá, São Sebastião, Suape, etc.
--------------------------------------------------------------------------------

Declare @Local_RioGrande_ID    Int
      , @Local_Santos_ID       Int
      , @Local_Guaruja_ID      Int
      , @Local_SaoSebastiao_ID Int
      , @Local_Suape_ID        Int

Insert Into LocalInspecao( Nome ) Values ( 'Rio Grande' );
Set @Local_RioGrande_ID = SCOPE_IDENTITY();

Insert Into LocalInspecao ( Nome ) Values ( 'Santos' );
Set @Local_Santos_ID = SCOPE_IDENTITY();

Insert Into LocalInspecao ( Nome ) Values ( 'Guarujá' );
Set @Local_Guaruja_ID = SCOPE_IDENTITY();

Insert Into LocalInspecao ( Nome ) Values ( 'São Sebastião' );
Set @Local_SaoSebastiao_ID = SCOPE_IDENTITY();

Insert Into LocalInspecao ( Nome ) Values ( 'Suape' );
Set @Local_Suape_ID = SCOPE_IDENTITY();

Select * From LocalInspecao;

--------------------------------------------------------------------------------
-- CheckPoint - Entrada Porto, Subida Navio, Descida Navio, Saída Porto, etc.
--------------------------------------------------------------------------------
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_RioGrande_ID   , '1' , 'Descida Navio - RIG'        , 'Vessel Discharge - RIG'       , 'I' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_RioGrande_ID   , '2' , 'Saida Porto - RIG'          , 'Leaving Port Yard - RIG'      , 'I' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_RioGrande_ID   , '3' , 'Entrada Porto - RIG'        , 'Entry Port - RIG'             , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_RioGrande_ID   , '4' , 'Subida Navio - RIG'         , 'Vessel Loading - RIG'         , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Santos_ID      , '5' , 'Entrada Deicmar - SSZ'      , 'Entry Deicmar - SSZ'          , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Santos_ID      , '6' , 'Subida Navio Deicmar - SSZ' , 'Vessel Loading Deicmar - SSZ' , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Santos_ID      , '7' , 'Entrada Rodrimar - SSZ'     , 'Entry Rodrimar - SSZ'         , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Santos_ID      , '8' , 'Subida Navio Rodrimar - SSZ', 'Vessel Loading Rodrimar - SSZ', 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Guaruja_ID     , '9' , 'Entrada TEV - GJA'          , 'Entry TEV - GJA'              , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Guaruja_ID     , '10', 'Subida Navio TEV - GJA'     , 'Vessel Loading TEV - GJA'     , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_SaoSebastiao_ID, '11', 'Entrada Porto - SSO'        , 'Entry Puerto - SSO'           , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_SaoSebastiao_ID, '12', 'Subida Navio - SSO'         , 'Vessel Loading - SSO'         , 'E' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_SaoSebastiao_ID, '13', 'Descida Navio - SSO'        , 'Vessel Discharge - SSO'       , 'I' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_SaoSebastiao_ID, '14', 'Saída Porto - SSO'          , 'Leaving Port - SSO'           , 'I' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Suape_ID       , '15', 'Descida Navio - SUA'        , 'Vessel Discharge - SUA'       , 'I' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Suape_ID       , '16', 'Entrada Patio PPV - SUA'    , 'Entry Yard PPV - SUA'         , 'I' );
Insert Into LocalCheckPoint ( LocalInspecao_ID, Codigo, Nome_Pt, Nome_En, Operacao ) Values ( @Local_Suape_ID       , '17', 'Saida Patio PPV - SUA'      , 'Leaving Yard PPV - SUA'       , 'I' );
GO
Select * From LocalCheckPoint;

--------------------------------------------------------------------------------
-- Transportador - Tabela de transportadores marítimos e terrestres
--------------------------------------------------------------------------------
Insert Into Transportador ( Nome, Tipo ) Values ( 'Transp. Terreste Teste 1' , 'T' );
Insert Into Transportador ( Nome, Tipo ) Values ( 'Transp. Terreste Teste 2' , 'T' );
Insert Into Transportador ( Nome, Tipo ) Values ( 'Transp. Terreste Teste 3' , 'T' );

Insert Into Transportador ( Nome, Tipo ) Values ( 'Transp. Marítimo Teste 1' , 'M' );
Insert Into Transportador ( Nome, Tipo ) Values ( 'Transp. Marítimo Teste 2' , 'M' );
Insert Into Transportador ( Nome, Tipo ) Values ( 'Transp. Marítimo Teste 3' , 'M' );
GO
Select * From Transportador;

-- FIM
