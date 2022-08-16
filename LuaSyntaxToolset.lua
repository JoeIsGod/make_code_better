local lookupify = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/lookupify.lua"))()
local formatTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/formatTable.lua"))()

local tokenize = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/tokenize.lua"))()
local parse = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/parse.lua"))()

local printAst = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/printAst.lua"))()
local stripAst = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/stripAst.lua"))()
local formatAst = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/formatAst.lua"))()

local addVariableInfo = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/addVariableInfo.lua"))()
local beautifyVariables = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/beautifyVariables.lua"))()
local minifyVariables = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/minifyVariablesAdvanced.lua"))()

local decodeStrings = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/decodeStrings.lua"))()
local encodeStrings = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/encodeStrings.lua"))()

local Keywords = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/Keywords.lua"))()
local WhitespaceCharacters = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/WhitespaceCharacters.lua"))()
local AllIdentifierCharacters = loadstring(game:HttpGet("https://raw.githubusercontent.com/JoeIsGod/make_code_better/main/AllIdentifierCharacters.lua"))()

local LuaSyntaxToolset = {}

function LuaSyntaxToolset.minify(source: string, renameGlobals: boolean, doEncodeStrings: boolean)
	local tokens = tokenize(source)
	local ast = parse(tokens)
	local glb, root = addVariableInfo(ast)
	minifyVariables(glb, root, renameGlobals)
	if doEncodeStrings then
		encodeStrings(tokens)
	end
	stripAst(ast)
	return printAst(ast)
end

--[[
string source: The source code to beautify
bool renameVars: Should the local variables be renamed into easily find-replacable naming for reverse engineering?
bool renameGlobals: Should the same be done for globals? (unsafe if get/setfenv were used)
]]
function LuaSyntaxToolset.beautify(source: string, renameVars: boolean, renameGlobals: boolean, doDecodeStrings: boolean)
	local tokens = tokenize(source)
	local ast = parse(tokens)
	local glb, root = addVariableInfo(ast)
	
	if renameVars then
		beautifyVariables(glb, root, renameGlobals)
	end
	if doDecodeStrings then
		decodeStrings(tokens)
	end
	
	formatAst(ast)
	return printAst(ast)
end

return LuaSyntaxToolset
