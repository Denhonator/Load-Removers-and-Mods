using Harmony;
using Il2Cpp;
using Il2CppInterop.Runtime.InteropTypes.Arrays;
using Il2CppMessagePack.Formatters;
using Il2CppTMPro;
using MelonLoader;
using SF2;
using UnityEngine;
using static MelonLoader.MelonLogger;

[HarmonyLib.HarmonyPatch(typeof(MainGame), "GetRelationArtName", new Type[] { typeof(int), typeof(bool) })]
class ComboName2
{
    static void Postfix(int artno, bool isLast, ref string __result)
    {
        if (SF2Combo.comboNames.ContainsKey(__result))
        {
            string[] parts = SF2Combo.comboNames[__result].Split(',');
            if (parts.Length == 2 && isLast)
            {
                __result = parts[1];
            }
            else if (parts.Length == 2 && !isLast)
            {
                __result = parts[0];
            }
        }
    }
}

//[HarmonyLib.HarmonyPatch(typeof(MessageLoader), "Decompress")]
//class Load
//{
//    static int id = 0;
//    static void Postfix(Il2CppStructArray<byte> data, Il2CppStructArray<byte> __result)
//    {
//        File.WriteAllBytes($"Decompressed/{id}original.bin", data);
//        File.WriteAllBytes($"Decompressed/{id}decompressed.bin", __result);
//        id++;
//    }
//}

namespace SF2
{
    public class SF2Combo : MelonMod
    {
        public static Dictionary<string, string> comboNames = new Dictionary<string, string>();
        public override void OnInitializeMelon()
        {
            base.OnInitializeMelon();
            try
            {
                string[] s = File.ReadAllLines("combo_names.txt");
                foreach (string line in s)
                {
                    string[] parts = line.Split(',', 2);
                    if (parts.Length == 2)
                    {
                        comboNames[parts[0]] = parts[1];
                    }
                }
                Msg("Combo names loaded.");
            }
            catch (Exception e)
            {
                Msg($"Error reading combo_names.txt: {e.Message}");
            }
        }
    }
}