USE [pc_sisfrota]
GO

/****** Object:  StoredProcedure [dbo].[EncerrarTalao]    Script Date: 02/20/2015 08:06:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[EncerrarTalao] (@CodTalao int, @DataEncerramento datetime, @KmFinal int, @Ocorrencias varchar, @Status int output)
as
begin
	set @Status = 0;
	update  vtr06_talaoaberto
	set		VTR06_DataEncerramento = @DataEncerramento,
			VTR06_KmFinal = @KmFinal,
			VTR06_Ocorrencias = @Ocorrencias
	where	VTR06_CodTalao = @CodTalao

	if @@rowcount = 1
	begin
		INSERT INTO vtr06_talao
			SELECT * FROM vtr06_talaoaberto 
			WHERE VTR06_CodTalao = @CodTalao;
		
		if @@rowcount = 1
		begin
			DELETE FROM vtr06_talaoaberto 
				WHERE VTR06_CodTalao = @CodTalao;
		end
		
		if @@rowcount = 1
			set @Status = 1;
	end
	return @Status;
end

GO

