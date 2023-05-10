# Work repos
function rysis { cd "$ENV:maindir\Rysis\" }
function rysisGit { rysis; cd "Git\" }

### CHRONODESK
function chrono { rysisGit; cd "chronodesk\rysis-chronolog\" }
function chronoApi { chrono; cd "Timesheet_API\" }
function chronoWeb { chrono; cd "Timesheet_Web\ClientApp\" }
function chronoSql { chrono; cd "Timesheet_Midtier\SqlProxyClassGen\" }

### VISIBILL
function visibill { rysisGit; cd "visibill\visibill-4\" }
function visibillApi { visibill; cd "Visibill_API" }
function visibillWeb { visibill; cd "VisibillWeb\ClientApp" }
function visibillSql { visibill; cd "Visibill_Midtier\SqlProxyClassGen\" }

### DRIVERISK
function optix { rysisGit; cd "driverisk" }

### VELOCITY
function velo { optix; cd "rysis-driverisk2\" }
function veloApi { velo; cd "DriveRisk.Api" }
function veloWeb { velo; cd "DriveRisk.Drops\ClientApp\" }
function veloSql { velo; cd "DriveRisk.Midtier\SqlProxyClassGen\" }

### DRIVERISK LEGACY
function drive { optix; cd "rysis-driverisk\" }
function driveReports { drive; cd "DriveRisk.Consolidated.Report\DriveRisk.Consolidated.Report" }
function drops { drive; cd "DriveRisk.Drops.WebApp\" }

### DRIVERISK ADMIN
function driveAdmin { optix; cd "driverisk-admin" }
function driveApi { driveAdmin; cd "DriveRisk.Admin.Api" }
function driveWeb { driveAdmin; cd "DriveRisk.Admin.Webapp" }
function driveSql { driveAdmin; cd "DriveRisk.Admin.Midtier\ProxyGeneration" }

### DRIVERISK SERVICES
function driveService { optix; cd "driverisk-services\" }
function driveDispatch { driveService; cd "DriveRisk.DriverDispatch" }
function driveEW { driveService; cd "DriveRisk.EarlyWarning.SoapMonitoring\" }
function driveVS {  driveService; cd "DriveRisk.DriverDispatch\DriveRisk.VelocityServices" }

### SAHCS
function sahiv { rysisGit; cd "rysis-sahiv" }
function sahivWebsite { sahiv; cd "Website\" }
function sahivApi { sahivWebsite; cd "SahivV3_Api" }
function sahivSql { sahivWebsite; cd "Sahiv.Midtier2\Bat2\" }
function sahivWeb { sahivWebsite; cd "SahivV3_Angular\ClientApp" }

### ATRAX
function atrax { rysisGit; cd "rysis-atrax2\" }
function atraxApi { atrax; "Operational System\Atrax.Api" }
function atraxWeb { atrax; cd "Operational System\Atrax.Webapp\ClientApp\" }
function atraxSql { atrax; cd "Operational System\Atrax.Midtier\SqlProxyClassGen\" }

### EXEC MOBILE
function exec { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile" }
function execApi { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile\ExecMobile.Api" }
function execWeb { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile\ExecMobile.Web\ClientApp" }
function execSql { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile\ExecMobile.Sql\SqlScripts" }

### PRESS COUNCIL
function press { cd "D:\Rysis\Git\rysis-pressombudsman\" }
function pressSql { cd "D:\Rysis\Git\rysis-pressombudsman\PressOmbudsman.Midtier\Bat2\" }
# complaints
function pressCom { cd "D:\Rysis\Git\rysis-pressombudsman\ComplaintsManagement\" }
function pressComWeb { cd "D:\Rysis\Git\rysis-pressombudsman\ComplaintsManagement\ComplaintsManagement.Web\ClientApp" }
function pressComApi { cd "D:\Rysis\Git\rysis-pressombudsman\ComplaintsManagement\ComplaintsManagement.Api" }

### PERSONAL DIR
function omoiDev { cd "D:\nhlan\Desktop\Development" }
function omoiGit { cd "D:\nhlan\Desktop\Development\Git" }
function omoiSite { cd "D:\nhlan\Desktop\Development\Git\portfolio" }
