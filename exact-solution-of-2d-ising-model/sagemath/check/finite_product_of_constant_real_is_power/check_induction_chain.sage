# 対象ラベル: finite_product_of_constant_real_is_power
# Π_{j=1}^{m} r = r^m の帰納法の各行（m = 1 の 4 行、m → m+1 の 3 行）を m = 1,…,8 で確かめる。
# 有限積は def_finite_product_of_real_numbers のとおり左から順に掛けて組み、
# 冪は def_power_of_real_number のとおり a^0 := 1、a^{m+1} := a^m a で組む（Sage の ** は比べる側にだけ使う）。
# 帰属: r は QQ の具体値と、def_sector_rayleigh_sup が当てる 1/√2 ∈ AA（実代数的数）。等号はどちらも厳密。
# 一般の実数 r と一般の m は人手証明の帰納法が担う。
N = 9


def fprod(rs):
    """def_finite_product_of_real_numbers: Π_{j=1}^{1} r_j := r_1、Π_{j=1}^{m+1} r_j := (Π_{j=1}^{m} r_j) r_{m+1}。"""
    p = rs[0]
    for r in rs[1:]:
        p = p * r
    return p


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


samples = [QQ(0), QQ(1), QQ(-1), QQ(3) / 7, QQ(-5) / 2, QQ(11), 1 / AA(2).sqrt()]
eq_count = 0
for r in samples:
    one = r.parent()(1)
    # m = 1 の 4 行
    lines = [fprod([r]), r, one * r, rpow(r, 0) * r, rpow(r, 1)]
    for a, b in zip(lines, lines[1:]):
        assert a == b; eq_count += 1
    for m in range(1, N):
        # m → m+1 の 3 行（帰納法の仮定 Π_{j=1}^{m} r = r^m を先に確かめる）
        assert fprod([r] * m) == rpow(r, m)
        lines = [fprod([r] * (m + 1)), fprod([r] * m) * r, rpow(r, m) * r, rpow(r, m + 1)]
        for a, b in zip(lines, lines[1:]):
            assert a == b; eq_count += 1
        assert lines[0] == r ** (m + 1)                               # 比べる側: Sage の冪（独立な経路）

# def_sector_rayleigh_sup の当て方（m → M_col、r → 1/√2）: (1/√2)^M の 2 乗は 2^{-M}。
s = 1 / AA(2).sqrt()
for M in range(1, N):
    assert fprod([s] * M) == rpow(s, M) and rpow(s, M) ** 2 == AA(2) ** (-M)

# 否定コントロール: 帰納法の段の 3 行目を r^{m+1} の代わりに r^m とすると、r ∉ {0, 1} では等号が崩れる。
broken = 0
for r in [QQ(3) / 7, QQ(-5) / 2, QQ(11), s]:
    for m in range(1, N):
        if rpow(r, m) * r != rpow(r, m):
            broken += 1
assert broken == 4 * (N - 1)
print(f"等号 {eq_count} 個を確かめた（{len(samples)} 通りの r、m = 1 の 4 行と帰納法の段 m → m+1（m = 1,…,{N - 1}）の 3 行）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
