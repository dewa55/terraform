// Resource settings

rg_name     = "aliot-portal-dev-vd"
location    = "North Europe"
environment = "dev"

main_rg_name       = "vdevcic-test"
main_keyvault_name = "kv1-dev-vd"
vnet_name          = "aliot-dev-vdevcic"

cicd_principal_id = "554c981a-9554-47fb-b8b4-3bfffdbafc59"

subnet_name = "aliot-portal-dev-vdevcic"
subnet_cidr = ["10.10.0.0/24"]

appservice_plan          = "aliot-portal-dev-vdevcic"
appservice_plan_sku_tier = "Standard"
appservice_plan_sku_size = "S1"

web_api_name       = "webapidevvd"
web_api_ApiUrl     = "https://aliotdev-vdevcic.azurewebsites.net/"
web_api_ApiUrlTest = "https://aliottest-vdevcic.azurewebsites.net/"


web_ui_name = "webuidevvd"

actiongroup_name = "myactiongroupname2"
actiongroup_shortname = "myagshort2"