-- Set project name here
local project = ""
local githubUrl = "https://raw.githubusercontent.com/prodigylock/ComputerCraft/master/".. project.."/launcher.lua"

function main()
    if file_exists("launcher.lua") then
        shell.run("launcher.lua")
    else
        downloadAndRunScript(githubUrl)
    end
    
end

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end

function downloadAndRunScript(url)
    local response = http.get(url)
    if response then
        local responseData = response.readAll() -- Read the response data
        response.close() -- Close the connection
        if responseData then
            local launcherPath = "launcher.lua"
            local launcher = io.open(launcherPath, "w")
            if launcher then
                launcher:write(responseData)
                launcher:close()
                -- Run the downloaded Lua script
                local success, error = pcall(dofile, launcherPath)
            else
                print("Error: Failed to create launch file")
            end
        else
            print("Error: Empty response")
        end
    else
        print("Error: Failed to connect to URL")
    end
end

main()

