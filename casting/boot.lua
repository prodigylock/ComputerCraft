local http = require("http.request")
local json = require("dkjson")  -- You might need a JSON library like dkjson to parse the response.

-- Function to download the Lua program from GitHub
local function download_lua_file(owner, repo, filepath, access_token)
    local url = string.format(
        "https://api.github.com/repos/%s/%s/contents/%s",
        owner, repo, filepath
    )

    -- Set up the request
    local headers = {
        ["User-Agent"] = "LuaScript",
        ["Authorization"] = "token " .. access_token -- GitHub API requires an authorization token
    }

    local req = http.new_from_uri(url)
    for k, v in pairs(headers) do
        req.headers:upsert(k, v)
    end

    -- Send the request
    local headers, stream = assert(req:go())
    local body = assert(stream:get_body_as_string())
    
    -- Parse the response
    local data, _, err = json.decode(body)
    if err then
        error("Error parsing JSON: " .. err)
    end

    -- Check if the file content is base64 encoded
    if data and data.encoding == "base64" then
        local decoded_content = assert(base64.decode(data.content))

        -- Write the content to a file
        local file = io.open(filepath, "wb")
        file:write(decoded_content)
        file:close()

        print("File downloaded and saved as " .. filepath)
    else
        error("Failed to download file or incorrect encoding.")
    end
end

-- Example usage
local owner = "username"        -- GitHub repository owner
local repo = "repository-name"  -- GitHub repository name
local filepath = "file.lua"     -- Path to the file in the repo
local access_token = "your_token_here" -- Replace with your GitHub personal access token

download_lua_file(owner, repo, filepath, access_token)
