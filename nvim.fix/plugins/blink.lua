	"giuxtaposition/blink-cmp-copilot",
			"copilot",
		},
			copilot = {
				name = "copilot",
				enabled = true,
				module = "blink-cmp-copilot",
				score_offset = 15,
				async = true,
				transform_items = function(_, items)
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1
					CompletionItemKind[kind_idx] = "Copilot"
					for _, item in ipairs(items) do
						item.kind = kind_idx
					end
					return items
				end,
			},
