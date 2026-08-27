# 式ペア: 有限和の添字変更（回文性）による 2^{#E_M} Z_M(1/2) = Z_M(2)。
# 帰属: ZZ と QQ。有限の代入と有限の積だけを使う。
load("_prelude.sage")
for L in BOX_WIDTHS:
    edge_count = free_edge_count(L)
    assert edge_count == ZZ(len(free_box_edges(L)))
    assert PARTITION_POLYNOMIAL[L].degree() == edge_count
    assert QQ(2) ** edge_count * VALUE_AT_ONE_HALF[L] == QQ(VALUE_AT_TWO[L])
print("RESULT: PASS")
