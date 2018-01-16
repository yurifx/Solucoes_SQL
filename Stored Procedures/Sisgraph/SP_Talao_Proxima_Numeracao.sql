USE [pc_sisfrota]
GO

/****** Object:  StoredProcedure [dbo].[tal_alt_proxima_numeracao]    Script Date: 02/20/2015 08:07:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[tal_alt_proxima_numeracao] (@dt_base smalldatetime, @nr_incremento smallint = 1)
as
begin
	declare @nr_controle int
	
	update  tal_numeracao
	set		nr_controle = nr_controle + @nr_incremento,
			@nr_controle = nr_controle + @nr_incremento
	where	dt_base = @dt_base

	if @@rowcount = 0
	begin
		set @nr_controle = 1
		insert tal_numeracao(id, dt_base, nr_controle)
			select isnull(max(id), 0) + 1, @dt_base, @nr_controle from tal_numeracao
	end
	select nr_controle from tal_numeracao where dt_base = @dt_base
end
GO

