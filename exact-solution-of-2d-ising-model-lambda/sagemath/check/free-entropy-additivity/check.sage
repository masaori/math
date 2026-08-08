# 対象ラベル: claim_log_additive, claim_log_power, claim_free_entropy_at_one
#
# 本文（structured-latex/content/main-text.ts）の章「有限系の自由エントロピー」の
#   主張「対数の加法性」        log(q1 q2) = log q1 + log q2   （Lambda の中の等式）
#   主張「対数の冪の法則」      log(q^k)   = k log q           （k は自然数）
#   主張「すべての配位を等しく数える点での自由エントロピー」
#                              Phi_L(1)   = L^2 l_2
# を確かめる。
#
# Lambda の元は {素数: 指数} の辞書（値 0 の素数は入れない）として表す。
# 加法は素数ごとの整数の加法（def_log_order_group どおり）。
# 対数は素因数分解そのもの（def_rational_log）であり、実対数も指数関数も使わない。
# 厳密計算のみ（ZZ / QQ / ZZ['x']）。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def log_rational(q):
    """def_rational_log: 正の有理数 q の対数を Lambda の元（{p: w_p(q)} の辞書）として返す。"""
    q = QQ(q)
    assert q > 0, q
    return {ZZ(p): ZZ(e) for (p, e) in factor(q)}


def lambda_add(lam, mu):
    """def_log_order_group: Lambda の加法（素数ごとの整数の加法）。"""
    result = {}
    for p in set(lam.keys()) | set(mu.keys()):
        value = lam.get(p, ZZ(0)) + mu.get(p, ZZ(0))
        if value != 0:
            result[ZZ(p)] = ZZ(value)
    return result


def lambda_smul(n, lam):
    """def_log_order_group: Lambda の整数倍（素数ごとの整数の積）。"""
    n = ZZ(n)
    if n == 0:
        return {}
    return {ZZ(p): ZZ(n) * ZZ(e) for (p, e) in lam.items()}


def lambda_generator(p):
    """def_log_order_group: 生成元 l_p。"""
    assert ZZ(p).is_prime(), p
    return {ZZ(p): ZZ(1)}


def free_entropy(L, q):
    """def_finite_free_entropy: Phi_L(q) = log Z_L(q)。"""
    return log_rational(partition_polynomial(L)(QQ(q)))


# --- claim_log_additive --------------------------------------------------------

RATIONAL_POINTS = [
    QQ(1), QQ(2), QQ(3), QQ(1) / QQ(2), QQ(2) / QQ(3), QQ(12) / QQ(18),
    QQ(353) / QQ(128), QQ(9859) / QQ(2048), QQ(1000) / QQ(7), QQ(1) / QQ(1000),
]


def check_additive():
    for q1 in RATIONAL_POINTS:
        for q2 in RATIONAL_POINTS:
            left = log_rational(q1 * q2)
            right = lambda_add(log_rational(q1), log_rational(q2))
            assert left == right, (q1, q2, left, right)
            # 本文の第 7 の等号と結びの内容そのもの（各素数で値が一致すること）を、
            # 現れうる素数すべてについて別途確かめる。
            primes = set(left.keys()) | set(right.keys())
            primes |= {ZZ(2), ZZ(3), ZZ(5), ZZ(7)}
            for p in primes:
                assert left.get(p, ZZ(0)) == right.get(p, ZZ(0)), (p, q1, q2)
    print('OK: log(q1 q2) = log q1 + log q2 を有理点', len(RATIONAL_POINTS), '個の全対で確認した')


# --- claim_log_power -----------------------------------------------------------

def check_power():
    for q in RATIONAL_POINTS:
        for k in range(0, 8):
            left = log_rational(q ** k)
            right = lambda_smul(k, log_rational(q))
            assert left == right, (q, k, left, right)
        # k = 0 の場合の内容（log 1 = 0、すなわち Lambda の単位元）。
        assert log_rational(q ** 0) == {}, q
    print('OK: log(q^k) = k log q を有理点', len(RATIONAL_POINTS), '個 × k = 0..7 で確認した')


# --- claim_free_entropy_at_one -------------------------------------------------

def check_free_entropy_at_one(L):
    # 本文の第 2-第 4 の等号: Z_L(1) は多重度の総和であり、配位の総数 2^{L^2} に等しい。
    value = partition_polynomial(L)(QQ(1))
    assert value == sum(multiplicity_vector(L)), (L, value)
    assert value == ZZ(2) ** (L ** 2), (L, value)
    # 本文の第 1・第 5-第 8 の等号: Phi_L(1) = L^2 l_2。
    left = free_entropy(L, QQ(1))
    right = lambda_smul(L ** 2, lambda_generator(2))
    assert left == right, (L, left, right)
    # 第 6-第 8 の等号の内容（log 2 = l_2）も単独で確かめる。
    assert log_rational(QQ(2)) == lambda_generator(2)
    print('L =', L, ' Z_L(1) =', value, ' Phi_L(1) =', left)


check_additive()
check_power()
for L in [1, 2, 3]:
    check_free_entropy_at_one(L)

print()
print('OK: 対数の加法性・冪の法則と Phi_L(1) = L^2 l_2 を L = 1, 2, 3 で確認した（厳密計算）')
