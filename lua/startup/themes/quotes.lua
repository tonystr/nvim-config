local function get_shell_quote()
	local now = os.time()
	local days_passed = math.floor(now / (24 * 60 * 60))
	math.randomseed(days_passed)

	local dir = vim.fn.fnamemodify(debug.getinfo(2, "S").source, ':h'):sub(2)
	local file = vim.fn.readfile(dir .. '/quotes.md')
	local index = math.floor(math.random() * ((#file + 1) / 3))
	local quote = file[index * 3 + 1]
	local author = file[index * 3 + 2]:match'-.*$'
	return { quote, "", author }
end

return get_shell_quote
