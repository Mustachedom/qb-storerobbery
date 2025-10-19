PoliceCount = 0
RegisterConfig = {
    cashMin = 150, -- per register
    cashMax = 300, -- per register
    comboChance = 15, -- % chance to get the safe code from a cash register
    registerResetTime = 30 * 60 * 1000, -- time it takes for a register to reset and be robbed again
    comboResetTime = 15 * 60 * 1000, -- time it takes for a safe combo to reset and be able to be gotten again
}

SafeConfig = {
    cashMin = 800, -- per safe
    cashMax = 1500, -- per safe
    safeResetTime = 60 * 60 * 1000, -- time it takes for a safe to reset and be robbed again
    thermiteCooldownTime = {min = 30, max = 240}, -- seconds it takes to thermite the safe
    resetThermite = 60 * 10 * 1000, -- time it will remove thermited status if not picked up 
}

Registers = {
    {  loc = vector4(-46.87, -1757.62, 29.42, 47.59),   zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 1,  camId = 4 },
    {  loc = vector4(-48.04, -1759.21, 29.42, 47.16),   zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 1,  camId = 4 },
    {  loc = vector4(-1486.26, -378.0, 40.16, 134.17),  zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 2,  camId = 5 },
    {  loc = vector4(-1222.03, -908.32, 12.32, 33.75),  zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 3,  camId = 6 },
    {  loc = vector4(-706.08, -915.42, 19.21, 90.0),    zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 4,  camId = 7 },
    {  loc = vector4(-706.16, -913.5, 19.21 , 90.0),    zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 4,  camId = 7 },
    {  loc = vector4(24.47, -1344.99, 29.49, 270.0),    zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 5,  camId = 8 },
    {  loc = vector4(24.45, -1347.37, 29.49, 270.0),    zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 5,  camId = 8 },
    {  loc = vector4(1134.15, -982.53, 46.41, 277.00),  zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 6,  camId = 9 },
    {  loc = vector4(1165.05, -324.49, 69.2, 99.0),     zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 7,  camId = 10 },
    {  loc = vector4(1164.7, -322.58, 69.2 , 99.0),     zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 7,  camId = 10 },
    {  loc = vector4(373.14, 328.62, 103.56, 255.13),   zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 8,  camId = 11 },
    {  loc = vector4(372.57, 326.42, 103.56, 255.13),   zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 8,  camId = 11 },
    {  loc = vector3(-1818.9, 792.9, 138.08),           zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 9,  camId = 12 },
    {  loc = vector3(-1820.17, 794.28, 138.08),         zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 9,  camId = 12 },
    {  loc = vector3(-2966.46, 390.89, 15.04),          zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 10, camId = 13 },
    {  loc = vector3(-3041.14, 583.87, 7.9),            zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 11, camId = 14 },
    {  loc = vector3(-3038.92, 584.5, 7.9),             zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 11, camId = 14 },
    {  loc = vector3(-3244.56, 1000.14, 12.83),         zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 12, camId = 15 },
    {  loc = vector3(-3242.24, 999.98, 12.83),          zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 12, camId = 15 },
    {  loc = vector3(549.42, 2669.06, 42.15),           zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 13, camId = 16 },
    {  loc = vector3(549.05, 2671.39, 42.15),           zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 13, camId = 16 },
    {  loc = vector3(1165.9, 2710.81, 38.15),           zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 14, camId = 17 },
    {  loc = vector3(2676.02, 3280.52, 55.24),          zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 15, camId = 18 },
    {  loc = vector3(2678.07, 3279.39, 55.24),          zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 15, camId = 18 },
    {  loc = vector3(1958.96, 3741.98, 32.34),          zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 16, camId = 19 },
    {  loc = vector3(1960.13, 3740.0, 32.34),           zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 16, camId = 19 },
    {  loc = vector3(1728.86, 6417.26, 35.03),          zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 17, camId = 20 },
    {  loc = vector3(1727.85, 6415.14, 35.03),          zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 17, camId = 20 },
    {  loc = vector3(-161.07, 6321.23, 31.5),           zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 18, camId = 27 },
    {  loc = vector3(160.52, 6641.74, 31.6),            zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 19, camId = 28 },
    {  loc = vector3(162.16, 6643.22, 31.6),            zones = {length = 1.0, width = 1.0,},robbed = false,  busy = false, safeKey = 19, camId = 29 },
}

GlobalState.StoreRobberyRegisters = Registers

Safes = {
    {  loc = vector4(-43.77, -1748.3, 29.09, 49.02),     rotation = vector3(100.0,50.0,0.0),    zones = {length = 1.5, width = 0.9}, busy = false, thermited = false, robbed = false, camId = 4 },
    {  loc = vector4(-1478.94, -375.5, 39.16, 229.5),    rotation = vector3(-100.0,-50.0,0.0),  zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 5 },
    {  loc = vector4(-1220.85, -916.05, 11.32, 120.5),   rotation = vector3(30,100,0.0),        zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 6 },
    {  loc = vector4(-710.03, -904.33, 18.88, 90.0),     rotation = vector3(90.0,90.0,0.0),     zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 7 },
    {  loc = vector4(27.99, -1338.88, 29.2, 180.0),      rotation = vector3(90.0,0.0,0.0),      zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 8 },
    {  loc = vector4(1126.77, -980.1, 45.41, 95.00),     rotation = vector3(90.0,0.0,0.0),      zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 9 },
    {  loc = vector4(1159.24, -314.27, 68.84, 98.00),    rotation = vector3(90.0,90.0,0.0),     zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 10 },
    {  loc = vector4(378.05, 333.73, 103.19, 255.13),    rotation = vector3(90.0,0.0,0.0),      zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 11 },
    {  loc = vector3(-1829.28, 798.4, 137.87),           rotation = vector3(90.0,120.0,0.0),    zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 12 },
    {  loc = vector3(-2959.64, 387.08, 14.04),           rotation = vector3(90.0,180.0,0.0),    zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 13 },
    {  loc = vector3(-3048.08, 585.33, 7.55),            rotation = vector3(90.0,90.0,0.0),     zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 14 },
    {  loc = vector3(-3250.36, 1004.23, 12.44),          rotation = vector3(90.0,90.0,0.0),     zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 15 },
    {  loc = vector3(546.67, 2662.52, 41.78),            rotation = vector3(90.0,180.0,0.0),    zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 16 },
    {  loc = vector3(1169.31, 2717.79, 37.15),           rotation = vector3(90.0,-90.0,0.0),    zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 17 },
    {  loc = vector3(2672.38, 3286.57, 54.81),           rotation = vector3(90.0,40.0,0.0),     zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 18 },
    {  loc = vector3(1958.93, 3749.08, 31.96),           rotation = vector3(90.0,20.0,0.0),     zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 19 },
    {  loc = vector3(1734.77, 6421.21, 34.65),           rotation = vector3(90.0,-20.0,0.0),    zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 20 },
    {  loc = vector3(-168.40, 6318.80, 30.58),           rotation = vector3(90.0,180.0,0.0),    zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 27 }, -- addon maps needed for paleto
    {  loc = vector3(168.95, 6644.74, 31.70),            rotation = vector3(90.0,180.0,0.0),    zones = {length = 1.0, width = 1.0}, busy = false, thermited = false, robbed = false, camId = 30 }, -- addon maps needed for paleto
}

GlobalState.StoreRobberySafes = Safes