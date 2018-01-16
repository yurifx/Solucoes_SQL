USE [pc_sisfrota]
GO

/****** Object:  View [dbo].[VW_VIATURAS_POR_USUARIOS]    Script Date: 02/20/2015 08:06:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_VIATURAS_POR_USUARIOS]
AS
SELECT     SU.SEG02_RG AS RG, SU.SEG02_NOME AS NOME, BV.BAS69_CodViatura, BV.BAS09_Unidade, BV.BAS08_Delegacia, BV.BAS09_Divisao, BV.BAS69_Patrimonio, 
                      BV.BAS69_Caracterizada, BV.BAS69_Radio, BV.BAS69_Combustivel, BV.BAS69_Grupo, BV.BAS69_AnoFab, BV.BAS64_VeicMarca, BV.BAS64_VeicModelo, 
                      BV.BAS39_VeicCor, BV.BAS69_RENAVAM, BV.BAS69_RadioPatrimonio, BV.BAS69_Computador, BV.BAS69_GPS, BV.BAS69_Camera, BV.BAS69_OutrosEquipamentos, 
                      BV.BAS69_Chassi, BV.BAS69_Placas, BV.BAS69_Cidade, BV.BAS69_UF, BV.BAS69_PlacasRes, BV.BAS69_CidadeDel, BV.BAS69_UF1, BV.BAS69_Situacao, 
                      BV.BAS69_Observacao, BV.BAS69_DataInc, BV.BAS69_UsuarioInc, BV.BAS69_IPMaquinaInc, BV.BAS69_DataAtualiza, BV.BAS69_UsuarioAtualiza, 
                      BV.BAS69_IPMaquinaAtualiza, BV.cod_siap, BV.tempSiap, BV.BAS69_KMAtual
FROM         dbo.bas69_viaturas AS BV INNER JOIN
                      dbo.seg02_usuario AS SU ON SU.SEG02_NIVEL = 2 AND CHARINDEX(BV.BAS08_Delegacia, SU.BAS08_DIVISAO) > 0 AND CHARINDEX(BV.BAS09_Divisao, 
                      SU.BAS08_DELEGACIA) > 0 AND CHARINDEX(BV.BAS09_Unidade, SU.BAS09_UNIDADE) > 0 OR
                      SU.SEG02_NIVEL = 3 AND CHARINDEX(BV.BAS08_Delegacia, SU.BAS08_DIVISAO) > 0 AND CHARINDEX(BV.BAS09_Divisao, SU.BAS08_DELEGACIA) > 0 OR
                      SU.SEG02_NIVEL = 4 AND CHARINDEX(BV.BAS09_Divisao, SU.BAS08_DELEGACIA) > 0 OR
                      SU.SEG02_NIVEL = 5

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[70] 4[9] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "BV"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 33
         End
         Begin Table = "SU"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_VIATURAS_POR_USUARIOS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_VIATURAS_POR_USUARIOS'
GO

