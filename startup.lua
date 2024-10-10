local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function decodeBase64(data)
     data = string.gsub(data, '[^'..b..'=]', '')
     return (data:gsub('.', function(x)
     if (x == '=') then return '' end
     local r,f='',(b:find(x)-1)
     for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
     return r;
 end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
     if (#x ~= 8) then return '' end
     local c=0
     for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
     return string.char(c)
     end))
 end

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
function runLuaFile(filename)
    if fs.exists(filename) then
        shell.run(filename)
        print("Executed: " .. filename)
    else
        print("File does not exist: " .. filename)
    end
end
function downloadFilesAPI(username, repository, branch, filePath)
    local apiUrl = "https://api.github.com/repos/"..username.."/"..repository.."/contents/"..filePath.."?ref="..branch
    local headers = {
        ["User-Agent"] = "ComputerCraft"
    }
    local request = http.get(apiUrl, headers)
    if request then
        local response = request.readAll()
        request.close()
        local fileData = textutils.unserializeJSON(response)
         if fileData and fileData.content and fileData.encoding == "base64" then
             local content = decodeBase64(fileData.content)
              if fs.exists(filePath) then
                   fs.delete(filePath)
                   print("Existing file deleted: " .. filePath)
              end
              local file = fs.open(filePath, "w")
              file.write(content)
              file.close()
              print("Downloaded and saved: " .. filePath)
            --   if filePath:match("%.lua$") then
            --       runLuaFile(filePath)
            --   end
          else
              print("Failed to decode content for: " .. filePath)
          end
      else
          print("Failed to download: " .. apiUrl)
      end
 end
 function getAllFiles(username, repository, branch)
     local apiUrl = "https://api.github.com/repos/"..username.."/"..repository.."/git/trees/"..branch.."?recursive=1"
     local headers = {
         ["User-Agent"] = "ComputerCraft"
     }
     local request = http.get(apiUrl, headers)
     if request then
         local response = request.readAll()
         request.close()
         local files = textutils.unserializeJSON(response)
         if files and files.tree then
             for _, file in ipairs(files.tree) do
                 if file.type == "blob" then
                     local filePath = file.path
                     local savePath = split(filePath, "/")
                     local filename = table.remove(savePath)
                     local directory = table.concat(savePath, "/")
                     if not fs.exists(directory) and directory ~= "" then
                         fs.makeDir(directory)
                     end
                     downloadFilesAPI(username, repository, branch, filePath)
                 end
             end
         else
             print("No files found in the repository.")
         end
     else
          print("Failed to access GitHub API.")
      end
  end
  getAllFiles("prodigylock", "ComputerCraft", "main")
 
        
