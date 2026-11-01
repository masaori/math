# 対象ラベル: real_exp_strictly_increasing
# Step 1（a > 0 なら exp(a) > 1）を確かめる。
#   ‖[E_N(a)] - [E(a)]‖ = ‖[E_N(a) - E(a)]‖ = |E_N(a) - E(a)| → 0
#   ‖[E_N(a)] - [exp(a)]‖ = ‖[E_N(a) - exp(a)]‖ = |E_N(a) - exp(a)| → 0
#   （極限の一意性より E(a) = exp(a)）
#   exp(a) = E(a) ≥ E_1(a) = 1 + a > 1
# 帰属: E_N(a) は数の和として QQ[a] と具体の a ∈ QQ で厳密に作る（行列は使わない。本文 real_exp_series_converges の E_N）。
# E(a) と exp(a) は極限なので QQ に収まらない（R への脱出）。exp(a) は本文の exp（1 行 1 列の行列の部分和の成分）を
# 囲むボール body_real_exp_ball で持つ。E(a) は E_N(a) の極限なので、ボール E_N(a) ± 尾の上界で持つ。
load("../../_shared/one_by_one_matrix.sage")


def E_N(a, N):
    """real_exp_series_converges の E_N(a) = Σ_{m=0}^{N} a^m/m!（a^0 := 1, 0! := 1）。数の冪は本文の定め方。"""
    return sum(scalar_power_by_definition(a, m) / factorial(m) for m in range(N + 1))


# E_1(a) = a^0/0! + a^1/1! = 1 + a（QQ[a] で）
P = PolynomialRing(QQ, 'a')
a = P.gen()
assert E_N(a, 1) == scalar_power_by_definition(a, 0) / factorial(0) + scalar_power_by_definition(a, 1) / factorial(1) == 1 + a
# 数の和 E_N(a) と、行列の部分和 S_N([a]) の成分は同じ多項式（二つの極限が同じ列から来ていることの確認）
for N in range(0, 26):
    assert E_N(a, N) == entry11(matrix_partial_sum(one_by_one(P, a), N))
print("E_1(a) = 1 + a、E_N(a) = (S_N([a]_R))_11（N ≤ 25）が QQ[a] で成り立つ")

RBF = RealBallField(512)
points = [QQ(1) / 10^6, QQ(1) / 3, QQ(1), QQ(5), QQ(37)]
for a0 in points:
    ex = body_real_exp_ball(a0)
    # 二つの収束の行: |E_N(a) - exp(a)| の上界（exp(a) のボールの半径を含むので N > 150 では半径で頭打ちになる）と、
    # E(a) - E_N(a) の上界の式 2a^{N+1}/(N+1)!（E(a) は独立には作っていないので、これは上界の式が減ることを見るだけ）が、
    # N とともに単調に減り 2^-200 を下回る
    prev = None
    for N in [10, 40, 80, 160, 320]:
        if N + 2 < 2 * a0:
            continue
        tail = 2 * a0^(N + 1) / factorial(N + 1)                         # 0 ≤ E(a) - E_N(a) ≤ tail
        EN = E_N(a0, N)
        d_exp = (RBF(EN) - ex).abs().upper()
        d_E = RBF(tail).upper()
        if prev is not None:
            assert d_exp <= prev[0] and d_E <= prev[1]
        prev = (d_exp, d_E)
    assert prev[0] < 2^(-200) and prev[1] < 2^(-200), a0
    # 極限の一意性の帰結 E(a) = exp(a): E(a) を囲むボール [E_N, E_N + tail] と exp(a) のボールが重なる
    N = 320
    EN = E_N(a0, N)
    Eball = RBF(EN).add_error(RBF(2 * a0^(N + 1) / factorial(N + 1)).upper())
    assert Eball.overlaps(ex)
    # exp(a) = E(a) ≥ E_1(a) = 1 + a > 1：E_N(a) は a > 0 で N について単調非減少（厳密）で E_1(a) = 1 + a
    for N in range(1, 60):
        assert E_N(a0, N + 1) >= E_N(a0, N) >= E_N(a0, 1) == 1 + a0 > 1
    assert ex.lower() >= RBF(1 + a0).upper() and ex.lower() > 1, a0
print(f"{len(points)} 点で、二つの収束、E(a) と exp(a) のボールの重なり、exp(a) ≥ 1 + a > 1 を確かめた")

# 対照: a = 0 では exp(0) = 1 で「> 1」は成り立たない（部分和は全て厳密に 1）。a < 0 では E_1(a) = 1 + a < 1。
assert all(E_N(QQ(0), N) == 1 for N in range(30))
assert body_real_exp_ball(QQ(0)).contains_exact(1)
assert E_N(QQ(-1) / 2, 1) < 1 and body_real_exp_ball(QQ(-1) / 2).upper() < 1
print("対照: a = 0 では exp(a) = 1、a = -1/2 では exp(a) < 1")
print("RESULT: PASS")
