### 範囲埋め処理 X軸移動 ###

# X軸移動用AECをsummon
execute as @s[tag=!xAxis] at @e[tag=filler_z] run summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["filler_x"],Duration:1}

# 新規セル配置用アマスタのX座標スコアをX軸移動用AECにコピー
execute as @s[tag=!xAxis] run scoreboard players operation @e[tag=filler_x,limit=1] posX = @s posX

# X軸移動を開始した印としてタグを付与
execute as @s[tag=!xAxis] run tag @s add xAxis

# 後にセル化するアマスタをsummon
execute as @s at @e[tag=filler_x,limit=1] unless entity @e[distance=..0.01,tag=cell] run summon minecraft:armor_stand ~ ~ ~ {Invisible:true,Marker:true,Tags:["fill"]}
execute as @e[tag=fill] at @s run function lifegame:prv_func/new_cell

# X軸移動用アマスタのX座標が範囲指定用shulkerよりも大きかった場合、マイナス方向へtp
execute as @s at @e[tag=filler_x,limit=1] if score @e[tag=rangeRoot,limit=1] posX < @e[tag=filler_x,limit=1] posX run tp @e[tag=filler_x] ~-1 ~ ~
execute as @s at @e[tag=filler_x,limit=1] if score @e[tag=rangeRoot,limit=1] posX < @e[tag=filler_x,limit=1] posX run scoreboard players remove @e[tag=filler_x] posX 1

# X軸移動用アマスタのX座標が範囲指定用shulkerよりも小さかった場合、プラス方向へtp
execute as @s at @e[tag=filler_x,limit=1] if score @e[tag=rangeRoot,limit=1] posX > @e[tag=filler_x,limit=1] posX run tp @e[tag=filler_x] ~1 ~ ~
execute as @s at @e[tag=filler_x,limit=1] if score @e[tag=rangeRoot,limit=1] posX > @e[tag=filler_x,limit=1] posX run scoreboard players add @e[tag=filler_x] posX 1

# X軸移動用AECが範囲指定用shulkerと同じX座標になるまで再帰呼び出し
execute if score @e[tag=rangeRoot,limit=1] posX < @e[tag=filler_x,limit=1] posX run function lifegame:prv_func/fill_cell/fill_cell_loop_x
execute if score @e[tag=rangeRoot,limit=1] posX > @e[tag=filler_x,limit=1] posX run function lifegame:prv_func/fill_cell/fill_cell_loop_x

# 後にセル化するアマスタをsummon
execute as @s at @e[tag=filler_x,limit=1] unless entity @e[distance=..0.01,tag=cell] run summon minecraft:armor_stand ~ ~ ~ {Invisible:true,Marker:true,Tags:["fill"]}
execute as @e[tag=fill] at @s run function lifegame:prv_func/new_cell

# X軸移動用AECをkill
kill @e[tag=filler_x]

# X軸移動が終了したのでタグを削除
tag @s remove xAxis