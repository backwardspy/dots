M = {}

-- handy function for only doing something if a module can be imported
function M.require_then(name, callback)
    local ok, module = pcall(require, name)
    if not ok then return end
    callback(module)
end

return M
