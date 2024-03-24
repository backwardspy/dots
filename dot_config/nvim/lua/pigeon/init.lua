return {
	setup = function()
		require("pigeon.keybinds").setup()
		require("pigeon.platform").setup()
		require("pigeon.plugins").setup()
	end
}
