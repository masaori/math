# 対象ラベル: claim_magnitude_truncated_prime_exponents_are_not_sufficient_for_limit_quantity
# 素指数データを「各成分の値の大きさ」で切り詰める粗視化（高さ N での min による切り詰め）が、
# 箱サイズ極限の一致に十分でないことを、本文と同じ反例で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 検査に使う添字の範囲（有限）。反例の列は定数列なので範囲の取り方に依らない。
L_MAX = 12
L_TOP = L_MAX + 1

# 切り詰めの高さ N の候補（本文は任意の N >= 1 について主張する）。
HEIGHTS = [1, 2, 3, 5, 8]

# 素指数を比べる素数の範囲（有限）。2 以外では両列とも指数 0 なので範囲の取り方に依らない。
PRIMES_CHECKED = [ZZ(p) for p in primes(2, 60)]

def truncate(exponent, height):
    # 本文の min{v_p(x), N} に当たる切り詰め。ZZ の比較だけで決まる。
    return min(ZZ(exponent), ZZ(height))

for N in HEIGHTS:
    N = ZZ(N)
    assert N >= 1

    # 本文の反例: すべての L で M(L) = 1, A(L) = 2^N, B(L) = 2^{N+1}。
    def data_at(L):
        A = QQ(2)**N
        B = QQ(2)**(N + 1)
        M = ZZ(1)
        a = QQ(2)**N
        b = QQ(2)**(N + 1)
        return (A, B, M, a, b)

    root_sequence_a = {}
    root_sequence_b = {}
    for L in range(1, L_TOP + 1):
        A, B, M, a, b = data_at(L)
        assert A > 0 and B > 0 and M > 0
        assert a > 0 and b > 0
        # a, b は主張中の a(L) = A(L)^{1/M(L)}, b(L) = B(L)^{1/M(L)} に当たる乗根である。
        assert a**M == A
        assert b**M == B
        root_sequence_a[L] = a
        root_sequence_b[L] = b

        # 段 1: 素数 2 での素指数は N と N+1 であり、一致しないこと
        #（切り詰めで落ちる情報の所在）。
        assert A.valuation(2) == N
        assert B.valuation(2) == N + 1
        assert A.valuation(2) != B.valuation(2)

        # 段 2: 素数 2 での切り詰めた値は一致すること。
        assert truncate(A.valuation(2), N) == N
        assert truncate(B.valuation(2), N) == N
        assert truncate(A.valuation(2), N) == truncate(B.valuation(2), N)

        # 段 3: 2 以外の素数では素指数がともに 0 であり、切り詰めた値も一致すること。
        for p in PRIMES_CHECKED:
            if p == 2:
                continue
            assert A.valuation(p) == ZZ(0)
            assert B.valuation(p) == ZZ(0)
            assert truncate(A.valuation(p), N) == ZZ(0)
            assert truncate(B.valuation(p), N) == ZZ(0)
            assert truncate(A.valuation(p), N) == truncate(B.valuation(p), N)

    # 段 4: a は定数列 2^N であり、候補値 2^N との差が 0 であること
    #（本文で N_a := 1 と置く段の有限側の確認）。
    for L in range(1, L_TOP + 1):
        assert root_sequence_a[L] == QQ(2)**N
        assert abs(root_sequence_a[L] - QQ(2)**N) == QQ(0)

    # 段 5: b は定数列 2^{N+1} であり、候補値 2^{N+1} との差が 0 であること
    #（本文で N_b := 1 と置く段の有限側の確認）。
    for L in range(1, L_TOP + 1):
        assert root_sequence_b[L] == QQ(2)**(N + 1)
        assert abs(root_sequence_b[L] - QQ(2)**(N + 1)) == QQ(0)

    # 段 6: 二つの候補値が異なること、および両者を同時に近づけられない幅が
    # 存在すること（差は 2^N >= 2 なので幅 1/2 では両立しない）。
    assert QQ(2)**N != QQ(2)**(N + 1)
    assert QQ(2)**(N + 1) - QQ(2)**N == QQ(2)**N
    epsilon = QQ(1) / 2
    upper = 8 * (2**(N + 1) + 2)
    for numerator in range(0, upper + 1):
        l_candidate = QQ(numerator) / 8
        close_to_a = abs(QQ(2)**N - l_candidate) < epsilon
        close_to_b = abs(QQ(2)**(N + 1) - l_candidate) < epsilon
        assert not (close_to_a and close_to_b)

print("ALL PASS")
