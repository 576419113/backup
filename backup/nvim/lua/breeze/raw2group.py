import os
raws = os.listdir("raws")
for raw in raws:
    lines = []
    raw_file = "raws/" + raw
    lua_file = "groups/" + raw[:-4] +".lua"
    if os.path.isfile(lua_file):
        print(f'The lua file "{lua_file}" existed! Pass it!')
        continue
    with open(raw_file, "r") as raw:
        for line in raw.readlines():
            if line and line[0] in [" ", "\t"]:
                line = ""
                continue
            if "\t" in line:
                line = line.split("\t", maxsplit = 1)[0]
            elif " " in line:
                line = line.split(" ", maxsplit = 1)[0]
            lines.append(line.strip("\n"))
    lines.sort()
    with open(lua_file, "w") as lua:
        lua.write("local M = {}\n\nM.groups = {\n")
        for line in lines:
            if line:
                lua.write(f'    ["{line}"] = {{  }},\n')
        lua.write("}\n\nM.setup = function()\n    return M.groups\nend\n\nreturn M")
    print(f'Generated lua file {lua_file}.')
