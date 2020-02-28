### 範囲埋め処理 Z軸移動 ###

# Z軸移動用AECをsummon
execute as @s[tag=!zAxis] run summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["filler_z"],Duration:1}

# 新規セル配置用アマスタのZ座標スコアをZ軸移動用AECにコピー
execute as @s[tag=!zAxis] run scoreboard players operation @e[tag=filler_z,limit=1] posZ = @s posZ

# Z軸移動を開始した印としてタグを付与
execute as @s[tag=!zAxis] run tag @s add zAxis

# X軸移動functionを呼び出し
function lifegame:prv_func/fill_cell/fill_cell_loop_x

# 後にセル化するアマスタをsummon
execute as @s at @e[tag=filler_z,limit=1] unless entity @e[distance=..0.01,tag=cell] run summon minecraft:armor_stand ~ ~ ~ {Invisible:true,Marker:true,Tags:["fill"]}
execute as @e[tag=fill] at @s run function lifegame:prv_func/new_cell

# Z軸移動用アマスタのZ座標が範囲指定用shulkerよりも大きかった場合、マイナス方向へtp
execute as @s at @e[tag=filler_z,limit=1] if score @e[tag=rangeRoot,limit=1] posZ < @e[tag=filler_z,limit=1] posZ run tp @e[tag=filler_z] ~ ~ ~-1
execute as @s at @e[tag=filler_z,limit=1] if score @e[tag=rangeRoot,limit=1] posZ < @e[tag=filler_z,limit=1] posZ run scoreboard players remove @e[tag=filler_z] posZ 1

# Z軸移動用アマスタのZ座標が範囲指定用shulkerよりも小さかった場合、プラス方向へtp
execute as @s at @e[tag=filler_z,limit=1] if score @e[tag=rangeRoot,limit=1] posZ > @e[tag=filler_z,limit=1] posZ run tp @e[tag=filler_z] ~ ~ ~1
execute as @s at @e[tag=filler_z,limit=1] if score @e[tag=rangeRoot,limit=1] posZ > @e[tag=filler_z,limit=1] posZ run scoreboard players add @e[tag=filler_z] posZ 1

# X軸移動functionを呼び出し
function lifegame:prv_func/fill_cell/fill_cell_loop_x

# Z軸移動用AECが範囲指定用shulkerと同じZ座標になるまで再帰呼び出し
execute if score @e[tag=rangeRoot,limit=1] posZ < @e[tag=filler_z,limit=1] posZ run function lifegame:prv_func/fill_cell/fill_cell_loop_z
execute if score @e[tag=rangeRoot,limit=1] posZ > @e[tag=filler_z,limit=1] posZ run function lifegame:prv_func/fill_cell/fill_cell_loop_z

# 後にセル化するアマスタをsummon
execute as @s at @e[tag=filler_z,limit=1] unless entity @e[distance=..0.01,tag=cell] run summon minecraft:armor_stand ~ ~ ~ {Invisible:true,Marker:true,Tags:["fill"]}

# summonしておいたアマスタをまとめてセル化
execute as @e[tag=fill] at @s run function lifegame:prv_func/new_cell