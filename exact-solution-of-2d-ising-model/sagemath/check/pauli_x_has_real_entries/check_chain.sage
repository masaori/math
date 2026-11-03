# 対象ラベル: pauli_x_has_real_entries
# 人手の鎖 σ^x = (0_C 1_C; 1_C 0_C) = (ι(0) ι(1); ι(1) ι(0)) を 1 行ずつ確かめ、各成分が r_C（r ∈ QQ ⊂ ℝ、虚部 0）であることを確かめる。
# ι_{R→C}(r) := (r, 0) は QQ(i) では r + 0·i である。対照: 純虚数の成分を持つ σ^y は虚部 0 でない成分を持つ。
load("../../_shared/pauli_sites_exact.sage")

def iota(r):
    r = QQ(r)
    return KG([r, 0])        # (r, 0)

lines = [
    SX,
    matrix(KG, [[0,1],[1,0]]),                 # pauli_matrix_products
    matrix(KG, [[iota(0), iota(1)], [iota(1), iota(0)]]),   # inclusion_rr_to_cc の略記
]
check_chain(lines, "pauli_x_has_real_entries")
R = matrix(QQ, [[0,1],[1,0]])        # 人手が取る r（成分ごと）
for p in range(2):
    for q in range(2):
        assert SX[p, q] == iota(R[p, q])
        assert SX[p, q].imag() == 0
assert any(SY[p, q].imag() != 0 for p in range(2) for q in range(2))
print(f"  {len(lines) - 1} 段と 4 成分の r_C の形が成り立つ（QQ(i) の厳密計算）")
print("  対照 1 件: σ^y は虚部 0 でない成分を持つ")
print("RESULT: PASS")
