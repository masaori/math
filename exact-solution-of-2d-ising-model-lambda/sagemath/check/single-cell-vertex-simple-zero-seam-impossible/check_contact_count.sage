# 対象ラベル: claim_single_cell_vertex_simple_zero_seam_impossible
# 辺長一の唯一の頂点を通過する位置の接触対数を整数で検算する。
for length in range(1, 9):
    pass_vertices = [ZZ(0)] * length
    contact_pairs = sum(ZZ(pass_vertices[i] == pass_vertices[j])
                        for i in range(length) for j in range(i + 1, length))
    assert contact_pairs == ZZ(length * (length - 1) // 2)
    assert (contact_pairs == 0) == (length == 1)
print('RESULT: PASS; zero contact forces one step at L=1')
