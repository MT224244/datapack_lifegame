### 範囲指定用shulker配置処理 ###

# 範囲指定用shulkerが2つ以上配置されようとした場合、双方削除
execute as @e[type=shulker,tag=rangeRoot] if entity @e[type=armor_stand,tag=rangeRoot] run kill @e[tag=rangeRoot]

# 範囲指定用アマスタの座標に範囲指定用shulkerを召喚し、アマスタをkill
execute as @e[type=armor_stand,tag=rangeRoot] at @s unless entity @e[distance=..0.01,type=minecraft:shulker,tag=rangeRoot] run summon minecraft:shulker ~ ~ ~ {NoAI:true,Silent:true,Invulnerable:true,Glowing:true,Health:1.0f,DeathTime:19s,Tags:["rangeRoot"]}
execute as @e[type=armor_stand,tag=rangeRoot] run kill @s

# 範囲指定用shulkerのX、Z座標をスコアに代入
execute as @e[type=shulker,tag=rangeRoot] store result score @s posX run data get entity @s Pos[0] 1
execute as @e[type=shulker,tag=rangeRoot] store result score @s posZ run data get entity @s Pos[2] 1