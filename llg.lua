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

    printGraph(graph, wordlist)

end

main()
