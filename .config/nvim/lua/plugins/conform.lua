return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      svg = { "prettier" },
    },
    formatters = {
      prettier = {
        prepend_args = { "--parser", "html" },
      },
    },
  },
}
