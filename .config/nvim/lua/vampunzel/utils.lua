local M = {}

-- Checks whether plugin is installed
function M.is_plugin_loaded(name)
    return vim.tbl_get(require('lazy.core.config'), 'plugins', name, '_', 'loaded') ~= nil
end

function M.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function M.print_keys(tbl)
    local s = '{ '
    for k,_ in pairs(tbl) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. k.. ',\n'
    end
    return s .. '} '
end

return M
