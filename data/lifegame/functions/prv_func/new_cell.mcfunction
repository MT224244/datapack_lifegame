### 新規セル設置処理 ###

# 生存状態をセット
scoreboard players set @s live 0

# 不要なタグを削除
tag @s remove newCell
tag @s remove fill

# セル化タグを付与
tag @s add cell