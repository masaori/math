# 対象ラベル: claim_finitely_many_cross_power_equalities_are_not_sufficient_for_limit_quantity
# 交差べき等式が成り立つ添字が「空でない有限集合」でしかないとき、二つの乗根列の
# 箱サイズ極限がともに存在しても値が異なりうることを、本文と同じ反例で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 検査に使う添字の範囲（有限）。共終性の否定は「L1 = 2 以上に成立する添字が
# 検査範囲内に一つも無い」ことで検査する。
L_MAX = 12
L_TOP = L_MAX + 1

# 本文の反例: すべての L で N(L) = M(L) = 1, A(L) = 1。B(1) = 1、L >= 2 で B(L) = 2。
def data_at(L):
    A = QQ(1)
    N = ZZ(1)
    a = QQ(1)
    B = QQ(1) if L == 1 else QQ(2)
    M = ZZ(1)
    b = B
    return (A, N, a, B, M, b)

root_sequence_a = {}
root_sequence_b = {}
holds_cross_power = {}

for L in range(1, L_TOP + 1):
    A, N, a, B, M, b = data_at(L)
    assert A > 0 and B > 0 and N > 0 and M > 0
    assert a > 0 and b > 0
    # a, b は主張中の a(L) = A(L)^{1/N(L)}, b(L) = B(L)^{1/M(L)} に当たる乗根である。
    assert a**N == A
    assert b**M == B
    holds_cross_power[L] = (A**M == B**N)
    root_sequence_a[L] = a
    root_sequence_b[L] = b

# 段 1: 交差べき等式が成り立つ添字の集合が {1} であること（空でない有限集合）。
agreement_indices = [L for L in range(1, L_TOP + 1) if holds_cross_power[L]]
assert agreement_indices == [1]

# 段 2: その集合が共終でないこと（L1 = 2 以上に成立する添字が無い）。
for L1 in range(2, L_MAX + 1):
    witnesses = [L for L in range(L1, L_TOP + 1) if holds_cross_power[L]]
    assert len(witnesses) == 0

# 段 3: 尾部版・共終版の仮定である乗根列の一致も L >= 2 では成り立たないこと。
for L in range(2, L_TOP + 1):
    assert root_sequence_a[L] != root_sequence_b[L]

# 段 4: a は定数列 1 であり、L >= 1 のすべてで候補値 1 との差が 0 であること
#（本文で N_a := 1 と置く段の有限側の確認）。
for L in range(1, L_TOP + 1):
    assert root_sequence_a[L] == QQ(1)
    assert abs(root_sequence_a[L] - QQ(1)) == QQ(0)

# 段 5: b は L >= 2 で定数 2 であり、候補値 2 との差が 0 であること
#（本文で N_b := 2 と置く段の有限側の確認）。
for L in range(2, L_TOP + 1):
    assert root_sequence_b[L] == QQ(2)
    assert abs(root_sequence_b[L] - QQ(2)) == QQ(0)

# 段 6: 二つの極限値の候補 1 と 2 が異なること、および両者を同時に近づけられない
# 幅が存在すること（差が 1 なので幅 1/2 では両立しない）。
assert QQ(1) != QQ(2)
epsilon = QQ(1) / 2
for numerator in range(0, 25):
    l_candidate = QQ(numerator) / 8
    close_to_one = abs(QQ(1) - l_candidate) < epsilon
    close_to_two = abs(QQ(2) - l_candidate) < epsilon
    assert not (close_to_one and close_to_two)

print("ALL PASS")
