-- load the JSON library.
local Json = require("JSON")

local RundeckACL = {}

-- Function to save a table.&nbsp; Since game settings need to be saved from session to session, we will
-- use the Documents Directory
function RundeckACL.authorize(username)
        file = io.open ('/etc/rundecACL/acl.json','r')
        contents = file:read()
        file:close()
        acl = Json:decode(contents)


        if (acl)
        then
           user_groups = acl.user_groups

           if (user_groups.admin and table.getn(user_groups.admin) > 0)
           then
                ngx.thread.spawn(RundeckACL.findUsername,username,user_groups.admin)
                found = RundeckACL.findUsername(username,user_groups.admin)
                if found
                then
                   RundeckACL.setPrevilege("admin")

                else if (user_groups.ops and table.getn(user_groups.ops) > 0)
                then
                        ngx.log(ngx.ERR,"ops")
                        found = RundeckACL.findUsername(username, user_groups.ops)

                        if found
                        then
                                RundeckACL.setPrevilege("ops")
                        else
                            RundeckACL.setPrevilegei("1user")
                        end
                else
                  RundeckACL.setPrevilege("user")
                end
            end
         end
   end
end

function RundeckACL.findUsername(username, usernames)
    found = false
    for _,email in pairs(usernames) do
            ngx.log(ngx.ERR,username.." "..email)
            if email == username then
                    found = true
            end
    end
    return found
end

function RundeckACL.setPrevilege(previlege)
    ngx.log(ngx.ERR,previlege)
    ngx.req.set_header("X-Forwarded-Roles",previlege)
end

return RundeckACL