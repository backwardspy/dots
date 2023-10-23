local M = {}

M.apply = function(config, wez)
	if not string.match(wez.target_triple, "windows") then
		return
	end

	local pwsh = os.getenv("LOCALAPPDATA") .. "/Microsoft/WindowsApps/pwsh.exe"
	config.default_prog = { pwsh, "-NoLogo" }
	config.default_cwd = "E:/backwardspy/"
end

return M
