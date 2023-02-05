-- This method should be 100% undetectable if byfron ever attempts to improve their security
local webRequestFunc = syn and syn.request or http_request or request or http and http.request or nil
if not webRequestFunc then error("Your exploit doesn't support requests, which is what this script is based on!") end

local loadCodeFromURL = function(url)
    local response = webRequestFunc({
        Url = url,
        Method = 'GET'
    })
    if response.Success then
        local success, err = pcall(function()
            local c = coroutine.create(function()
                loadstring(response.Body)()
            end)
        end)
        if err then
            error("The script you executed contains an error!")
        end
    else
        warn("Request didn't return a success. Attempting to run script anyways.")
        pcall(function()
            loadstring(response.Body)()
        end)
    end
end
