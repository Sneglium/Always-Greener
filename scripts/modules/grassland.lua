
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
		offset = -0.9,
		scale = 0.9,
		spread = {x = 110, y = 110, z = 110},
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

awg: register_node('field_mushroom_1', {
	displayname = 'Field Mushroom',
	tiles = {'awg_field_mushroom_top.png', 'awg_field_mushroom_top.png', 'awg_field_mushroom_side.png'},
	inventory_image = 'awg_field_mushroom_inv.png',
	drawtype = 'nodebox',
	use_texture_alpha = 'clip',
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0463855, -0.5, -0.0463855, 0.0463855, -0.364458, 0.0463855},
			{-0.106024, -0.404217, -0.112651, 0.106024, -0.230422, 0.112651}
		}
	},
	groups = {mushroom = 1, snappy = 2, flammable = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function (pos, placer, itemstack, pointed_thing)
		local node = minetest.get_node(pos)
		node.name = 'always_greener:field_mushroom_' .. math.random(1, 3)
		minetest.swap_node(pos, node)
	end,
	on_use = minetest.item_eat(1)
})

awg: inherit_item('always_greener:field_mushroom_1', 'field_mushroom_2', {
	description = '',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.13253, -0.516867, 0.205422, -0.039759, -0.357831, 0.311446},
			{-0.178916, -0.443976, 0.165663, 0.0066265, -0.28494, 0.351205},
			{0.271687, -0.516867, -0.39759, 0.404217, -0.357831, -0.26506},
			{-0.145783, -0.523494, -0.245181, -0.026506, -0.404217, -0.125904}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.13253, -0.516867, 0.205422, -0.039759, -0.357831, 0.311446},
			{-0.178916, -0.443976, 0.165663, 0.0066265, -0.28494, 0.351205},
			{0.271687, -0.516867, -0.39759, 0.404217, -0.357831, -0.26506},
			{-0.145783, -0.523494, -0.245181, -0.026506, -0.404217, -0.125904}
		}
	},
	drop = 'always_greener:field_mushroom_1',
	groups = {not_in_creative_inventory = 1}
})

awg: inherit_item('always_greener:field_mushroom_1', 'field_mushroom_3', {
	description = '',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.291566, -0.5, -0.357831, -0.185542, -0.377711, -0.238554},
			{-0.351205, -0.385843, -0.41747, -0.125904, -0.212048, -0.178916},
			{0.0861446, -0.5, 0.26506, 0.192169, -0.377711, 0.384337},
			{0.0596386, -0.41747, 0.245181, 0.218675, -0.278313, 0.404217}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.291566, -0.5, -0.357831, -0.185542, -0.377711, -0.238554},
			{-0.351205, -0.385843, -0.41747, -0.125904, -0.212048, -0.178916},
			{0.0861446, -0.5, 0.26506, 0.192169, -0.377711, 0.384337},
			{0.0596386, -0.41747, 0.245181, 0.218675, -0.278313, 0.404217}
		}
	},
	drop = 'always_greener:field_mushroom_1',
	groups = {not_in_creative_inventory = 1}
})

minetest.register_decoration({
	name = 'always_greener:field_mushroom_1',
	deco_type = 'simple',
	place_on = {'default:dirt_with_grass'},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.003,
		spread = {x = 250, y = 250, z = 250},
		seed = 9,
		octaves = 3,
		persist = 0.66
	},
	biomes = {'grassland'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:field_mushroom_1',
})

minetest.register_decoration({
	name = 'always_greener:field_mushroom_2',
	deco_type = 'simple',
	place_on = {'default:dirt_with_grass'},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.003,
		spread = {x = 250, y = 250, z = 250},
		seed = 3,
		octaves = 3,
		persist = 0.66
	},
	biomes = {'grassland'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:field_mushroom_2',
})

minetest.register_decoration({
	name = 'always_greener:field_mushroom_3',
	deco_type = 'simple',
	place_on = {'default:dirt_with_grass'},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.003,
		spread = {x = 250, y = 250, z = 250},
		seed = 14,
		octaves = 3,
		persist = 0.66
	},
	biomes = {'grassland'},
	y_max = 31000,
	y_min = 1,
	decoration = 'always_greener:field_mushroom_3',
})
