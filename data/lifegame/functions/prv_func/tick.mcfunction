### 毎tickループさせる処理 ###

# 人参棒右クリック時
execute as @a[scores={click=1..}] if score #stop tick matches 0 as @a[scores={click=1..}] run tag @s add stop
execute as @a[scores={click=1..}] if score #stop tick matches 1 as @a[scores={click=1..}] run tag @s add start
execute as @a[scores={click=1..},tag=stop] run scoreboard players set #stop tick 1
execute as @a[scores={click=1..},tag=start] run scoreboard players set #stop tick 0
execute as @a[scores={click=1..},tag=start] run tag @s remove start
execute as @a[scores={click=1..},tag=stop] run tag @s remove stop
execute as @a[scores={click=1..}] run scoreboard players reset @s click


# セルアマスタの座標が空気ブロックになったらセル削除
execute as @e[tag=cell] at @s if block ~ ~ ~ minecraft:air run kill @s


# 範囲指定用shulker配置処理
execute as @e[type=armor_stand,tag=rangeRoot] at @s run function lifegame:prv_func/range_selector


# 範囲指定用shulkerがいた場合範囲埋め用functionへ
# いなかった場合新規セル配置用functionへ
execute as @e[tag=newCell] at @s if entity @e[tag=rangeRoot] run function lifegame:prv_func/fill_cell/fill_cell_main
execute as @e[tag=newCell] at @s run function lifegame:prv_func/new_cell


# セルの生存状態に応じてブロックを再設置
# ここのブロックidを変更すれば設置されるブロックを変えられます
# 上が死滅セルのブロック、下が生存セルのブロックです
# (例) execute as @e[tag=cell,scores={live=0}] at @s unless block ~ ~ ~ minecraft:smooth_stone run setblock ~ ~ ~ minecraft:smooth_stone replace
execute as @e[tag=cell,scores={live=0}] at @s unless block ~ ~ ~ minecraft:black_concrete run setblock ~ ~ ~ minecraft:black_concrete replace
execute as @e[tag=cell,scores={live=1}] at @s unless block ~ ~ ~ minecraft:lime_concrete run setblock ~ ~ ~ minecraft:lime_concrete replace


# セルの周りの生存セル数をcountスコアに代入
execute if score timer tick matches ..0 as @e[tag=cell] at @s store result score @s count if entity @e[distance=0.1..1.5,scores={live=1}]

# ライフゲームのルール通りに生存状態を変更
execute if score timer tick matches ..0 as @e[tag=cell,scores={live=1,count=0..1}] run scoreboard players set @s live 0
execute if score timer tick matches ..0 as @e[tag=cell,scores={live=1,count=2..3}] run scoreboard players set @s live 1
execute if score timer tick matches ..0 as @e[tag=cell,scores={live=1,count=4..}] run scoreboard players set @s live 0
execute if score timer tick matches ..0 as @e[tag=cell,scores={live=0,count=3}] run scoreboard players set @s live 1


# セルの生存状態切り替え処理
execute as @e[tag=changeCell] at @s run function lifegame:prv_func/change_cell

# インターバルの下限、上限を設定
execute if score timer interval matches ..0 run scoreboard players set timer interval 1
execute if score timer interval matches 101.. run scoreboard players set timer interval 100

# tickスコアが0以下になったとき、intervalの値まで戻す
execute if score timer tick matches ..0 run scoreboard players operation timer tick = timer interval

# tickスコア減算
execute if score #stop tick matches 0 run scoreboard players remove timer tick 1

# 再生状態をアクションバーに表示
execute if score #stop tick matches 1 run title @a actionbar [{"text":"▬停止中","color":"aqua","bold":true},{"text":" [Interval:","color":"white"},{"score":{"name":"timer","objective":"interval"},"color":"white"},{"text":"]","color":"white"}]
execute if score #stop tick matches 0 run title @a actionbar [{"text":"▶再生中","color":"red","bold":true},{"text":" [Interval:","color":"white"},{"score":{"name":"timer","objective":"interval"},"color":"white"},{"text":"]","color":"white"}]