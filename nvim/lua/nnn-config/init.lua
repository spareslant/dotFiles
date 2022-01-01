local fn = vim.fn
fn.execute("highlight NnnBorder guifg=#555555")

local builtin = require("nnn").builtin

local function is_dir(path)
    f = io.open(path)
    return not f:read(0) and f:seek("end") ~= 0
end

-- while in nnn, use <spacebar> to select directory and then press <A-w> and press q to quit nnn
-- see the bindings below.
function builtin.mycd_to_path(files)
  local dir = is_dir(files[1])
  print("MY-DEBUG => "..files[1])
  local targetDir = ""

  if dir == true
  then
    targetDir = files[1]
  else
    targetDir = files[1]:match(".*/")
  end
  fn.execute("cd "..targetDir)
  vim.defer_fn(function() print("working directory changed to: "..targetDir) end, 0)
end

require("nnn").setup({
	picker = {
    cmd = "nnn -d -G",
		style = { border = "rounded" },
	},
	mappings = {
		{ "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
		{ "<C-s>", builtin.open_in_split }, -- open file(s) in split
		{ "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
		{ "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
		{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
		{ "<A-w>", builtin.mycd_to_path }, -- cd to selected directory
		{ "<C-e>", builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
	},
})
