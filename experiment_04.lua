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

object_manager = ObjectManager({
	Interest({
		type = "metadata",
		Constraint({ "metadata.name", "equals", "default" }),
	}),
})

object_manager:connect("installed", function(om)
	print("\nMetadata:")
	for metadata in om:iterate(Interest({ type = "metadata" })) do
		local global_props = metadata["global-properties"]
		local success, result = pcall(function()
			metadata:find(0, "default.audio.sink")
		end)
		print(success)
		print(result)
		local value = metadata:find(65, "active")
		print(value)
	end
end)

object_manager:activate()
