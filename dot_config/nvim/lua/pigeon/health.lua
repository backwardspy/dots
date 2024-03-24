local function check_dependencies()
	local needed = {"curl", "git", "make", "rg", "tar", "unzip"}
	for _, dep in ipairs(needed) do
		if vim.fn.executable(dep) == 1 then
			vim.health.ok(string.format("Found needed executable: %s", dep))
		else
			vim.health.warn(string.format("Missing needed executable: %s", dep))
		end
	end
	return true
end

return {
	check = function()
		vim.health.start("pigeon")
		check_dependencies()
	end
}
