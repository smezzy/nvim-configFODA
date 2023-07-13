local colorscheme = "gruvbox"

-- set colorscheme
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
    vim.notify("Error while loading colorscheme: " .. colorscheme)
    return
end

