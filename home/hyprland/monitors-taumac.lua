-- ==========================================
-- FALLBACK DEFAULT MONITOR CONFIGURATION
-- ==========================================
hl.monitor({ name = "", resolution = "preferred", position = "auto", scale = "auto" })

for i = 1, 7 do
  hl.workspace_rule({ workspace = tostring(i), persistent = true })
end
