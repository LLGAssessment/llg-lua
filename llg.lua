#!/usr/bin/env lua

local function trim(s)
    return s:match'^%s*(.*%S)' or ''
end

local function makeGraph(wordlist)
    local firstletters = {}
    for _, w in ipairs(wordlist) do
        table.insert(firstletters, w:sub(1,1))
    end

    local graph = {}
    for i, leftword in ipairs(wordlist) do
        local lastletter = leftword:sub(-1)
        local links = {}
        for j, firstletter in ipairs(firstletters) do
            if i ~= j and lastletter == firstletter then
                table.insert(links, j)
            end
        end
        table.insert(graph, links)
    end
    return graph
end

local function printGraph(graph, wordlist)
    for i, links in ipairs(graph) do
        io.write(wordlist[i] .. "->")
        for j, linked in ipairs(links) do
            io.write(wordlist[linked] .. ",")
        end
        io.write("\n")
    end
end

local function printStack(st)
    print(table.concat(st, ","))
end

local function longestPath(graph)
    local visited = {}
    local toppath = {}
    local stack = {}
    local function recurseGraph(pos)
        visited[pos] = true
        table.insert(stack, pos)
        if #toppath < #stack then
            toppath = {unpack(stack)}
        end
        for _, link in ipairs(graph[pos]) do
            if not visited[link] then
                recurseGraph(link)
            end
        end
        visited[pos] = false
        table.remove(stack)
    end

    for i, _ in ipairs(graph) do
        recurseGraph(i)
    end
    return toppath
end

local function main()
    local words = {}
    for line in io.lines() do
        words[trim(line)] = true
    end
    words[""] = nil

    local wordlist = {}
    for k, _ in pairs(words) do
        table.insert(wordlist, k)
    end
    table.sort(wordlist)

    local graph = makeGraph(wordlist)

    -- printGraph(graph, wordlist)
    for _, idx in ipairs(longestPath(graph)) do
        print(wordlist[idx])
    end

end

main()
