print("Launching...")
local project = "elevator"
local url = "https://raw.githubusercontent.com/prodigylock/ComputerCraft/master/"..project.."/"

local function get(repoFile)
    print("Getting: "..url .. repoFile)
    local download = http.get(url .. repoFile) --This will make 'download' hold the contents of the file.
    if download then --checks if download returned true or false
       local handle = download.readAll() --Reads everything in download
       download.close() --remember to close the download!
       local file = fs.open(repoFile,"w") --opens the file defined in 'saveTo' with the permissions to write.
       file.write(handle) --writes all the stuff in handle to the file defined in 'saveTo'
       file.close() --remember to close the file!
    else --if returned false
       print("Unable to download the file "..repoFile)
       print("Make sure you have the HTTP API enabled or")
       print("an internet connection!")
      end --end the if
    end --close the function

--Finding peripherals
print("Finding peripherals")
local peripheralNames = peripheral.getNames()
for i = 1,#peripheralNames do
    print(peripheralNames[i])
end


--Downloading files
print("Downloading files")
get("elevator.lua")
get("button.lua")

print("Starting")
print("=============================")
shell.run("elevator.lua")
