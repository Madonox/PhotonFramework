-- Madonox
-- 2022

local service = {}

function service.compileFunctions(functionsArray)
    local res = {}
    for _,func in ipairs(functionsArray) do
        table.insert(res,coroutine.wrap(func))
    end
    return res
end

function service.executeFunctions(compiledArray,...)
    for _,cor in ipairs(compiledArray) do
        cor(...)
    end
end

return service