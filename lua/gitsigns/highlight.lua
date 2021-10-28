
local api = vim.api

local dprintf = require("gitsigns.debug").dprintf

local M = {}



local hls = {
   GitSignsAdd = { 'GitGutterAdd', 'SignifySignAdd', 'DiffAddedGutter', 'diffAdded', 'DiffAdd' },
   GitSignsChange = { 'GitGutterChange', 'SignifySignChange', 'DiffModifiedGutter', 'diffChanged', 'DiffChange' },
   GitSignsDelete = { 'GitGutterDelete', 'SignifySignDelete', 'DiffRemovedGutter', 'diffRemoved', 'DiffDelete' },

   GitSignsAddNr = { 'GitGutterAddLineNr', 'GitSignsAdd' },
   GitSignsChangeNr = { 'GitGutterChangeLineNr', 'GitSignsChange' },
   GitSignsDeleteNr = { 'GitGutterDeleteLineNr', 'GitSignsDelete' },

   GitSignsAddLn = { 'GitGutterAddLine', 'SignifyLineAdd', 'DiffAdd' },
   GitSignsChangeLn = { 'GitGutterChangeLine', 'SignifyLineChange', 'DiffChange' },
   GitSignsDeleteLn = { 'GitGutterDeleteLine', 'SignifyLineDelete', 'DiffDelete' },

   GitSignsCurrentLineBlame = { 'NonText' },

   GitSignsAddInline = { 'TermCursor' },
   GitSignsDeleteInline = { 'TermCursor' },
   GitSignsChangeInline = { 'TermCursor' },

   GitSignsAddLnInline = { 'GitSignsAddLn' },
   GitSignsChangeLnInline = { 'GitSignsChangeLn' },
   GitSignsDeleteLnInline = { 'GitSignsDeleteLn' },
}

local function is_hl_set(hl_name)

   local exists, hl = pcall(api.nvim_get_hl_by_name, hl_name, true)
   local color = hl.foreground or hl.background or hl.reverse
   return exists and color ~= nil
end



M.setup_highlights = function()
   for hl, candidates in pairs(hls) do
      if is_hl_set(hl) then

         dprintf('Highlight %s is already defined', hl)
      else
         for _, d in ipairs(candidates) do
            if is_hl_set(d) then
               dprintf('Deriving %s from %s', hl, d)
               vim.cmd(('highlight default link %s %s'):format(hl, d))
               break
            end
         end
      end
   end
end

return M
