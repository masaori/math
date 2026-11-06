# 対象ラベル: real_inclusion_preserves_finite_product
# Π_{j=1}^{m} (r_j)_ℂ = (Π_{j=1}^{m} r_j)_ℂ の帰納法の各行（m = 1 の 2 行、m → m+1 の 4 行）を m = 1,…,8 で確かめる。
# 有限積は def_finite_product_of_complex_numbers・def_finite_product_of_real_numbers のとおり左から順に掛けて組む。
# 帰属: ℝ の元は AA、ℂ の元は QQbar。r_ℂ := (r, 0) は QQbar(r)（実部 r・虚部 0）。浮動小数点は使わない。
# 一般の実数と一般の m は人手証明の帰納法が担う。この検査が確かめるのは、各行の式（添字・括弧・包含の位置）が
# 前の行と同じ値を持つことである。
N = 9


def incl(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ = (r, 0)。"""
    z = QQbar(r)
    assert z.real() == r and z.imag() == 0
    return z


def fprod(xs):
    """def_finite_product_of_complex_numbers / def_finite_product_of_real_numbers:
    Π_{j=1}^{1} x_j := x_1、Π_{j=1}^{m+1} x_j := (Π_{j=1}^{m} x_j) x_{m+1}。"""
    p = xs[0]
    for x in xs[1:]:
        p = p * x
    return p


samples = [
    [AA(1) / (j + 2) for j in range(N)],                          # 1 より小さい正の有理数
    [AA(-(j + 1)) if j % 2 == 0 else AA(j + 1) for j in range(N)],  # 符号が交互の整数
    [AA(2).sqrt() ** -1 for _ in range(N)],                       # def_sector_rayleigh_sup の a_+ の成分 1/√2
    [AA(j + 2).sqrt() - AA(j) / 3 for j in range(N)],             # 無理数を含む実代数的数
    [AA(0) if j == 4 else AA(3) / (j + 1) for j in range(N)],     # 0 を因子に含む列
]
eq_count = 0
for rs in samples:
    cs = [incl(r) for r in rs]
    # m = 1
    lines = [fprod(cs[:1]), incl(rs[0]), incl(fprod(rs[:1]))]
    assert lines[0] == lines[1]; eq_count += 1                     # def_finite_product_of_complex_numbers
    assert lines[1] == lines[2]; eq_count += 1                     # def_finite_product_of_real_numbers を右辺から左辺へ
    for m in range(1, N):
        lines = [
            fprod(cs[:m + 1]),                                     # Π_{j=1}^{m+1} (r_j)_ℂ
            fprod(cs[:m]) * cs[m],                                 # (Π_{j=1}^{m} (r_j)_ℂ)(r_{m+1})_ℂ
            incl(fprod(rs[:m])) * cs[m],                           # (Π_{j=1}^{m} r_j)_ℂ (r_{m+1})_ℂ
            incl(fprod(rs[:m]) * rs[m]),                           # ((Π_{j=1}^{m} r_j) r_{m+1})_ℂ
            incl(fprod(rs[:m + 1])),                               # (Π_{j=1}^{m+1} r_j)_ℂ
        ]
        assert fprod(cs[:m]) == incl(fprod(rs[:m]))                # 帰納法の仮定（r_1,…,r_m に当てる）
        for k in range(4):
            assert lines[k] == lines[k + 1]; eq_count += 1
        assert prod(cs[:m + 1]) == lines[0]                        # 比べる側: Sage の prod（独立な経路）
        assert incl(prod(rs[:m + 1])) == lines[-1]

# 否定コントロール: 包含を (r, 0) ではなく (r, 1) にした写像では、m = 2 で両辺が一致しない列が取れる。
def bad_incl(r):
    return QQbar(r) + QQbar.gen()


broken = 0
for rs in samples:
    if fprod([bad_incl(r) for r in rs[:2]]) != bad_incl(fprod(rs[:2])):
        broken += 1
assert broken == len(samples)
print(f"等号 {eq_count} 個を確かめた（{len(samples)} 通りの列、m = 1 の 2 行と帰納法の段 m → m+1（m = 1,…,{N - 1}）の 4 行）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
