
minetest.unregister_item 'default:dirt_with_dry_grass'
minetest.unregister_item 'default:dry_dirt_with_dry_grass'

minetest.register_alias('default:dirt_with_dry_grass', '')
minetest.register_alias('default:dry_dirt_with_dry_grass', 'always_greener:dry_dirt_with_grass')

local function get_biome_color(heat, humid)
	local heat = math.floor((math.max(0, math.min(heat, 100)) / 100) * 16)
	local humid = math.floor((math.max(0, math.min(humid, 100)) / 100) * 16)
	
	return (16 * humid) + heat
end

local function grass_after_place (pos, placer, itemstack, pointed_thing)
	if placer: get_player_control().sneak then
		local node = minetest.get_node(pos)
		
		node.param2 = 136
		minetest.set_node(pos, node)
		
		return
	end
	
	local biomedat = minetest.get_biome_data(pos)

	local node = minetest.get_node(pos)
	
	node.param2 = get_biome_color(biomedat.heat, biomedat.humidity)
	minetest.set_node(pos, node)
end

etc.smart_override_item('default:dirt', {groups = {dirt = 1}})
etc.smart_override_item('default:dry_dirt', {groups = {dirt = 1}})
etc.smart_override_item('default:dirt_with_coniferous_litter', {groups = {dirt = 1}})
etc.smart_override_item('default:dirt_with_rainforest_litter', {groups = {dirt = 1}})
etc.smart_override_item('default:dirt_with_snow', {groups = {dirt = 1}})
etc.smart_override_item('default:sand', {groups = {sand = 1}})
etc.smart_override_item('default:silver_sand', {groups = {sand = 1}})
etc.smart_override_item('default:desert_sand', {groups = {sand = 1}})
etc.smart_override_item('default:gravel', {groups = {gravel = 1}})

minetest.override_item('default:dirt_with_grass', {
	tiles = {
		{name = 'awg_grass.png'},
		{name = 'default_dirt.png', color = 'white'},
		{name = 'default_dirt.png', color = 'white'}
	},
	overlay_tiles = {
		'',
		'',
		{name = 'awg_grass_side.png'}
	},
	use_texture_alpha = 'blend',
	paramtype2 = 'color',
	color = '#4AA432',
	palette = 'awg_grass_colormap.png',
	after_place_node = grass_after_place
})

awg: inherit_item('default:dirt_with_grass', 'dry_dirt_with_grass', {
	displayname = 'Savanna Dirt with Grass',
	description = '',
	tiles = {
		'awg_grass.png',
		{name = 'default_dry_dirt.png', color = 'white'},
		{name = 'default_dry_dirt.png', color = 'white'}
	},
	groups = {crumbly = 3, soil = 1},
	drop = 'default:dry_dirt'
})

awg: inherit_item('default:dirt_with_grass', 'dirt_with_dead_grass', {
	displayname = 'Dirt with Dead Grass',
	description = '',
	groups = {crumbly = 3, soil = 1},
	palette = 'awg_dead_grass_colormap.png',
	color = '#594a28'
})

awg: inherit_item('always_greener:dry_dirt_with_grass', 'dry_dirt_with_dead_grass', {
	displayname = 'Savanna Dirt with Dead Grass',
	description = '',
	groups = {crumbly = 3, soil = 1},
	palette = 'awg_dead_grass_colormap.png',
	color = '#594a28'
})

local caught = 0

for i, abm in pairs(minetest.registered_abms) do
	if caught == 2 then break end
	
	if abm.label == 'Grass covered' then
		caught = caught + 1
		
		abm.action = function(pos, node)
			local above = pos + vector.new(0, 1, 0)
			local name = minetest.get_node(above).name
			local def = minetest.registered_nodes[name]
			if name ~= 'ignore' and def and not (def.sunlight_propagates or def.paramtype == 'light') then
				local biomedat = minetest.get_biome_data(pos)
				
				if node.name == 'always_greener:dry_dirt_with_grass' then
					minetest.set_node(pos, {name = 'always_greener:dry_dirt_with_dead_grass', param2 = get_biome_color(biomedat.heat, biomedat.humidity)})
				else
					minetest.set_node(pos, {name = 'always_greener:dirt_with_dead_grass', param2 = get_biome_color(biomedat.heat, biomedat.humidity)})
				end
			end
		end
	end
	
	if abm.label == 'Grass spread' then
		caught = caught + 1
		
		abm.action = function(pos, node)
			local above = pos + vector.new(0, 1, 0)
			if (minetest.get_node_light(above) or 0) < 13 then return end
			
			local biomedat = minetest.get_biome_data(pos)
			
			local pos2 = minetest.find_node_near(pos, 1, 'group:spreading_dirt_type')
			if pos2 then
				local near_node = minetest.get_node(pos2)
				near_node.param2 = get_biome_color(biomedat.heat, biomedat.humidity)
				minetest.set_node(pos, near_node)
				return
			end

			local name = minetest.get_node(above).name
			if name == 'default:snow' then
				minetest.set_node(pos, {name = 'default:dirt_with_snow'})
			elseif minetest.get_item_group(name, 'grass') + minetest.get_item_group(name, 'dry_grass') ~= 0 then
				minetest.set_node(pos, {name = 'default:dirt_with_grass', param2 = get_biome_color(biomedat.heat, biomedat.humidity)})
			end
		end
	end
end

minetest.register_decoration({
	deco_type = 'simple',
	decoration = 'default:dirt_with_grass',
	place_on = {'default:dirt_with_rainforest_litter', 'default:dirt_with_coniferous_litter'},
	place_offset_y = -1,
	sidelen = 4,
	noise_params = {
		offset = -1.5,
		scale = 1.5,
		spread = {x = 200, y = 200, z = 200},
		seed = 241,
		octaves = 4,
		persist = 1.0
	},
	y_max = 31000,
	y_min = 1,
	flags = 'force_placement'
})

local function tallgrass_after_place (pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node(pos)
	node.param2 = math.random(0, 239)
	minetest.swap_node(pos, node)
end

for i = 1, 5 do
	minetest.override_item('default:dry_grass_'..i, {
		drawtype = 'mesh',
		mesh = 'awg_grass.obj',
		tiles = {'awg_grass_'..i..'.png'},
		inventory_image = 'awg_dry_grass_inv.png',
		paramtype2 = 'degrotate',
		color = '#d0c256',
		after_place_node = tallgrass_after_place,
		on_place = i == 1 and function(itemstack, placer, pointed_thing)
			local newstack = minetest.item_place(ItemStack('default:dry_grass_' .. math.random(1,7)), placer, pointed_thing)
			return ItemStack('default:dry_grass_1 ' .. itemstack:get_count() - (1 - newstack: get_count()))
		end or nil
	}, {'wield_image'})
end

for i = 1, 5 do
	minetest.override_item('default:grass_'..i, {
		drawtype = 'mesh',
		mesh = 'awg_grass.obj',
		tiles = {'awg_grass_'..i..'.png'},
		inventory_image = 'awg_grass_inv.png',
		paramtype2 = 'degrotate',
		color = '#82a433',
		after_place_node = tallgrass_after_place,
		on_place = i == 1 and function(itemstack, placer, pointed_thing)
			local newstack = minetest.item_place(ItemStack('default:grass_' .. math.random(1,7)), placer, pointed_thing)
			return ItemStack('default:grass_1 ' .. itemstack:get_count() - (1 - newstack: get_count()))
		end or nil
	}, {'wield_image'})
end

awg: inherit_item('default:grass_5', 'grass_6', {
	description = '',
	mesh = 'awg_grass_2.obj',
	tiles = {'awg_grass_6.png'}
})
minetest.register_alias('default:grass_6', 'always_greener:grass_6')

awg: inherit_item('default:grass_5', 'grass_7', {
	description = '',
	mesh = 'awg_grass_2.obj',
	tiles = {'awg_grass_7.png'}
})
minetest.register_alias('default:grass_7', 'always_greener:grass_7')

awg: inherit_item('default:dry_grass_5', 'dry_grass_6', {
	description = '',
	mesh = 'awg_grass_2.obj',
	tiles = {'awg_grass_6.png'}
})
minetest.register_alias('default:dry_grass_6', 'always_greener:dry_grass_6')

awg: inherit_item('default:dry_grass_5', 'dry_grass_7', {
	description = '',
	mesh = 'awg_grass_2.obj',
	tiles = {'awg_grass_7.png'}
})
minetest.register_alias('default:dry_grass_7', 'always_greener:dry_grass_7')

minetest.register_decoration({
	name = 'default:grass_6',
	deco_type = 'simple',
	place_on = {'default:dirt_with_grass'},
	sidelen = 16,
	noise_params = {
		offset = -0.045,
		scale = 0.1,
		spread = {x = 200, y = 200, z = 200},
		seed = 209,
		octaves = 3,
		persist = 0.6
	},
	biomes = {'grassland', 'deciduous_forest'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:grass_6',
	param2 = 0,
	param2_max = 239
})

minetest.register_decoration({
	name = 'default:grass_7',
	deco_type = 'simple',
	place_on = {'default:dirt_with_grass'},
	sidelen = 16,
	noise_params = {
		offset = -0.05,
		scale = 0.12,
		spread = {x = 200, y = 200, z = 200},
		seed = 44,
		octaves = 3,
		persist = 0.6
	},
	biomes = {'grassland', 'deciduous_forest'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:grass_7',
	param2 = 0,
	param2_max = 239
})

minetest.register_decoration({
	name = 'default:grass_3_2',
	deco_type = 'simple',
	place_on = {'default:dirt_with_grass'},
	sidelen = 16,
	fill_ratio = 0.75,
	biomes = {'grassland'},
	y_max = 31000,
	y_min = 1,
	decoration = 'default:grass_3',
	param2 = 0,
	param2_max = 239
})

minetest.register_decoration({
	name = 'default:dry_grass_6',
	deco_type = 'simple',
	place_on = {'always_greener:dry_dirt_with_grass'},
	sidelen = 16,
	noise_params = {
		offset = -0.045,
		scale = 0.1,
		spread = {x = 200, y = 200, z = 200},
		seed = 329,
		octaves = 3,
		persist = 0.6
	},
	biomes = {'savanna'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:dry_grass_6',
	param2 = 0,
	param2_max = 239
})

minetest.register_decoration({
	name = 'default:dry_grass_7',
	deco_type = 'simple',
	place_on = {'always_greener:dry_dirt_with_grass'},
	sidelen = 16,
	noise_params = {
		offset = -0.05,
		scale = 0.12,
		spread = {x = 200, y = 200, z = 200},
		seed = 812,
		octaves = 3,
		persist = 0.6
	},
	biomes = {'savanna'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:dry_grass_7',
	param2 = 0,
	param2_max = 239
})

minetest.register_decoration({
	name = 'default:dry_grass_3_2',
	deco_type = 'simple',
	place_on = {'always_greener:dry_dirt_with_grass'},
	sidelen = 16,
	fill_ratio = 0.75,
	biomes = {'savanna'},
	y_max = 31000,
	y_min = 1,
	decoration = 'default:dry_grass_3',
	param2 = 0,
	param2_max = 239
})

minetest.override_item('default:junglegrass', {
	drawtype = 'mesh',
	mesh = 'awg_jungle_grass.obj',
	tiles = {'awg_jungle_grass.png'},
	inventory_image = 'awg_jungle_grass_inv.png',
	paramtype2 = 'degrotate',
	visual_scale = 1,
	after_place_node = tallgrass_after_place
}, {'wield_image'})

awg: inherit_item('default:junglegrass', 'jungle_grass_flowering', {
	tiles = {'awg_jungle_grass_flower.png'},
	displayname = 'Flowering Jungle Grass',
	description = '',
	drop = 'always_greener:jungle_grass_flowering',
	inventory_image = 'awg_jungle_grass_flower_inv.png'
})

minetest.register_decoration({
	name = 'default:junglegrass_flowering',
	deco_type = 'simple',
	place_on = {'default:dirt_with_rainforest_litter'},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {'rainforest'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:jungle_grass_flowering',
	param2 = 0,
	param2_max = 239
})

awg: inherit_item('default:junglegrass', 'jungle_grass_short', {
	tiles = {'awg_jungle_grass_short.png'},
	groups = {not_in_creative_inventory = 1},
	drop = 'default:junglegrass',
	description = ''
})

minetest.register_decoration({
	name = 'default:junglegrass_short',
	deco_type = 'simple',
	place_on = {'default:dirt_with_rainforest_litter'},
	sidelen = 80,
	fill_ratio = 0.25,
	biomes = {'rainforest'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:jungle_grass_short',
	param2 = 0,
	param2_max = 239
})
