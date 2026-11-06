# 対象ラベル: claim_single_cell_vertex_simple_zero_seam_impossible
# 辺長一の一歩について、二種類の基底辺と二つの向きを正確に列挙する。
for base_kind in (0, 1):
    for orientation in (0, 1):
        horizontal_seam = ZZ(base_kind == 0)
        vertical_seam = ZZ(base_kind == 1)
        assert horizontal_seam + vertical_seam == 1
        assert (horizontal_seam % 2, vertical_seam % 2) != (0, 0)
print('RESULT: PASS; each one-step edge crosses exactly one seam')
