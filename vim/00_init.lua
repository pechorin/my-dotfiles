local main_init_file  = '00_init.lua'
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

-- Vim profile load counter
if not _G.profile_loads then _G.profile_loads = 0 end
if _G.profile_loads > 1 then vim.print("reloading profile " .. tostring(_G.profile_loads)) end

-- Detect settings directory
local vim_files_path  = vim.fn.resolve(vim.fn.expand('<sfile>:p'))
vim_files_path        = vim.fn.substitute(vim_files_path, main_init_file, '', '')

-- Load all configuration files
local configs_paths = vim.fn.glob(vim_files_path .. '[0-9]*', false, true)
table.sort(configs_paths)
for _, config_file in ipairs(configs_paths) do
  if vim.fn.fnamemodify(config_file, ':t') ~= main_init_file
      and (config_file:match('%.lua$') or config_file:match('%.vim$')) then
    vim.cmd('source ' .. vim.fn.fnameescape(config_file))
  end
end

-- Track profile load
_G.profile_loads = _G.profile_loads + 1
