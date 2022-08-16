local LuaSyntaxToolset = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/LuaSyntaxToolset.lua"))()
return function(src)
	return LuaSyntaxToolset.beautify(src, false, false, false)
end
