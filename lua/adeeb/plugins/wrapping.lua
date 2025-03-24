return {
  "andrewferrier/wrapping.nvim",
  config = function()
    require("wrapping").setup({
      softener = {
        markdown = function()
          local filetype = vim.bo.filetype -- Get the current buffer's filetype
          if filetype == "markdown" then
            return true
          else
            return false
          end
        end,
      },
    })
  end,
}
