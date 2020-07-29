local function json2lua(jsonString)
    local tick = socket.gettime()
    local buffer = jsonString
    buffer = buffer:gsub("%[", "{")--去掉左括号
    buffer = buffer:gsub("%]", "}")--去掉右括号
    buffer = buffer:gsub("\"(%--%d+)\"[^,]-:", "[%1] =")--数字key改为[1] = 的形式
    buffer = buffer:gsub("([^\\])\"([^,]-)\"[^,]-:", "%1[\"%2\"] =")--字符串key改为 ["a"] = 的形式
    buffer = buffer:match(".+}")--尾部的异常内容删除
    local luaObj
    local ok, msg = pcall(function ()
        luaObj = loadstring("return"..buffer)()
    end)

    if not ok then
        print(jsonString)
    end

    print("json2lua", ok, (socket.gettime()-tick)*1000)
    return ok and luaObj or ok
end

return json2lua
