# 対象ラベル: claim_finitely_many_primes_are_not_sufficient_for_limit_quantity
# 素指数データを「有限個の素数での指数」だけへ切り詰める粗視化が、箱サイズ極限の
# 一致に十分でないことを、本文と同じ反例で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 検査に使う添字の範囲（有限）。反例の列は定数列なので範囲の取り方に依らない。
L_MAX = 12
L_TOP = L_MAX + 1

# 本文の証明が使う有限集合 S の候補（素数からなる有限集合）。
FINITE_PRIME_SETS = [
    [],
    [2],
    [2, 3],
    [2, 3, 5],
    [3, 5, 7, 11],
    [2, 5, 13],
]

# 段 1: S が有限集合であれば S に属さない素数 r が存在すること
#（本文の「素数は無限に多く存在する」の段の有限側の確認。検査は最小の証人を取る）。
def smallest_prime_outside(S):
    p = ZZ(2)
    while True:
        if p not in S:
            return p
        p = next_prime(p)

for S in FINITE_PRIME_SETS:
    r = smallest_prime_outside(S)
    assert r.is_prime()
    assert r not in S
    assert r >= 2

    # 本文の反例: すべての L で N(L) = 1, A(L) = 1, B(L) = r。
    def data_at(L):
        A = QQ(1)
        B = QQ(r)
        N = ZZ(1)
        a = QQ(1)
        b = QQ(r)
        return (A, B, N, a, b)

    root_sequence_a = {}
    root_sequence_b = {}
    for L in range(1, L_TOP + 1):
        A, B, N, a, b = data_at(L)
        assert A > 0 and B > 0 and N > 0
        assert a > 0 and b > 0
        # a, b は主張中の a(L) = A(L)^{1/N(L)}, b(L) = B(L)^{1/N(L)} に当たる乗根である。
        assert a**N == A
        assert b**N == B
        root_sequence_a[L] = a
        root_sequence_b[L] = b

        # 段 2: S に属するすべての素数で二つの列の素指数が一致すること。
        for p in S:
            assert ZZ(p).is_prime()
            assert A.valuation(p) == ZZ(0)
            assert B.valuation(p) == ZZ(0)
            assert A.valuation(p) == B.valuation(p)

        # 段 3: 一方で r での素指数は一致しないこと（切り詰めで落ちる情報がある）。
        assert A.valuation(r) == ZZ(0)
        assert B.valuation(r) == ZZ(1)
        assert A.valuation(r) != B.valuation(r)

    # 段 4: a は定数列 1 であり、候補値 1 との差が 0 であること
    #（本文で N_a := 1 と置く段の有限側の確認）。
    for L in range(1, L_TOP + 1):
        assert root_sequence_a[L] == QQ(1)
        assert abs(root_sequence_a[L] - QQ(1)) == QQ(0)

    # 段 5: b は定数列 r であり、候補値 r との差が 0 であること
    #（本文で N_b := 1 と置く段の有限側の確認）。
    for L in range(1, L_TOP + 1):
        assert root_sequence_b[L] == QQ(r)
        assert abs(root_sequence_b[L] - QQ(r)) == QQ(0)

    # 段 6: 二つの候補値 1 と r が異なること、および両者を同時に近づけられない
    # 幅が存在すること（差が r - 1 >= 1 なので幅 1/2 では両立しない）。
    assert QQ(1) != QQ(r)
    epsilon = QQ(1) / 2
    for numerator in range(0, 8 * (r + 2) + 1):
        l_candidate = QQ(numerator) / 8
        close_to_one = abs(QQ(1) - l_candidate) < epsilon
        close_to_r = abs(QQ(r) - l_candidate) < epsilon
        assert not (close_to_one and close_to_r)

print("ALL PASS")
