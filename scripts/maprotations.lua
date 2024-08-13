
local grassnodes = {
	[minetest.get_content_id 'default:grass_1'] = true,
	[minetest.get_content_id 'default:grass_2'] = true,
	[minetest.get_content_id 'default:grass_3'] = true,
	[minetest.get_content_id 'default:grass_4'] = true,
	[minetest.get_content_id 'default:grass_5'] = true,
	
	[minetest.get_content_id 'default:dry_grass_1'] = true,
	[minetest.get_content_id 'default:dry_grass_2'] = true,
	[minetest.get_content_id 'default:dry_grass_3'] = true,
	[minetest.get_content_id 'default:dry_grass_4'] = true,
	[minetest.get_content_id 'default:dry_grass_5'] = true
}

minetest.register_on_generated(function(vm, minp, maxp, blockseed)
	local dat = vm: get_data()
	local p2dat = vm: get_param2_data()
	
	local min, max = vm: get_emerged_area()
	local area = VoxelArea(min, max)
	
	for index in area: iterp(min, max) do
		if grassnodes[dat[index]] then
			p2dat[index] = math.random(0, 239)
		end
	end
	
	vm: set_data(dat)
	vm: set_param2_data(p2dat)
end)
