-- This library allow for easily delayed/timed actions
require('libraries/autoload/timers')

-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
--require('libraries/autoload/physics')

-- This library can be used for advanced 3D projectile systems.
--require('libraries/autoload/projectiles')

-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/autoload/notifications')

-- This library can be used for starting customized animations on units from lua
require('libraries/autoload/animations')

-- This library can be used for performing "Frankenstein" attachments on units
--require('libraries/autoload/attachments')

-- This library can be used to synchronize client-server data via player/client-specific nettables
require('libraries/autoload/playertables')

-- This library can be used to create container inventories or container shops
-- require('containers')

-- This library provides a searchable, automatically updating lua API in the tools-mode via "modmaker_api" console command
-- require('modmaker')

-- This library provides an automatic graph construction of path_corner entities within the map
require('libraries/autoload/pathgraph')

-- This library (by Noya) provides player selection inspection and management from server lua
--require('libraries/autoload/selection')

--Сохры
--require("libraries/autoload/saveload")

if GetMapName() == "ascento_rpg" then
	-- Удобные штуки для меня.
	require('libraries/autoload/ascento') 
end

require('libraries/autoload/player_resource')             -- Core lua library
--require('libraries/autoload/player')             -- Core lua library

--require('libraries/autoload/cosmetics') 
require('libraries/autoload/pseudorng') 
--require('libraries/autoload/achievments') 
if GetMapName() == "ascento_rpg" then
	require('libraries/autoload/neutral_slot')
end

