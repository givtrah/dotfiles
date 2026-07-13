-- ==========================================
-- FALLBACK DEFAULT MONITOR CONFIGURATION
-- ==========================================
--
hl.monitor({
   output = "eDP-1",
   mode = "2560x1600",
   position = "0x0",
   scale = 1.5
 })

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.5 })

for i = 1, 7 do
  hl.workspace_rule({ workspace = tostring(i), persistent = true })
end
