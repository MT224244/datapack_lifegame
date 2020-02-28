### 必要なアイテムのgive ###

# 設置した座標をセルにするアマスタ
give @s minecraft:armor_stand{display:{Name:"{\"text\":\"新規セル\",\"bold\":true,\"italic\":false}",Lore:["§7設置した座標をセルにします","§7範囲指定と組み合わせることで","§7一斉に設置することもできます"]},EntityTag:{Invisible:true,NoGravity:true,Marker:true,Tags:["newCell"]}} 1

# 設置した座標の真下のセルの生存状態を切り替えるアマスタ
give @s minecraft:armor_stand{display:{Name:"{\"text\":\"セル切り替え\",\"bold\":true,\"italic\":false}",Lore:["§7セルの生存状態を切り替えます"]},EntityTag:{Invisible:true,NoGravity:true,Marker:true,Tags:["changeCell"]}} 1

# 範囲指定用のshulkerを設置するアマスタ
give @s minecraft:armor_stand{display:{Name:"{\"text\":\"範囲指定\",\"bold\":true,\"italic\":false}",Lore:["§7設置したあと埋めたい範囲の対角に","§7新規セルを設置すると","§7範囲内にセルを設置します"]},EntityTag:{Invisible:true,NoGravity:true,Marker:true,Tags:["rangeRoot"]}} 1

# 再生/停止を切り替える人参棒
give @s minecraft:carrot_on_a_stick{display:{Name:"{\"text\":\"再生/停止切り替え\",\"bold\":true,\"italic\":false}",Lore:["§7右クリックで再生/停止を切り替えます"]}} 1