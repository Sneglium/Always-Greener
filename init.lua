
etcetera.register_mod('always_greener', 'awg')
awg = always_greener

awg.translate = minetest.get_translator 'always_greener'

function awg.gettext (text, colormode, ...)
	if (not colormode) or colormode == 'normal' or colormode == 'displayname' then
		return awg.translate(text, ...)
	else
		return minetest.colorize(assert(etc.textcolors[colormode], 'Invalid color: ' .. colormode), awg.translate(etc.wrap_text(text, ETC_DESC_WRAP_LIMIT), ...): gsub('\n', '|n|')): gsub('|n|', '\n'): sub(1, -1)
	end
end

awg: load_script 'grass'
minetest.register_mapgen_script(awg.path .. '/scripts/grass_mapcolors.lua')

awg: load_script 'plant_tweaks'

awg: load_script 'tundra'

awg: load_script 'cuttings'
