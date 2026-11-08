# 対象ラベル: power_of_real_one_is_one
# 1^m = 1 の帰納法の各行（m = 0 の 1 行、m → m+1 の 3 行）を m = 0,…,20 で確かめる。
# 冪は def_power_of_real_number のとおり a^0 := 1、a^{m+1} := a^m a で組む（Sage の ** は比べる側にだけ使う）。
# 帰属: 1 ∈ QQ と 1 ∈ AA。等号は厳密。一般の m は人手証明の帰納法が担う。
N = 21


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


eq_count = 0
for one in [QQ(1), AA(1)]:
    assert rpow(one, 0) == one; eq_count += 1                     # m = 0 の 1 行
    for m in range(0, N):
        assert rpow(one, m) == one                                 # 帰納法の仮定
        lines = [rpow(one, m + 1), rpow(one, m) * one, one * one, one]
        for u, w in zip(lines, lines[1:]):
            assert u == w; eq_count += 1
        assert one ** (m + 1) == 1                                 # 比べる側: Sage の冪

# 否定コントロール: 底を 1 から 1 以外へ取り違えると、m ≥ 1 で 1 にならない。
broken = 0
for a in [QQ(2), QQ(-1) / 3, 1 / AA(2).sqrt()]:
    for m in range(1, N):
        if rpow(a, m) != 1:
            broken += 1
assert broken == 3 * (N - 1)
print(f"等号 {eq_count} 個を確かめた（1 ∈ QQ と 1 ∈ AA、m = 0 の 1 行と帰納法の段 m → m+1（m = 0,…,{N - 1}）の 3 行）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
