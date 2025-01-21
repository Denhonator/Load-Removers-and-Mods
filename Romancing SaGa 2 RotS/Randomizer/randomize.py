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
        drops = []
        drop = {"MWeight": int.from_bytes(data[index+168:index+172], 'little'),
                "MItemCount": int.from_bytes(data[index+197:index+201], 'little'),
                "MItemID": int.from_bytes(data[index+226:index+230], 'little'),
                "MMoney": int.from_bytes(data[index+259:index+263], 'little', signed=True),
                "BankMoney": int.from_bytes(data[index+288:index+292], 'little', signed=True)}
        drops.append(drop)
        index+=292
        for i in range(dropsCount-1):
            drop = {"MWeight": int.from_bytes(data[index+33:index+37], 'little'),
                "MItemCount": int.from_bytes(data[index+62:index+66], 'little'),
                "MItemID": int.from_bytes(data[index+91:index+95], 'little'),
                "MMoney": int.from_bytes(data[index+124:index+128], 'little', signed=True),
                "BankMoney": int.from_bytes(data[index+153:index+157], 'little', signed=True)}
            drops.append(drop)
            index+=157
        table[key] = {"MDropName": dropName, "Offset": offset, "MDropItemInfos": drops}
    #print(table)

    randoKeys = []
    randoIndex = []
    index = 0
    for key in table:
        #print("{}, Offset: {}".format(key, table[key]["Offset"]))
        if not "Enemy" in meta[key]:
            randoKeys.append(key)
            randoIndex.append(index)
            index+=1
    random.shuffle(randoIndex)
    index = 0
    data = bytearray(data)
    for i in randoIndex:
        offset = table[randoKeys[index]]["Offset"]
        value = randoKeys[i].to_bytes(4,'little')
        data[offset+16] = value[0]
        data[offset+17] = value[1]
        index += 1
    with open("Game/Content/Main/Item/DataTable/DT_DropItem.uasset", 'wb') as file:
        file.write(data)

    # Techs
    skiplist = []
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

    print(techTable)
    
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
            if key in techTable and artstype < len(meta) and meta[artstype]=="MArtsType":
                table[key] = {"MArtsType": data[index+41:index+45], "offset": index}
                for i in range(2200, 2900):
                    fathom = int.from_bytes(data[index+i:index+i+4], 'little')
                    if fathom < len(meta) and meta[fathom] == "MFathomArtsId":
                        table[key]["MFathomArtsId"] = data[index+i+25:index+i+29]
                        table[key]["MDamageRefLevel"] = data[index+i+335:index+i+339]
                        table[key]["offsetFathom"] = index+i
                        break
                data[index:index+4] = meta.index(techTable[key]).to_bytes(4,'little')
                index += 3000
            elif key in skiplist:
                index += 3000
            index += 1

        for key in table:
            #print("{} = {}".format(key, techTable[key]))
            offset = table[key]["offset"]
            offsetFathom = table[key]["offsetFathom"]
            data[offset+41:offset+45] = table[techTable[key]]["MArtsType"][:]
            #data[offsetFathom+25:offsetFathom+29] = table[techTable[key]]["MFathomArtsId"][:]
            data[offsetFathom+335:offsetFathom+339] = table[techTable[key]]["MDamageRefLevel"][:]

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
            table[meta[key]] = {"offset": index-116, "key": data[index-116:index-112],
                                "ItemCategory": data[index-83:index-79],
                                "PartsID": data[index-50:index-46]}
            randoKeys.append(meta[key])
            index += 1500
        index += 1

    random.shuffle(randoKeys)
    index = 0
    data = bytearray(data)
    for key in table:
        rkey = randoKeys[index]
        offset = table[key]["offset"]
        data[offset:offset+4] = table[rkey]["key"][:]
        data[offset+33:offset+37] = table[rkey]["ItemCategory"][:]
        data[offset+66:offset+70] = table[rkey]["PartsID"][:]
        index += 1
        print("{} = {}".format(key, rkey))

    with open("Game/Content/Main/Item/DataTable/Cellest/DT_CellestItemArmor.uasset", 'wb') as file:
        file.write(data)
    
    # Shields
    data = read_file("Game_Original/Content/Main/Item/DataTable/Cellest/DT_CellestItemShield.uasset")
    meta = get_meta(data, 204, 0x40)

    # Weapons
    data = read_file("Game_Original/Content/Main/Item/DataTable/Cellest/DT_CellestItemWeapon.uasset")
    meta = get_meta(data, 455, 0x40)
