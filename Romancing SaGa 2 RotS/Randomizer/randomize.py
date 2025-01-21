import random

def read_file(file_path, offset=0, num_bytes=None):
    try:
        with open(file_path, 'rb') as file:
            if offset > 0:
                file.seek(offset)
            data = file.read(num_bytes)
        return data
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
        return None
    except ValueError as e:
        print(f"Error: {e}")
        return None

def get_meta(data, amount, offset):
    meta = []
    index = offset
    for i in range(amount):
        enc = 'utf-16le' if data[index]==0x80 else 'utf-8'
        strLen = data[index+1]
        if enc=='utf-16le':
            strLen *= 2
            if data[index+2]==0:
                index+=1
        meta.append(data[index+2:index+2+strLen].decode(enc))
        index += 2+strLen
    return meta

def scale_values(data, start, interval, factor, count):
    data = bytearray(data)
    for i in range(count):
        offset = start+i*interval
        value = int(int.from_bytes(data[offset:offset+4],'little',signed=True)*factor)
        data[offset:offset+4] = value.to_bytes(4,'little')
    return data

def find_replace_meta_range(data, start, findL, findR, replace, verPos, verVal):
    data = bytearray(data)
    for i in range(start, len(data)):
        val = int.from_bytes(data[i:i+4],'little')
        if val >= findL and val <= findR and int.from_bytes(data[i+verPos:i+verPos+4],'little') == verVal:
            data[i:i+4] = replace.to_bytes(4,'little')
    return data

if __name__ == "__main__":
    # DropItem
    data = read_file("Game_Original/Content/Main/Item/DataTable/DT_DropItem.uasset")
    meta = get_meta(data, 2125, 0x40)
    index = 0xF719
    table = {}
    while index+291 < len(data):
        offset = index
        key = int.from_bytes(data[index+16:index+20], 'little')
        dropName = meta[int.from_bytes(data[index+49:index+53], 'little')]
        dropsCount = int.from_bytes(data[index+90:index+94], 'little')
        #print(int.from_bytes(data[index+119:index+123], 'little'))
        if not "DLC" in meta[key]:
            table[index+168] ={  "value": data[index+168:index+292],
                                "name": dropName}
        index+=292
        for i in range(dropsCount-1):
            table[index+33] ={  "value": data[index+33:index+157],
                                "name": dropName}
            index+=157
    #print(table)

    randoKeys = []
    randoIndex = []
    index = 0
    for key in table:
        #print("{}, Offset: {}".format(key, table[key]["Offset"]))
        randoKeys.append(key)
        randoIndex.append(index)
        index+=1
    random.shuffle(randoIndex)
    index = 0
    data = bytearray(data)
    for i in randoIndex:
        offset = randoKeys[index]
        data[offset:offset+124] = table[randoKeys[i]]["value"]
        index += 1
    with open("Game/Content/Main/Item/DataTable/DT_DropItem.uasset", 'wb') as file:
        file.write(data)

    # Techs
    skiplist = []
    followupTable = {}
    techdata = read_file("Game_Original/Content/Main/Battle/MainSystem/Data/Arts/DT_BattleSkillArtsTable.uasset")
    techmeta = get_meta(techdata, 998, 0x40)
    spelldata = read_file("Game_Original/Content/Main/Battle/MainSystem/Data/Arts/DT_BattleSpellArtsTable.uasset")
    spellmeta = get_meta(spelldata, 503, 0x40)
    
    data = read_file("Game_Original/Content/Main/Battle/MainSystem/Data/Arts/DT_BattleArtsResourceTable.uasset")
    meta = get_meta(data, 6678, 0x40)
    index = 0x8A009
    table = {}
    spellTable = {}
    while index+1352 < len(data):
        offset = index
        key = int.from_bytes(data[index+16:index+20], 'little')
        skillid = int.from_bytes(data[index+123:index+127], 'little')
        source = int.from_bytes(data[index+57:index+61], 'little')
        if source==4137:
            if "-" in meta[skillid] or meta[skillid][-1]=="2" or "Balm" in meta[skillid] or "Normal" in meta[skillid]:
                skiplist.append(meta[skillid])
                if "-Damage" in meta[skillid] or "-Lv" in meta[skillid]:
                    base = meta[skillid][:meta[skillid].find("-")]
                    if not base[-1]=="2":
                        followupTable[meta[skillid]] = base
                #print("Skipping "+meta[skillid])
            elif meta[skillid] in techmeta:
                table[key] = {"data": data[index+123:index+127], "offset": offset}
            elif meta[skillid] in spellmeta:
                spellTable[key] = {"data": data[index+123:index+127], "offset": offset}
                #print(meta[key])
        index+=1352
    randoIndex = []
    randoKeys = []
    techTable = {}
    index = 0
    for key in table:
        randoIndex.append(index)
        randoKeys.append(key)
        index+=1
    index = 0
    spellIndex = []
    spellKeys = []
    for key in spellTable:
        spellIndex.append(index)
        spellKeys.append(key)
        index += 1
        
    random.shuffle(randoIndex)
    random.shuffle(spellIndex)
    index = 0
    data = bytearray(data)
    for i in randoIndex:
        offset = table[randoKeys[index]]["offset"]
        value = table[randoKeys[i]]["data"]
        techTable[meta[int.from_bytes(table[randoKeys[index]]["data"], 'little')]] = meta[int.from_bytes(value, 'little')]
        data[offset+123:offset+127] = value[:]
        index += 1
    index = 0
    for i in spellIndex:
        offset = spellTable[spellKeys[index]]["offset"]
        value = spellTable[spellKeys[i]]["data"]
        techTable[meta[int.from_bytes(spellTable[spellKeys[index]]["data"], 'little')]] = meta[int.from_bytes(value, 'little')]
        data[offset+123:offset+127] = value[:]
        index += 1

    with open("Game/Content/Main/Battle/MainSystem/Data/Arts/DT_BattleArtsResourceTable.uasset", 'wb') as file:
        file.write(data)

    for j in range(2):
        table = {}
        index = 0xADBD if j==0 else 0x5DF5
        data = bytearray(techdata if j==0 else spelldata)
        meta = techmeta if j==0 else spellmeta
        print(j)
        
        while index+3000 < len(data):
            key = int.from_bytes(data[index:index+4], 'little')
            key = meta[key] if key < len(meta) else ""
            artstype = int.from_bytes(data[index+8:index+12],'little')
            if (key in techTable or key in followupTable) and artstype < len(meta) and meta[artstype]=="MArtsType":
                table[key] = {"MArtsType": data[index+41:index+45], "offset": index}
                for i in range(2200, 2900):
                    fathom = int.from_bytes(data[index+i:index+i+4], 'little')
                    if fathom < len(meta) and meta[fathom] == "MFathomArtsId":
                        table[key]["MFathomArtsId"] = data[index+i+25:index+i+29]
                        table[key]["MDamageRefLevel"] = data[index+i+335:index+i+339]
                        table[key]["offsetFathom"] = index+i
                        break
                if key in techTable:
                    data[index:index+4] = meta.index(techTable[key]).to_bytes(4,'little')
                index += 3000
            elif key in skiplist:
                index += 3000
            index += 1

        for key in table:
            #print("{} = {}".format(key, techTable[key]))
            offset = table[key]["offset"]
            offsetFathom = table[key]["offsetFathom"]
            other = techTable[key if key in techTable else followupTable[key]]
            data[offset+41:offset+45] = table[other]["MArtsType"][:]
            #data[offsetFathom+25:offsetFathom+29] = table[techTable[key]]["MFathomArtsId"][:]
            data[offsetFathom+335:offsetFathom+339] = table[other]["MDamageRefLevel"][:]

        if j==0:
            with open("Game/Content/Main/Battle/MainSystem/Data/Arts/DT_BattleSkillArtsTable.uasset", 'wb') as file:
                file.write(data)
        else:
            with open("Game/Content/Main/Battle/MainSystem/Data/Arts/DT_BattleSpellArtsTable.uasset", 'wb') as file:
                file.write(data)

    # Armor
    data = read_file("Game_Original/Content/Main/Item/DataTable/Cellest/DT_CellestItemArmor.uasset")
    meta = get_meta(data, 257, 0x40)
    index = 0
    table = {}
    randoKeys = []
    comp = "proper".encode()
    while index+1000 < len(data):
        if data[index:index+6] == comp:
            key = int.from_bytes(data[index-116:index-112],'little')
            i = index+150
            while not (data[i] == 0x83 and data[i-49] == 0x2E):
                i += 1
            
            table[meta[key]] = {"offset": i, "value": data[i:i+1611]}
            randoKeys.append(meta[key])
            index += 1500
        index += 1

    random.shuffle(randoKeys)
    index = 0
    data = bytearray(data)
    for key in table:
        rkey = randoKeys[index]
        offset = table[key]["offset"]
        data[offset:offset+1611] = table[rkey]["value"][:]
        index += 1
        #print("{} = {}".format(key, rkey))

    with open("Game/Content/Main/Item/DataTable/Cellest/DT_CellestItemArmor.uasset", 'wb') as file:
        file.write(data)
    
    # Shields
    data = read_file("Game_Original/Content/Main/Item/DataTable/Cellest/DT_CellestItemShield.uasset")
    meta = get_meta(data, 204, 0x40)

    index = 0
    table = {}
    randoKeys = []
    while index+1600 < len(data):
        if data[index:index+6] == comp:
            key = int.from_bytes(data[index-83:index-79],'little')
            i = index+120
            while not (data[i] == 0xC3 and data[i+29] == 0x53):
                i += 1
            
            table[meta[key]] = {"offset": i, "value": data[i:i+1694]}
            randoKeys.append(meta[key])
            index = i+32
        index += 1

    random.shuffle(randoKeys)
    index = 0
    data = bytearray(data)
    for key in table:
        rkey = randoKeys[index]
        offset = table[key]["offset"]
        data[offset:offset+1694] = table[rkey]["value"][:]
        index += 1
        #print("{} = {}".format(key, rkey))

    with open("Game/Content/Main/Item/DataTable/Cellest/DT_CellestItemShield.uasset", 'wb') as file:
        file.write(data)

    # Weapons
    data = read_file("Game_Original/Content/Main/Item/DataTable/Cellest/DT_CellestItemWeapon.uasset")
    meta = get_meta(data, 455, 0x40)

    index = 0x6AF5
    table = {}
    randoKeys = []
    while index+800 < len(data):
        if data[index:index+6] == comp:
            key = int.from_bytes(data[index-116:index-112],'little')
            i = index+150
            while not (data[i] == 0x34 and data[i+1] == 1):
                i += 1
            
            table[meta[key]] = {"offset": i, "value": data[i:i+517]}
            randoKeys.append(meta[key])
            index = i+32
        index += 1

    random.shuffle(randoKeys)
    index = 0
    data = bytearray(data)
    for key in table:
        rkey = randoKeys[index]
        offset = table[key]["offset"]
        data[offset:offset+517] = table[rkey]["value"][:]
        index += 1
        #print("{} = {}".format(key, rkey))

    with open("Game/Content/Main/Item/DataTable/Cellest/DT_CellestItemWeapon.uasset", 'wb') as file:
        file.write(data)

    # Scaling
    data = read_file("Game_Original/Content/Main/Exp/DataTable/DT_ExpArtsLevel.uasset")
    with open("Game/Content/Main/Exp/DataTable/DT_ExpArtsLevel.uasset", 'wb') as file:
        file.write(scale_values(data, 0x2E7, 74, 0.1, 100))
        
    data = read_file("Game_Original/Content/Main/Exp/DataTable/DT_ExpBp.uasset")
    with open("Game/Content/Main/Exp/DataTable/DT_ExpBp.uasset", 'wb') as file:
        file.write(scale_values(data, 0x324, 132, 0.1, 50))
        
    data = read_file("Game_Original/Content/Main/Exp/DataTable/DT_ExpHp.uasset")
    with open("Game/Content/Main/Exp/DataTable/DT_ExpHp.uasset", 'wb') as file:
        file.write(scale_values(data, 0x324, 132, 0.1, 200))
        
    data = read_file("Game_Original/Content/Main/Exp/DataTable/DT_ExpMasterLevel.uasset")
    with open("Game/Content/Main/Exp/DataTable/DT_ExpMasterLevel.uasset", 'wb') as file:
        file.write(scale_values(data, 0x2EF, 74, 0.1, 90))

    data = read_file("Game_Original/Content/Main/GamePlayData/Data/DT_EnemyForceLevelTable.uasset")
    with open("Game/Content/Main/GamePlayData/Data/DT_EnemyForceLevelTable.uasset", 'wb') as file:
        file.write(scale_values(data, 0x1296, 315, 10, 5))

    data = read_file("Game_Original/Content/Main/UI/Object/Map/WorldMap/Data/DT_WorldMapIconDataTable.uasset")
    with open("Game/Content/Main/UI/Object/Map/WorldMap/Data/DT_WorldMapIconDataTable.uasset", 'wb') as file:
        file.write(find_replace_meta_range(data, 0x18100, 983, 1065, 1059, -25, 842))
    
