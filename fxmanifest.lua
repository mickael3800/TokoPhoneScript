fx_version 'cerulean'
game 'gta5'

author 'Mickaël Papineau'
description 'Admin commands for TokoVoip'
version '1.0.0-Alpha'

client_scripts {
    'client/main.lua',
    'client/function.lua',
    'config.lua'
}

server_scripts {
    'server/main.lua',
    'server/function.lua',
    'config.lua'
}

dependencies {
	'tokovoip_script'
}
