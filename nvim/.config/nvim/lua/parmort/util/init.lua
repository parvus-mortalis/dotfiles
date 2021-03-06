local M = {}
local util = M

function M.err(msg)
  vim.api.nvim_command('echohl WarningMsg')
  vim.api.nvim_command('echo "'..msg..'"')
  vim.api.nvim_command('echohl None')
end

function M.prequire(pkg)
  local ok, msg = pcall(function() require(pkg) end)

  if not ok then
    M.err(msg)
  end
end

function M.highlight(group, attr)
  local cmd = 'highlight '..group

  for k,v in pairs(attr) do
    cmd = cmd..' '..k..'='..v
  end

  vim.cmd(cmd)
end

return util
