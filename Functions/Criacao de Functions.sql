USE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[CDP_GetApplicationSetting] (
	@P_Setting nvarchar(50), 
	@P_User nvarchar(100) = null, 
	@P_Client char(2) = null)
returns nvarchar(4000)
as
begin
	declare @Value nvarchar(4000);

-- User specific setting
	set @Value = (select max(APS_Value)
	from CDP_ApplicationSettings
	inner join CDP_Users on US_Id = APS_US_Id
	where APS_Name = @P_Setting
	  and US_NTLM_Id = @P_User);

-- Role specific setting
	if @Value is null
		set @Value = (select max(APS_Value)
		from CDP_ApplicationSettings
		inner join CDP_UserRoles on UR_RL_Id = APS_RL_Id
		inner join CDP_Users on US_Id = UR_US_Id
		where APS_Name = @P_Setting
			and US_NTLM_Id = @P_User);

-- Client specific setting
	if @Value is null
		set @Value = (select max(APS_Value)
		from CDP_ApplicationSettings
		inner join CDP_ClientClasses on CL_Id = APS_CL_Id
		where APS_Name = @P_Setting
			and CL_Code = @P_Client);

-- General Setting
	if @Value is null
		set @Value = (select max(APS_Value)
		from CDP_ApplicationSettings
		where APS_Name = @P_Setting
			and APS_US_Id is null
			and APS_RL_Id is null
			and APS_CL_Id is null);
			
  return @Value;
end
