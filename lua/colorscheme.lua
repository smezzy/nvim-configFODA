local colorscheme
if vim.g.neovide then
    colorscheme = "gruber-darker"
else
    colorscheme = "gruvbox"
end


-- set colorscheme
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
    vim.notify("Error while loading colorscheme: " .. colorscheme)
    return
end

require("rose-pine").setup {
    styles = {
        italic = false,
        bold = false,
        transparency = true,
    }
}
