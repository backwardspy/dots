local M = {}

function M.partial(fn, ...)
  local args = { ... }
  return function()
    fn(unpack(args))
  end
end

return M
