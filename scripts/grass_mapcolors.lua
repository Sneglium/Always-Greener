
local grassnodes = {
	[minetest.get_content_id 'default:dirt_with_grass'] = true,
	[minetest.get_content_id 'always_greener:dry_dirt_with_grass'] = true
}

local function get_biome_color(pos)
	local biomedat = minetest.get_biome_data(pos)
	local heat = math.floor((math.max(0, math.min(biomedat.heat, 100)) / 100) * 16)
	local humidity = math.floor((math.max(0, math.min(biomedat.humidity, 100)) / 100) * 16)
	
	return (16 * humidity) + heat
end

minetest.register_on_generated(function(vm, minp, maxp, blockseed)
	local dat = vm: get_data()
	local p2dat = vm: get_param2_data()
	
	local min, max = vm: get_emerged_area()
	local area = VoxelArea(min, max)
	
	for index in area: iterp(min, max) do
		if grassnodes[dat[index]] then
			p2dat[index] = get_biome_color(area: position(index))
		end
	end
	
	vm: set_data(dat)
	vm: set_param2_data(p2dat)
end)
