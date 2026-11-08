# 対象ラベル: product_of_real_powers_is_power_of_product
# a^m b^m = (ab)^m の帰納法の各行（m = 0 の 3 行、m → m+1 の 4 行）を m = 0,…,8 で確かめる。
# 冪は def_power_of_real_number のとおり a^0 := 1、a^{m+1} := a^m a で組む（Sage の ** は比べる側にだけ使う）。
# 帰属: a, b は QQ の具体値と、def_sector_rayleigh_sup が当てる 1/√2 ∈ AA（実代数的数）と 2、1/2。等号はどちらも厳密。
# 一般の実数 a, b と一般の m は人手証明の帰納法が担う。
N = 9


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


s = 1 / AA(2).sqrt()
samples = [QQ(0), QQ(1), QQ(-1), QQ(3) / 7, QQ(-5) / 2, QQ(11)]
pairs = [(AA(a), AA(b)) for a in samples for b in samples] + [(s, s), (AA(2), AA(1) / 2)]
eq_count = 0
for a, b in pairs:
    one = AA(1)
    # m = 0 の 3 行
    lines = [rpow(a, 0) * rpow(b, 0), one * one, one, rpow(a * b, 0)]
    for u, w in zip(lines, lines[1:]):
        assert u == w; eq_count += 1
    for m in range(0, N):
        # 帰納法の仮定 a^m b^m = (ab)^m を先に確かめる
        assert rpow(a, m) * rpow(b, m) == rpow(a * b, m)
        lines = [
            rpow(a, m + 1) * rpow(b, m + 1),
            (rpow(a, m) * a) * (rpow(b, m) * b),        # def_power_of_real_number を 2 箇所へ
            (rpow(a, m) * rpow(b, m)) * (a * b),        # (pq)(rs) = (pr)(qs)
            rpow(a * b, m) * (a * b),                   # 帰納法の仮定
            rpow(a * b, m + 1),                         # def_power_of_real_number を右辺から左辺へ
        ]
        for u, w in zip(lines, lines[1:]):
            assert u == w; eq_count += 1
        assert lines[0] == (a * b) ** (m + 1)            # 比べる側: Sage の冪（独立な経路）

# def_sector_rayleigh_sup の当て方
for M in range(1, N):
    assert rpow(s, M) * rpow(s, M) == rpow(s * s, M) == rpow(AA(1) / 2, M)
    assert rpow(AA(2), M) * rpow(AA(1) / 2, M) == rpow(AA(1), M) == 1

# 否定コントロール: 帰納法の段の 2 行目で (ab) の代わりに (a + b) を掛けると、一般には等号が崩れる。
broken = 0
for a, b in [(AA(3) / 7, AA(-5) / 2), (AA(11), AA(3) / 7), (s, s), (AA(2), AA(1) / 2)]:
    for m in range(0, N):
        if (rpow(a, m) * rpow(b, m)) * (a + b) != rpow(a * b, m + 1):
            broken += 1
assert broken == 4 * N
print(f"等号 {eq_count} 個を確かめた（{len(pairs)} 組の (a, b)、m = 0 の 3 行と帰納法の段 m → m+1（m = 0,…,{N - 1}）の 4 行）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
