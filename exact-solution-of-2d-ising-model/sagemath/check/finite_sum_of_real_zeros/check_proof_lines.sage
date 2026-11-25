# 対象ラベル: finite_sum_of_real_zeros
# m ∈ ℤ_{≥0} について Σ_{j=1}^{m} 0 = 0 の証明の各行（m = 0 の 1 行、m = 1 の 1 行、帰納法の段 m → m+1 の 3 行）を m = 0,…,40 で確かめる。
# 有限和は def_finite_sum_of_real_numbers のとおり（Σ^{0} := 0、Σ^{1} := r_1、Σ^{m+1} := Σ^{m} + r_{m+1}）左から足して組む。帰属: QQ（厳密な比較）。


def fsum(rs):
    """def_finite_sum_of_real_numbers: Σ_{j=1}^{0} r_j := 0、Σ_{j=1}^{1} r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}。"""
    rs = list(rs)
    if len(rs) == 0:
        return QQ(0)
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


cnt = 0
S = lambda m: fsum([QQ(0)] * m)
L = [S(0), QQ(0)]                                    # m = 0: Σ^{0} := 0
assert L[0] == L[1]; cnt += 1
L = [S(1), QQ(0)]                                    # m = 1: Σ^{1} r_j := r_1（r_1 → 0）
assert L[0] == L[1]; cnt += 1
for m in range(1, 40):
    assert S(m) == 0                                 # 帰納法の仮定
    L = [S(m + 1), S(m) + QQ(0), QQ(0) + QQ(0), QQ(0)]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
for m in range(0, 41):
    assert S(m) == 0; cnt += 1                       # 主張
    assert S(m) == sum([QQ(0)] * m)                  # Sage の sum（別の経路）
# 否定コントロール: 項の一つを 1 にした和は 0 にならない
assert fsum([QQ(0)] * 3 + [QQ(1)]) != 0
print(f"finite_sum_of_real_zeros: 等号 {cnt} 個 PASS")
