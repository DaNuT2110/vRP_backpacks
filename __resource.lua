description "vRP_backpacks | Tradus din vRPex"

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "lib/lib.lua",
  "server.lua"
}
