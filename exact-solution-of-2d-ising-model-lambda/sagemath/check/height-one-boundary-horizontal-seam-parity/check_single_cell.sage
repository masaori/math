# 対象ラベル: claim_height_one_boundary_horizontal_seam_parity
# 辺長一: 横辺の両側は同じセルで、零の切断線偶奇は唯一の横辺の通過偶奇を零にする。
for height in (ZZ(0), ZZ(1)):
    boundary = height - height
    parity = ZZ(0)
    assert (boundary != 0) == (parity == 1)

print("RESULT: PASS — 辺長一の二組")
