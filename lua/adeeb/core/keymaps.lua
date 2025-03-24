vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "fj", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>bo", "<cmd>tabnew<CR>", { desc = "Open new buffer" }) -- open new buffer
keymap.set("n", "<leader>bd", "<cmd>tabclose<CR>", { desc = "Close current buffer" }) -- close current buffer
keymap.set("n", "<leader>bn", "<cmd>tabn<CR>", { desc = "Go to next buffer" }) --  go to next buffer
keymap.set("n", "<leader>bp", "<cmd>tabp<CR>", { desc = "Go to previous buffer" }) --  go to previous buffer
keymap.set("n", "<leader>bf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new buffer" }) --  move current buffer to new buffer

-- Files
keymap.set("n", "<leader>fs", "<cmd>w %<CR>", { desc = "Save the current file" }) --  move current buffer to new buffer
