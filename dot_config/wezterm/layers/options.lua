local M = {}

function M.apply(config, _)
	config.initial_cols = 100
	config.initial_rows = 50
	print(config.initial_cols, config.initial_rows)
end

return M
