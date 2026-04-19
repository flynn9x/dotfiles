local M = {}

function M.load_dir(dir)
	local dir_path = vim.fn.stdpath("config") .. "lua" .. dir
	local files = vim.fs.find(function(name)
		return name:match("%.lua$")
	end, {
		path = dir_path,
		type = "file",
		limit = math.huge,
	})
	
	for _, file in ipairs(files) do
		local module = file:gsub(vim.fn.stdpath("config") .. "/lua/", ""):gsub("/", "."):gsub("%.lua$", "")

		local ok, err = pcall(require, module)
		if not ok then
			vim.notify("Error loading " .. module .. ":\n" .. err, vim.log.levels.ERROR)
		end
	end
end

return M
