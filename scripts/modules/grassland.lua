
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
	groups = {plant = 1, snappy = 2, oddly_breakable_by_hand = 3, flammable = 1},
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
