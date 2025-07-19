-- test_lua_lsp.lua

-- Intentional error: misspelled function name
functoin greet(name)
  print("Hello, " .. name)
end

-- Intentional warning: unused local variable
local foo = 42

-- Intentional TODO (some LSP setups highlight TODOs)
-- TODO: Refactor this code

-- Intentional runtime error: undefined variable
print(bar)

greet("World")
