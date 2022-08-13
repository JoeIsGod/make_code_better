local LuaSyntaxToolset = loadstring(game:HttpGet(""))()
return function(src)
	return LuaSyntaxToolset.beautify(src, false, false, false)
end
