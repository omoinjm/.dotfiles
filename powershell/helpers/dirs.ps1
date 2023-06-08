# Work repos
function r_git { rysis; cd "Git\" }
function rysis { cd "$env:maindir\Rysis\" }

### CHRONODESK
function chrono { r_git; cd "chronodesk\rysis-chronolog\" }
function c_api { chrono; cd "Timesheet_API\" }
function c_web { chrono; cd "Timesheet_Web\ClientApp\" }
function c_sql { chrono; cd "Timesheet_Midtier\SqlProxyClassGen\" }

### VISIBILL
function visibill { r_git; cd "visibill\" }

function v4 { visibill; cd "visibill-4\" }
function v_api { v4; cd "Visibill_API\" }
function v_web { v4; cd "VisibillWeb\ClientApp\" }
function v_sql { v4; cd "Visibill_Midtier\SqlProxyClassGen\" }

function v_admin { visibill; cd "visibill-admin\" }
function v_admin_api { v_admin; cd "Visibill.Admin.Api\" }
function v_admin_web { v_admin; cd "Visibill.Admin.Webapp\" }
function v_admin_sql { v_admin; cd "Visibill.Admin.Midtier\SqlProxyClassGen\" }

function v_svc { visibill; cd "visibill-services\" }

### DRIVERISK
function optix { r_git; cd "driverisk\" }

### VELOCITY
function velo { optix; cd "rysis-driverisk2\" }
function velo_api { velo; cd "DriveRisk.Api\" }
function velo_web { velo; cd "DriveRisk.Drops\ClientApp\" }
function velo_sql { velo; cd "DriveRisk.Midtier\SqlProxyClassGen\" }

### DRIVERISK LEGACY
function drive { optix; cd "rysis-driverisk\" }
function drops { drive; cd "DriveRisk.Drops.WebApp\" }
function d_reports { drive; cd "DriveRisk.Consolidated.Report\DriveRisk.Consolidated.Report\" }

### DRIVERISK ADMIN
function d_admin { optix; cd "driverisk-admin\" }
function d_api { d_admin; cd "DriveRisk.Admin.Api\" }
function d_web { d_admin; cd "DriveRisk.Admin.Webapp\" }
function d_sql { d_admin; cd "DriveRisk.Admin.Midtier\ProxyGeneration\" }

### DRIVERISK SERVICES
function d_svc { optix; cd "driverisk-services\" }
function d_dispatch { d_svc; cd "DriveRisk.DriverDispatch\" }
function d_ew { d_svc; cd "DriveRisk.EarlyWarning.SoapMonitoring\" }
function d_vs {  d_svc; cd "DriveRisk.DriverDispatch\DriveRisk.VelocityServices\" }

### DRIVERISK LYTX
function d_lytx { optix; cd "driverisk-lytx\" }

### DRIVERISK TELEMATICS
function d_telematics { optix; cd "driverisk-telematics\" }

### DRIVERISK Mail Engine
function d_mail { optix; cd "driverisk-mail" }

### SAHCS
function sahiv { r_git; cd "rysis-sahiv\" }
function s_website { sahiv; cd "Website\" }
function s_mvc { s_website; cd "SahivV2.MVC\" }
function s_api { s_website; cd "SahivV3_Api\" }
function s_sql { s_website; cd "Sahiv.Midtier2\Bat2\" }
function s_web { s_website; cd "SahivV3_Angular\ClientApp\" }

### ATRAX
function atrax { r_git; cd "rysis-atrax2\" }
function a_api { atrax; "Operational System\Atrax.Api\" }
function a_web { atrax; cd "Operational System\Atrax.Webapp\ClientApp\" }
function a_sql { atrax; cd "Operational System\Atrax.Midtier\SqlProxyClassGen\" }

### EXEC MOBILE
function exec { r_git; cd "rysis-execmobile\ExecMobile\" }
function e_api { exec; cd "ExecMobile.Api\" }
function e_web { exec; cd "ExecMobile.Web\ClientApp\" }
function e_sql { exec; cd "ExecMobile.Sql\SqlScripts\" }

### PRESS COUNCIL
function press { r_git; cd "rysis-pressombudsman\" }
function p_sql { press; cd "PressOmbudsman.Midtier\Bat2\" }
# complaints
function p_com { press; cd "ComplaintsManagement\" }
function p_com_api { p_com; cd "ComplaintsManagement.Api\" }
function p_com_web { p_com; cd "ComplaintsManagement.Web\ClientApp\" }

### PERSONAL DIR
function o_dev { cd "C:\Users\nhlan\Desktop\Development" }
function o_git { o_dev; cd "Git\" }
function o_site { o_git; cd "portfolio\" }
