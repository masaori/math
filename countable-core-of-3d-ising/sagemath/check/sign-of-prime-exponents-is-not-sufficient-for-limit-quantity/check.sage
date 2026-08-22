# 対象ラベル: claim_sign_of_prime_exponents_is_not_sufficient_for_limit_quantity
# 素指数データを「どの素数がどちら向きに現れるか」という符号だけへ潰す粗視化が、
# 箱サイズ極限の一致に十分でないことを、本文と同じ反例で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 検査に使う添字の範囲（有限）。反例の列は定数列なので範囲の取り方に依らない。
L_MAX = 12
L_TOP = L_MAX + 1

# 素指数の符号を比べる素数の範囲（有限）。2 以外では両列とも指数 0 なので範囲の取り方に依らない。
PRIMES_CHECKED = [ZZ(p) for p in primes(2, 60)]

def sgn(n):
    # 本文の sgn: ZZ -> {-1, 0, 1}。ZZ の順序比較だけで決まる。
    n = ZZ(n)
    if n > 0:
        return ZZ(1)
    if n < 0:
        return ZZ(-1)
    return ZZ(0)

# 段 0: sgn そのものが本文の定義どおりであること（有限個の代表で確かめる）。
for n in range(-6, 7):
    if n > 0:
        assert sgn(n) == ZZ(1)
    elif n == 0:
        assert sgn(n) == ZZ(0)
    else:
        assert sgn(n) == ZZ(-1)

# 本文の反例: すべての L で M(L) = 1, A(L) = 2, B(L) = 4。
def data_at(L):
    A = QQ(2)
    B = QQ(4)
    M = ZZ(1)
    a = QQ(2)
    b = QQ(4)
    return (A, B, M, a, b)

root_sequence_a = {}
root_sequence_b = {}
for L in range(1, L_TOP + 1):
    A, B, M, a, b = data_at(L)
    assert A > 0 and B > 0 and M >= 1
    assert a > 0 and b > 0
    # a, b は主張中の a(L) = A(L)^{1/M(L)}, b(L) = B(L)^{1/M(L)} に当たる乗根である。
    assert a**M == A
    assert b**M == B
    root_sequence_a[L] = a
    root_sequence_b[L] = b

    # 段 1: 素数 2 での素指数は 1 と 2 であり、一致しないこと
    #（符号へ潰すことで落ちる情報の所在）。
    assert A.valuation(2) == ZZ(1)
    assert B.valuation(2) == ZZ(2)
    assert A.valuation(2) != B.valuation(2)

    # 段 2: 素数 2 での素指数の符号は一致すること。
    assert sgn(A.valuation(2)) == ZZ(1)
    assert sgn(B.valuation(2)) == ZZ(1)
    assert sgn(A.valuation(2)) == sgn(B.valuation(2))

    # 段 3: 2 以外の素数では素指数がともに 0 であり、符号も一致すること。
    for p in PRIMES_CHECKED:
        if p == 2:
            continue
        assert A.valuation(p) == ZZ(0)
        assert B.valuation(p) == ZZ(0)
        assert sgn(A.valuation(p)) == ZZ(0)
        assert sgn(B.valuation(p)) == ZZ(0)
        assert sgn(A.valuation(p)) == sgn(B.valuation(p))

# 段 4: a は定数列 2 であり、候補値 2 との差が 0 であること
#（本文で L_a := 1 と置く段の有限側の確認）。
for L in range(1, L_TOP + 1):
    assert root_sequence_a[L] == QQ(2)
    assert abs(root_sequence_a[L] - QQ(2)) == QQ(0)

# 段 5: b は定数列 4 であり、候補値 4 との差が 0 であること
#（本文で L_b := 1 と置く段の有限側の確認）。
for L in range(1, L_TOP + 1):
    assert root_sequence_b[L] == QQ(4)
    assert abs(root_sequence_b[L] - QQ(4)) == QQ(0)

# 段 6: 二つの候補値が異なること、および両者を同時に近づけられない幅が
# 存在すること（差は 2 なので幅 1/2 では両立しない）。
assert QQ(2) != QQ(4)
assert QQ(4) - QQ(2) == QQ(2)
epsilon = QQ(1) / 2
for numerator in range(0, 8 * 6 + 1):
    l_candidate = QQ(numerator) / 8
    close_to_a = abs(QQ(2) - l_candidate) < epsilon
    close_to_b = abs(QQ(4) - l_candidate) < epsilon
    assert not (close_to_a and close_to_b)

# 段 7: 符号への粗視化は、値の大きさで切り詰める粗視化（高さ N での min）より粗いこと。
# 高さ N >= 2 の切り詰めは A(L) と B(L) を区別するのに対し、符号は区別しない。
for N in [2, 3, 5]:
    N = ZZ(N)
    assert min(ZZ(1), N) != min(ZZ(2), N)
    assert sgn(ZZ(1)) == sgn(ZZ(2))

print("ALL PASS")
