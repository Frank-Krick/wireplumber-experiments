#!/usr/bin/wpexec

--
-- Retrieve objects using an ObjectManager
--
-- Note: obj_mgr here cannot be a local variable; we need it to stay alive
-- after the execution has returned to the main loop
--
object_manager = ObjectManager({
	Interest({ type = "client" }),
	Interest({ type = "device" }),
	Interest({ type = "node" }),
})

-- Listen for the 'installed' signal from the ObjectManager
-- and execute a function when it is fired
-- This function will be called from the main loop at some point later
object_manager:connect("installed", function(om)
	--
	-- Print connected clients
	--
	print("\nClients:")
	for obj in om:iterate({ type = "client" }) do
		--
		-- 'bound-id' and 'global-properties' are GObject
		-- properties of WpProxy / WpGlobalProxy
		--
		local id = obj["bound-id"]
		local global_props = obj["global-properties"]

		print(
			"\t"
				.. id
				.. ": "
				.. global_props["application.name"]
				.. " (PID: "
				.. global_props["pipewire.sec.pid"]
				.. ")"
		)
	end

	--
	-- Print devices
	--
	print("\nDevices:")
	for obj in om:iterate({ type = "device" }) do
		local id = obj["bound-id"]
		local global_props = obj["global-properties"]

		print("\t" .. id .. ": " .. global_props["device.name"] .. " (" .. global_props["device.description"] .. ")")
	end

	-- Common function to print nodes
	local function printNode(node)
		local id = node["bound-id"]
		local global_props = node["global-properties"]

		-- standard lua string.match() function used here
		if global_props["media.class"]:match("Stream/.*") then
			print("\t" .. id .. ": " .. global_props["application.name"])
		else
			print("\t" .. id .. ": " .. global_props["object.path"] .. " (" .. global_props["node.description"] .. ")")
		end
	end

	--
	-- Print device sinks
	--
	print("\nSinks:")
	--
	-- Interest can have additional constraints that can be used to filter
	-- the results. In this case we are only interested in nodes with their
	-- "media.class" global property matching the glob expression "*/Sink"
	--
	local interest = Interest({ type = "node", Constraint({ "media.class", "matches", "*/Sink" }) })
	for obj in om:iterate(interest) do
		printNode(obj)
	end

	--
	-- Print device sources
	--
	print("\nSources:")
	local interest = Interest({ type = "node", Constraint({ "media.class", "matches", "*/Source" }) })
	for obj in om:iterate(interest) do
		printNode(obj)
	end

	--
	-- Print client streams
	--
	print("\nStreams:")
	local interest = Interest({ type = "node", Constraint({ "media.class", "matches", "Stream/*" }) })
	for obj in om:iterate(interest) do
		printNode(obj)
	end

	-- Disconnect from pipewire and quit wireplumber
	-- This only works in script interactive mode
	Core.quit()
end)

-- Activate the object manager. This is required to start it,
-- otherwise it doesn't do anything
object_manager:activate()
