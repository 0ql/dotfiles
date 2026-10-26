return {
  -- Inline colour previews (#ff0000, rgb(), etc.)
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Hex editor mode (:HexToggle)
  {
    "RaafatTurki/hex.nvim",
    cmd = { "HexDump", "HexAssemble", "HexToggle" },
    config = function()
      require("hex").setup()
    end,
  },
}
