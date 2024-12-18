#!/usr/bin/wpexec

--[[
out_ports_object_manager = ObjectManager({
	Interest({
		type = "port",
		Constraint({ "port.direction", "equals", "out" }),
	}),
})

out_ports_object_manager:connect("installed", function(om)
	print("\nPorts:")
	for obj in om:iterate({ type = "port" }) do
		local id = obj["bound-id"]
		local global_props = obj["global-properties"]

		print("\n")
		for key, value in pairs(global_props) do
			print("\t" .. key .. ": " .. value)
		end
	end
end)

out_ports_object_manager:activate()
--]]

metadata_object_manager = ObjectManager({
	Interest({
		type = "metadata",
	}),
})

metadata_object_manager:connect("installed", function(om)
	print("\nMetadata:")
	for obj in om:iterate() do
		local global_props = obj["global-properties"]

		print("\n")
		for key, value in pairs(global_props) do
			print("\t" .. key .. ": " .. value)
		end
	end
end)

metadata_object_manager:activate()
