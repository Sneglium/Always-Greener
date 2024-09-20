
local leaves = {
	'ebiomes:afzelia_leaves',
	'ebiomes:alder_leaves',
	'ebiomes:ash_leaves',
	'ebiomes:bamboo_leaves',
	'ebiomes:beech_leaves',
	'ebiomes:birch_leaves',
	'ebiomes:chestnut_leaves',
	'ebiomes:cypress_leaves',
	'ebiomes:downy_birch_leaves',
	'ebiomes:hornbeam_leaves',
	'ebiomes:limba_leaves',
	'ebiomes:maple_leaves',
	'ebiomes:mizunara_leaves',
	'ebiomes:oak_leaves',
	'ebiomes:olive_leaves',
	'ebiomes:pear_leaves',
	'ebiomes:quince_leaves',
	'ebiomes:siri_leaves',
	'ebiomes:stoneoak_leaves',
	'ebiomes:sugi_leaves',
	'ebiomes:tamarind_leaves',
	'ebiomes:willow_leaves'
}

local function leaves_after_place (pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node(pos)
	node.param2 = math.random(0, 239)
	minetest.swap_node(pos, node)
end

if minetest.settings: get_bool('awg.tree_leaves', true) then
	for i = 1, #leaves do
		if minetest.registered_nodes[leaves[i]] then
			local tile = minetest.registered_nodes[leaves[i]].tiles[1]
			
			minetest.override_item(leaves[i], {
				tiles = {tile .. '^[mask:awg_leaves_round_mask.png'},
				drawtype = 'mesh',
				use_texture_alpha = 'clip',
				mesh = 'awg_tree_leaves.obj',
				paramtype2 = 'degrotate',
				after_place_node = leaves_after_place,
				visual_scale = 0.95
			})
		end
	end
end

if minetest.settings: get_bool('awg.tree_leaves_climbable', true) then
	for i = 1, #leaves do
		if minetest.registered_nodes[leaves[i]] then
			local tile = minetest.registered_nodes[leaves[i]].tiles[1]
			
			minetest.override_item(leaves[i], {
				walkable = false,
				climbable = true,
				move_resistance = 4
			})
		end
	end
end

local grass = {
	'ebiomes:dirt_with_grass_cold',
	'ebiomes:dirt_with_grass_med',
	'ebiomes:dirt_with_grass_steppe',
	'ebiomes:dirt_with_grass_steppe_cold',
	'ebiomes:dirt_with_grass_steppe_warm',
	'ebiomes:dirt_with_grass_swamp',
	'ebiomes:dirt_with_grass_warm',
	'ebiomes:dirt_with_jungle_savanna_grass'
}

for i = 1, #grass do
	if minetest.registered_nodes[grass[i]] then
		etc.smart_override_item(grass[i], {groups = {not_in_creative_inventory = 1}})
	end
end

local dry_grass = {
	'ebiomes:dry_dirt_with_grass_arid',
	'ebiomes:dry_dirt_with_grass_arid_cool',
	'ebiomes:dry_dirt_with_humid_savanna_grass'
}

for i = 1, #dry_grass do
	if minetest.registered_nodes[dry_grass[i]] then
		etc.smart_override_item(dry_grass[i], {groups = {not_in_creative_inventory = 1}})
	end
end
