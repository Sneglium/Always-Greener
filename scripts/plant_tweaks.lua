
minetest.override_item('farming:wheat_7', {
	drawtype = 'mesh',
	mesh = 'awg_wheat.obj',
})

minetest.override_item('farming:wheat_8', {
	drawtype = 'mesh',
	mesh = 'awg_wheat.obj',
})

for i = 1, 8 do
	minetest.override_item('farming:cotton_'..i, {
		paramtype2 = 'meshoptions',
		place_param2 = 4
	})
end

minetest.override_item('farming:seed_cotton', {
	place_param2 = 4
})
