# 対象ラベル: finite_product_of_positive_reals_is_positive
# すべての r_j > 0 なら Π_{j=1}^{m} r_j > 0 の帰納法の各行（m = 1 の 2 行、m → m+1 の前置きの 2 つと 2 行）を
# m = 1,…,8 で確かめる。有限積は def_finite_product_of_real_numbers のとおり左から順に掛けて組む。
# 帰属: QQ（正の有理数の具体的な列を複数通り取る）。等号は厳密、不等号は QQ の順序で判定する。
# 一般の実数 r_j > 0 については人手証明の帰納法が担う。この検査が確かめるのは、各行の式（添字・括弧・項の並び）が
# 前の行と同じ値を持つことと、不等号の行が成り立つことである。
N = 9


def fprod(rs):
    """def_finite_product_of_real_numbers: Π_{j=1}^{1} r_j := r_1、Π_{j=1}^{m+1} r_j := (Π_{j=1}^{m} r_j) r_{m+1}。"""
    p = rs[0]
    for r in rs[1:]:
        p = p * r
    return p


samples = [
    [QQ(1) / (j + 2) for j in range(N)],             # 1 より小さい正の数
    [QQ(j + 1) for j in range(N)],                   # 1 以上の整数
    [QQ(3) / 7 if j % 2 == 0 else QQ(11) / 2 for j in range(N)],
    [QQ(j + 2) + 1 / QQ(j + 2) for j in range(N)],   # trace_of_check_Vprime の 2cosh(γ/2) の形: γ/2 = log y なら 2cosh(γ/2) = y + 1/y（y ∈ QQ_{>0}）
]
eq_count = 0
ineq_count = 0
for rs in samples:
    assert all(r > 0 for r in rs)
    # m = 1
    l0, l1 = fprod(rs[:1]), rs[0]
    assert l0 == l1; eq_count += 1                                    # def_finite_product_of_real_numbers
    assert l1 > 0; ineq_count += 1                                    # 仮定 r_1 > 0
    for m in range(1, N):
        hprod = fprod(rs[:m])
        assert hprod > 0                                              # 帰納法の仮定 Π_{j=1}^{m} r_j > 0
        assert rs[m] > 0                                              # 仮定 r_{m+1} > 0
        lines = [fprod(rs[:m + 1]), hprod * rs[m]]
        assert lines[0] == lines[1]; eq_count += 1                    # def_finite_product_of_real_numbers
        assert lines[1] > 0; ineq_count += 1                          # ℝ で a > 0, b > 0 なら ab > 0
        assert prod(rs[:m + 1]) == lines[0]                           # 比べる側: Sage の prod（独立な経路）

# 否定コントロール: 仮定を 1 つ外す（ある r_k を負にする）と、積の符号が負になる列が取れる。
broken = 0
for m in range(1, N):
    rs = [QQ(j + 1) for j in range(m + 1)]
    rs[m] = -rs[m]
    if not (fprod(rs) > 0):
        broken += 1
assert broken == N - 1
print(f"等号 {eq_count} 個、不等号 {ineq_count} 個を確かめた（4 通りの列、m = 1 の 2 行と帰納法の段 m → m+1（m = 1,…,{N - 1}））")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
