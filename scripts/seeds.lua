
local function register_seed (name, inv_img, tile, displayname, description, max_growtime, place_group, grow_func)
	awg: register_node('seed_' .. name, {
		displayname = displayname,
		description = description,
		inventory_image = inv_img,
		wield_image = inv_img,
		tiles = {tile},
		groups = {seed= 1, snappy = 3, attached_node = 1, crop = 1},
		sunlight_propagates = true,
		walkable = false,
		drawtype = 'plantlike',
		paramtype = 'light',
		paramtype2 = 'meshoptions',
		floodadable = true,
		buildable_to = true,
		place_param2 = 41,
		drop = '',
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = 'fixed',
			fixed = {-0.25, -0.5, -0.25, 0.25, -0.25, 0.25}
		},
		on_construct = function (pos)
			minetest.get_node_timer(pos): start(math.random(max_growtime*0.3, max_growtime))
		end,
		on_place = function (itemstack, placer, pointed_thing)
			local stack, pos = minetest.item_place_node(itemstack, placer, pointed_thing)
			
			local node = minetest.get_node(pos - vector.new(0, 1, 0))
			if minetest.get_item_group(node.name, place_group) > 0 then
				return stack
			else
				minetest.set_node(pos, {name = 'air'})
				return nil
			end
		end,
		on_timer = grow_func
	})
end

register_seed(
	'mushroom_brown',
	'awg_mushroom_spores_brown_inv.png',
	'awg_mushroom_spores_brown.png',
	'Brown Mushroom Spores',
	'Grows into brown mushrooms. Plant on soil.',
	500,
	'soil',
	function (pos)
		minetest.set_node(pos, {name = 'flowers:mushroom_brown_'..math.random(1,3)})
	end
)

minetest.register_craft {
	type = 'shapeless',
	output = 'awg:seed_mushroom_brown 3',
	recipe = {'flowers:mushroom_brown'}
}

register_seed(
	'mushroom_red',
	'awg_mushroom_spores_red_inv.png',
	'awg_mushroom_spores_red.png',
	'Red Mushroom Spores',
	'Grows into red mushrooms. Plant on soil.',
	300,
	'soil',
	function (pos)
		minetest.set_node(pos, {name = 'flowers:mushroom_red_'..math.random(1,3)})
	end
)

minetest.register_craft {
	type = 'shapeless',
	output = 'awg:seed_mushroom_red 3',
	recipe = {'flowers:mushroom_red'}
}

if minetest.settings: get_bool('awg.load_module_grassland', true) then
	register_seed(
		'mushroom_field',
		'awg_mushroom_spores_field_inv.png',
		'awg_mushroom_spores_field.png',
		'Field Mushroom Spores',
		'Grows into field mushrooms. Plant on soil.',
		300,
		'soil',
		function (pos)
			minetest.set_node(pos, {name = 'always_greener:field_mushroom_'..math.random(1,3)})
		end
	)

	minetest.register_craft {
		type = 'shapeless',
		output = 'awg:seed_mushroom_field 3',
		recipe = {'always_greener:field_mushroom_1'}
	}
	
	register_seed(
		'cane',
		'awg_seed_cane.png',
		'awg_seed_cane.png',
		'Giant Cane Shoot',
		'Grows into giant cane. Plant on soil.',
		900,
		'soil',
		function (pos)
			local height = math.random(1, 3)
			local rotation = math.random(0, 239)
			local has_top = math.random(1,2) == 1
			
			minetest.set_node(pos, {name = 'always_greener:cane_bottom', param2 = rotation})
			
			for i = 1, height do
				local node_up = minetest.get_node(pos + vector.new(0,i,0))
				if node_up.name == 'air' then
					minetest.set_node(pos + vector.new(0,i,0), {name = 'always_greener:cane_middle', param2 = rotation})
				else
					has_top = false
					break
				end
			end
			
			local node_top = minetest.get_node(pos + vector.new(0,height+1,0))
			if has_top and node_top.name == 'air' then
				minetest.set_node(pos + vector.new(0,height+1,0), {name = 'always_greener:cane_top', param2 = rotation})
			end
		end
	)

	minetest.register_craft {
		type = 'shapeless',
		output = 'awg:seed_cane 3',
		recipe = {'awg:cane_top'}
	}
end


