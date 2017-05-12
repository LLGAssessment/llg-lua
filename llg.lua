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

local function longestPath(graph)
    local visited = {}
    local toppath = {}
    local toppathlen = 0
    local stack = {}
    local function recurseGraph(pos, depth)
        visited[pos] = true
        stack[depth] = pos
        if toppathlen < depth then
            toppathlen = depth
            for i = 1,depth do toppath[i] = stack[i] end
        end
        for _, link in ipairs(graph[pos]) do
            if not visited[link] then
                recurseGraph(link, depth + 1)
            end
        end
        visited[pos] = false
    end

    for i, _ in ipairs(graph) do
        recurseGraph(i, 1)
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

    local graph = makeGraph(wordlist)

    for _, idx in ipairs(longestPath(graph)) do
        print(wordlist[idx])
    end

end

main()
