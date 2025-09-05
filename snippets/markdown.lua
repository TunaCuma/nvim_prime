local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- Bash code block
	s("bash", {
		t("```bash"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),

	-- JavaScript code block
	s("js", {
		t("```javascript"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),

	-- TypeScript code block
	s("ts", {
		t("```typescript"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),

	-- Python code block
	s("py", {
		t("```python"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),

	-- Lua code block
	s("lua", {
		t("```lua"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),

	-- Generic code block with language selection
	s("code", {
		t("```"),
		i(1, "language"),
		t({ "", "" }),
		i(2),
		t({ "", "```" }),
	}),

	-- JSON code block
	s("json", {
		t("```json"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),

	-- YAML code block
	s("yaml", {
		t("```yaml"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),

	-- Headers
	s("h1", {
		t("# "),
		i(1),
	}),

	s("h2", {
		t("## "),
		i(1),
	}),

	s("h3", {
		t("### "),
		i(1),
	}),

	s("h4", {
		t("#### "),
		i(1),
	}),

	s("h5", {
		t("##### "),
		i(1),
	}),

	s("h6", {
		t("###### "),
		i(1),
	}),

	-- Links and images
	s("link", {
		t("["),
		i(1, "text"),
		t("]("),
		i(2, "url"),
		t(")"),
	}),

	s("img", {
		t("!["),
		i(1, "alt text"),
		t("]("),
		i(2, "image url"),
		t(")"),
	}),

	-- Lists
	s("ul", {
		t("- "),
		i(1),
		t({ "", "- " }),
		i(2),
		t({ "", "- " }),
		i(3),
	}),

	s("ol", {
		t("1. "),
		i(1),
		t({ "", "2. " }),
		i(2),
		t({ "", "3. " }),
		i(3),
	}),

	-- Task list
	s("task", {
		t("- [ ] "),
		i(1),
		t({ "", "- [ ] " }),
		i(2),
		t({ "", "- [x] " }),
		i(3),
	}),

	-- Table
	s("table", {
		t("| "),
		i(1, "Header 1"),
		t(" | "),
		i(2, "Header 2"),
		t(" | "),
		i(3, "Header 3"),
		t(" |"),
		t({ "", "|----------|----------|----------|" }),
		t({ "", "| " }),
		i(4, "Cell 1"),
		t(" | "),
		i(5, "Cell 2"),
		t(" | "),
		i(6, "Cell 3"),
		t(" |"),
		t({ "", "| " }),
		i(7, "Cell 4"),
		t(" | "),
		i(8, "Cell 5"),
		t(" | "),
		i(9, "Cell 6"),
		t(" |"),
	}),

	-- Emphasis
	s("bold", {
		t("**"),
		i(1),
		t("**"),
	}),

	s("italic", {
		t("*"),
		i(1),
		t("*"),
	}),

	s("strike", {
		t("~~"),
		i(1),
		t("~~"),
	}),

	-- Inline code
	s("icode", {
		t("`"),
		i(1),
		t("`"),
	}),

	-- Blockquote
	s("quote", {
		t("> "),
		i(1),
		t({ "", "> " }),
		i(2),
	}),

	-- Horizontal rule
	s("hr", {
		t("---"),
	}),

	-- Frontmatter
	s("front", {
		t("---"),
		t({ "", "title: " }),
		i(1, "Title"),
		t({ "", "date: " }),
		i(2, "2024-01-01"),
		t({ "", "tags: [" }),
		i(3, "tag1, tag2"),
		t("]"),
		t({ "", "---" }),
		t({ "", "" }),
		i(4),
	}),

	-- Collapsible section
	s("details", {
		t("<details>"),
		t({ "", "<summary>" }),
		i(1, "Click to expand"),
		t("</summary>"),
		t({ "", "" }),
		i(2),
		t({ "", "" }),
		t("</details>"),
	}),

	-- Math (LaTeX)
	s("math", {
		t("$$"),
		t({ "", "" }),
		i(1),
		t({ "", "$$" }),
	}),

	s("imath", {
		t("$"),
		i(1),
		t("$"),
	}),

	s("sql", {
		t("```sql"),
		t({ "", "" }),
		i(1),
		t({ "", "```" }),
	}),
}
