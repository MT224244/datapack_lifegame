### 範囲埋め処理 ###

# 新規セル配置用アマスタを範囲指定用shulkerのy座標に合わせる
execute store result entity @s Pos[1] double 1 run data get entity @e[tag=rangeRoot,limit=1] Pos[1] 1

# タイトル表示
title @a times 0 2147483647 0
title @a subtitle {"text":"進捗はF3キーからエンティティ数をご確認ください"}
title @a title {"text":"セル配置中…"}

# 新規セル配置用アマスタのX、Z座標をスコアに代入
execute store result score @s posX run data get entity @s Pos[0] 1
execute store result score @s posZ run data get entity @s Pos[2] 1

# 再帰呼び出しで範囲埋め開始
execute as @s at @s run function lifegame:prv_func/fill_cell/fill_cell_loop_z

# 新規セル配置用アマスタ、範囲指定用shulkerはもういらないのでkill
kill @s
kill @e[tag=rangeRoot]

# タイトル表示リセット
title @a reset