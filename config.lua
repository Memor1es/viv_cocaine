  
Config = {}

Config.Locale = 'en'

Config.Delays = {
	CocaProcessing = 1000 * 10
}

Config.LicenseEnable = true -- Enable processing licenses? The player will be required to buy a license in order to process cocaine. Requires esx_license

Config.LicensePrices = {
	coca_processing = {label = _U('license_coca'), price = 12000}
}

Config.GiveBlack = true -- Give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	CocaField = {coords = vector3(310.91, 4290.87, 45.15), name = _U('blip_cocafield'), color = 25, sprite = 496, radius = 100.0},
	CocaProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = _U('blip_cocaprocessing'), color = 25, sprite = 496, radius = 100.0}
}