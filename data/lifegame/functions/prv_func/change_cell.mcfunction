### セルの生存状態切り替え処理 ###

# 選択したセルの生存状態に応じてタグを付与
execute as @s at @s positioned ~ ~-1 ~ as @e[distance=..0.1,tag=cell,scores={live=0},limit=1] run tag @s add death
execute as @s at @s positioned ~ ~-1 ~ as @e[distance=..0.1,tag=cell,scores={live=1},limit=1] run tag @s add live

# 付与されたタグと逆の状態に変更
execute as @e[tag=cell,tag=death] at @s run scoreboard players set @s live 1
execute as @e[tag=cell,tag=live] at @s run scoreboard players set @s live 0

# タグを削除
execute as @e[tag=live] run tag @s remove live
execute as @e[tag=death] run tag @s remove death

#セルの生存状態切り替え用アマスタをkill
kill @e[tag=changeCell]