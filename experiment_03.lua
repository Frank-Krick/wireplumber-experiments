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
		Constraint({ "metadata.name", "equals", "default" }),
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

		for key, value in pairs(getmetatable(obj)) do
			print(key, value)
		end

		local success, result = pcall(function()
			obj:iterator(-1)
		end)
		print(success)
		print(result)
	end
end)

metadata_object_manager:activate()
