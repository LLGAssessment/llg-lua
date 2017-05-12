# llg-lua
A last letter game benchmark implemented in Lua

## How to run
Clone repository recursively:

```bash
git clone --recursive https://github.com/LLGAssessment/llg-lua.git
```

Run test and measure its time:

```bash
cd llg-lua
time lua llg.lua < llg-dataset/70pokemons.txt
```

Of course you can use LuaJIT for this benchmark:

```bash
time luajit llg.lua < llg-dataset/70pokemons.txt
```
