local githubUrl = "https://raw.githubusercontent.com/prodigylock/ComputerCraft/master/launcher.lua"

local function downloadAndRunScript(url)
    local response = http.get(url)
    
    if response then
        local responseData = response.readAll() -- Read the response data
        response.close() -- Close the connection
        
        if responseData then
            local tempFilePath = "temp_script.lua"
            local tempFile = io.open(tempFilePath, "w")
            
            if tempFile then
                tempFile:write(responseData)
                tempFile:close()

                -- Run the downloaded Lua script
                local success, error = pcall(dofile, tempFilePath)

                -- Clean up: Delete the temporary file if it exists
                if fs.exists(tempFilePath) then
                    fs.delete(tempFilePath)
                end

                if not success then
                    print("Error:", error)
                end
            else
                print("Error: Failed to create temporary file")
            end
        else
            print("Error: Empty response")
        end
    else
        print("Error: Failed to connect to URL")
    end
end

downloadAndRunScript(githubUrl)
