
local grassnodes = {
	[minetest.get_content_id 'default:dirt_with_grass'] = true,
	[minetest.get_content_id 'always_greener:dry_dirt_with_grass'] = true
}

local waternodes = {
	[minetest.get_content_id 'default:water_source'] = true,
	[minetest.get_content_id 'default:river_water_source'] = true,
	[minetest.get_content_id 'default:water_flowing'] = true,
	[minetest.get_content_id 'default:river_water_flowing'] = true
}

local function get_biome_grass_color(pos)
	local biomedat = minetest.get_biome_data(pos)
	
	local heat = biomedat.heat
	local humidity = biomedat.humidity
	
	if pos.y > 90 then
		heat = heat - ((pos.y - 90) * 0.45)
		humidity = humidity - ((pos.y - 90) * 0.2)
	end
	
	local water = minetest.find_node_near(pos, 8, {
		'default:water_source', 'default:river_water_source',
		'default:water_flowing', 'default:river_water_flowing'
	})
	
	if water then
		local dist = pos: distance(water)
		humidity = humidity + (math.max(0, 8 - dist - math.random(0, 1)) * 4.5)
	end
	
	local heat_scaled = math.floor((math.max(0, math.min(heat, 100)) / 100) * 16)
	local humidity_scaled = math.floor((math.max(0, math.min(humidity, 100)) / 100) * 16)
	
	return math.min(255, (16 * humidity_scaled) + math.min(15, heat_scaled))
end

local function get_biome_water_color(pos)
	local biomedat = minetest.get_biome_data(pos)
	
	local heat = biomedat.heat
	local humidity = biomedat.humidity
	
	if pos.y < -15 then
		humidity = math.min(0, humidity + (pos.y * 0.25))
	end
	
	local flowing = minetest.find_node_near(pos, 4, {
		'default:water_flowing', 'default:river_water_flowing'
	})
	
	if flowing then
		local dist = pos: distance(flowing)
		
		if heat > 0 and math.abs(pos.y - flowing.y) < 2 then
			heat = heat - math.max(0, ((5 - dist) * (heat/4)))
		end
		
		if humidity > 0 and math.abs(pos.y - flowing.y) < 2 then
			humidity = humidity - math.max(0, ((5 - dist) * (humidity/4)))
		end
	end
	
	local heat_scaled = math.floor((math.max(0, math.min(heat, 100)) / 100) * 16)
	local humidity_scaled = math.floor((math.max(0, math.min(humidity, 100)) / 100) * 16)
	
	return math.min(255, (16 * humidity_scaled) + math.min(15, heat_scaled))
end

minetest.register_on_generated(function(vm, minp, maxp, blockseed)
	local dat = vm: get_data()
	local p2dat = vm: get_param2_data()
	
	local min, max = vm: get_emerged_area()
	local area = VoxelArea(min, max)
	
	for index in area: iterp(min, max) do
		if grassnodes[dat[index]] then
			p2dat[index] = get_biome_grass_color(area: position(index))
		end
		
		if waternodes[dat[index]] then
			p2dat[index] = get_biome_water_color(area: position(index))
		end
	end
	
	vm: set_data(dat)
	vm: set_param2_data(p2dat)
end)
