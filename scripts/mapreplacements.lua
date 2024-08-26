
local replacers = {
	{
		nodes = {
			[minetest.get_content_id 'default:dirt'] = true,
			[minetest.get_content_id 'default:dirt_with_grass'] = true,
			[minetest.get_content_id 'default:dry_dirt'] = true,
			[minetest.get_content_id 'always_greener:dry_dirt_with_grass'] = true,
			[minetest.get_content_id 'always_greener:dirt_with_dead_grass'] = true,
			[minetest.get_content_id 'always_greener:dry_dirt_with_dead_grass'] = true,
			[minetest.get_content_id 'default:dirt_with_coniferous_litter'] = true,
			[minetest.get_content_id 'default:dirt_with_rainforest_litter'] = true,
			[minetest.get_content_id 'default:dirt_with_snow'] = true
		},
		distance = {1.5, 1},
		adjacents = {
			'default:water_source',
			'default:water_flowing',
			'default:river_water_source',
			'default:river_water_flowing'
		},
		replacements = {
			[minetest.get_content_id 'default:dirt'] = minetest.get_content_id 'always_greener:mud',
			[minetest.get_content_id 'default:dry_dirt'] = minetest.get_content_id 'always_greener:mud',
			minetest.get_content_id 'always_greener:mud',
			minetest.get_content_id 'always_greener:mud_with_grass'
		}
	}
}

local air = minetest.get_content_id 'air'

minetest.register_on_generated(function(vm, minp, maxp, blockseed)
	local dat = vm: get_data()
	local p2dat = vm: get_param2_data()
	
	local min, max = vm: get_emerged_area()
	local area = VoxelArea(min, max)
	
	local repd_indices = {}
	
	for i = 1, #replacers do
		local replacer = replacers[i]
		for index in area: iterp(min, max) do
			if (not repd_indices[index]) and ((not replacer.air_above) or (area: containsi(index + area.ystride) and dat[index + area.ystride] == air)) then
				local pos = area: position(index)
				if replacer.nodes[dat[index]] then
					local adjacent = minetest.find_node_near(pos, replacer.distance[1] + replacer.distance[2], replacer.adjacents)
					if adjacent then
						local dist = pos: distance(adjacent)
						if dist <= replacer.distance[1] + (math.random() * replacer.distance[2]) then
							dat[index] = replacer.replacements[dat[index]] or replacer.replacements[math.random(1, #replacer.replacements)]
							repd_indices[index] = true
						end
					end
				end
			end
		end
	end
	
	vm: set_data(dat)
	vm: set_param2_data(p2dat)
end)
