
awg: register_node('sage', {
	displayname = 'Sage',
	tiles = {'awg_sage.png'},
	inventory_image = 'awg_sage_inv.png',
	drawtype = 'plantlike',
	paramtype2 = 'meshoptions',
	place_param2 = 42,
	visual_scale = 1.5,
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	selection_box = {
		type = 'fixed',
		fixed = {-0.35, -0.5, -0.35, 0.35, 0.5, 0.35}
	},
	groups = {plant = 1, flower = 1, snappy = 2, flammable = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_decoration({
	deco_type = 'simple',
	decoration = 'always_greener:sage',
	place_on = {'default:dirt_with_grass'},
	biomes = {'grassland'},
	sidelen = 4,
	noise_params = {
		offset = -1.1,
		scale = 1.9,
		spread = {x = 120, y = 120, z = 120},
		seed = 241,
		octaves = 3,
		persist = 1.0
	},
	y_max = 31000,
	y_min = 1,
	param2 = 42
})

local function plant_after_place (pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node(pos)
	node.param2 = math.random(0, 239)
	minetest.swap_node(pos, node)
end

awg: register_node('clover', {
	displayname = 'Clover',
	tiles = {'awg_clover.png'},
	inventory_image = 'awg_clover_inv.png',
	drawtype = 'mesh',
	mesh = 'awg_clover.obj',
	use_texture_alpha = 'clip',
	paramtype2 = 'degrotate',
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	selection_box = {
		type = 'fixed',
		fixed = {-0.4, -0.5, -0.4, 0.4, -0.4, 0.4}
	},
	groups = {plant = 1, snappy = 2, flammable = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = plant_after_place
})

awg: register_node('clover_flower', {
	displayname = 'Flowering Clover',
	tiles = {'awg_clover_flower.png'},
	inventory_image = 'awg_clover_flower_inv.png',
	drawtype = 'mesh',
	mesh = 'awg_clover.obj',
	use_texture_alpha = 'clip',
	paramtype2 = 'degrotate',
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	selection_box = {
		type = 'fixed',
		fixed = {-0.4, -0.5, -0.4, 0.4, -0.4, 0.4}
	},
	groups = {plant = 1, snappy = 2, flammable = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = plant_after_place
})

minetest.register_decoration({
	deco_type = 'simple',
	decoration = 'always_greener:clover',
	place_on = {'default:dirt_with_grass'},
	biomes = {'grassland'},
	sidelen = 8,
	noise_params = {
		offset = 0.02,
		scale = 0.15,
		spread = {x = 140, y = 140, z = 140},
		seed = 604,
		octaves = 3,
		persist = 0.6
	},
	y_max = 31000,
	y_min = 1,
	param2 = 0,
	param2_max = 239
})

minetest.register_decoration({
	deco_type = 'simple',
	decoration = 'always_greener:clover_flower',
	place_on = {'default:dirt_with_grass'},
	biomes = {'grassland'},
	sidelen = 8,
	noise_params = {
		offset = -0.02,
		scale = 0.15,
		spread = {x = 140, y = 140, z = 140},
		seed = 604,
		octaves = 3,
		persist = 0.6
	},
	y_max = 31000,
	y_min = 1,
	param2 = 0,
	param2_max = 239
})
