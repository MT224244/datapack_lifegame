### 初期化設定 ###

# 人参棒右クリックスコア
scoreboard objectives add click minecraft.used:minecraft.carrot_on_a_stick

# スピード調節スコア
#  interval: 数値が大きいほど遅くなる
#  tick: 毎tick減算され、0になるとintervalの値に戻る
scoreboard objectives add interval dummy
scoreboard objectives add tick dummy

# セルの生存判定用スコア
#  live: 0=死、1=生
#  count: セルの周りの生存セルをカウント
scoreboard objectives add live dummy
scoreboard objectives add count dummy

# 範囲埋め用の座標保存スコア
scoreboard objectives add posX dummy
scoreboard objectives add posZ dummy

# スコア初期設定
execute unless score #initialized tick matches 1 run scoreboard players set timer interval 20
execute unless score #initialized tick matches 1 run scoreboard players set #stop tick 1
execute unless score #initialized tick matches 1 run scoreboard players set #initialized tick 1