# ===== 按讲台纵深档位 (#o_depth: 0=29×21, 1=35×21, 2=41×21) 重建地面与两侧后翼护壁 =====
execute if score #o_depth sb_var matches 0 run function sb:arena/floor_0
execute if score #o_depth sb_var matches 1 run function sb:arena/floor_1
execute if score #o_depth sb_var matches 2 run function sb:arena/floor_2
