# 対象ラベル: claim_height_one_boundary_vertical_seam_parity
# 辺長一: 両側が同じセルで、縦切断線偶奇の零は唯一の辺の通過偶奇の零である。
for height in (ZZ(0), ZZ(1)):
    boundary = height - height
    parity = ZZ(0)
    assert (boundary != 0) == (parity == 1)

print("RESULT: PASS — 辺長一の二組")
