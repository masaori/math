# 対象ラベル: claim_rational_exponent_well_defined, claim_value_at_rational_is_positive
#
# 本文（structured-latex/content/main-text.ts）の章「有限系の自由エントロピー」の
#   主張「有理数の指数は表示の取り方によらない」
#       a/b = a'/b' ならば v_p(a) - v_p(b) = v_p(a') - v_p(b')
#   主張「分配多項式の正の有理点での値は正の有理数である」
#       q > 0（有理数）ならば Z_L(q) は正の有理数
# を確かめ、あわせて定義
#   log q = sum_p w_p(q) l_p  （w_p(q) = v_p(a) - v_p(b)）
#   Phi_L(q) = log Z_L(q)
# が本文どおりに計算できることを確かめる。
#
# 素因数分解の指数は Sage の factor（整数の厳密な素因数分解）から読む。
# 厳密計算のみ（ZZ / QQ / ZZ['x']）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def prime_exponent(p, n):
    """def_prime_exponent: 1 以上の整数 n における素数 p の指数 v_p(n)（N の元）。"""
    n = ZZ(n)
    assert n >= 1, n
    return ZZ(n.valuation(p))


def rational_exponent(p, a, b):
    """def_rational_log: 表示 q = a/b から w_p(q) = v_p(a) - v_p(b)（Z の元）を作る。"""
    return prime_exponent(p, a) - prime_exponent(p, b)


def log_rational(q):
    """def_rational_log: 正の有理数 q の対数を、素数から整数への有限台の写像として返す。

    返り値は {p: w_p(q)} の辞書（値が 0 の素数は入れない）。
    これが Lambda の元 sum_p w_p(q) l_p に対応する。
    """
    q = QQ(q)
    assert q > 0, q
    return {ZZ(p): ZZ(e) for (p, e) in factor(q)}


def free_entropy(L, q):
    """def_finite_free_entropy: Phi_L(q) = log Z_L(q)（Lambda の元）。"""
    return log_rational(partition_polynomial(L)(QQ(q)))


# --- claim_rational_exponent_well_defined -------------------------------------
#
# 同じ有理数の異なる表示 a/b = a'/b' を作って、w_p が表示によらないことを確かめる。
# 表示は (1) 共通因子を掛ける、(2) 既約表示、の 2 通りから作る。

REPRESENTATION_SOURCES = [
    (ZZ(1), ZZ(1)),
    (ZZ(2), ZZ(1)),
    (ZZ(1), ZZ(2)),
    (ZZ(12), ZZ(18)),
    (ZZ(353), ZZ(128)),
    (ZZ(9859), ZZ(2048)),
    (ZZ(1000), ZZ(7)),
    (ZZ(2 * 3 * 5 * 7), ZZ(11 * 13)),
]

SCALES = [ZZ(1), ZZ(2), ZZ(3), ZZ(6), ZZ(35), ZZ(128)]


def check_well_defined():
    for (a, b) in REPRESENTATION_SOURCES:
        q = QQ(a) / QQ(b)
        # この有理数の様々な表示を作る。
        representations = [(a * k, b * k) for k in SCALES]
        representations.append((q.numerator(), q.denominator()))
        primes = set()
        for (a2, b2) in representations:
            primes |= set(ZZ(p) for (p, _) in factor(a2))
            primes |= set(ZZ(p) for (p, _) in factor(b2))
        primes |= {ZZ(2), ZZ(3), ZZ(5), ZZ(9859)}
        for (a1, b1) in representations:
            for (a2, b2) in representations:
                # 仮定: a1/b1 = a2/b2、すなわち a1 b2 = a2 b1（本文 Step 1）。
                assert a1 * b2 == a2 * b1, (a1, b1, a2, b2)
                for p in primes:
                    # 本文 Step 2-4 の結論。
                    assert rational_exponent(p, a1, b1) == rational_exponent(p, a2, b2), (
                        p, a1, b1, a2, b2)
        # 既約表示から作った w_p が、Sage の factor が返す指数と一致すること
        # （def_rational_log が素因数分解そのものであることの確認）。
        exponents = log_rational(q)
        for p in primes:
            assert rational_exponent(p, a, b) == exponents.get(p, ZZ(0)), (p, a, b)
        # 台が有限であること（def_rational_log で示した性質）。
        assert all(e != 0 for e in exponents.values()), (a, b, exponents)
    print('OK: w_p(q) は表示 a/b の取り方によらない（本文 Step 1-4 を表示の全対で確認）')


# --- claim_value_at_rational_is_positive --------------------------------------

RATIONAL_POINTS = [QQ(1) / QQ(2), QQ(2) / QQ(3), QQ(3), QQ(1), QQ(1) / QQ(1000)]


def check_value_positive(L):
    Z = partition_polynomial(L)
    for q in RATIONAL_POINTS:
        value = Z(q)
        # 本文 Step 1: 代入は和へ配れる（左辺と右辺を独立に作って一致を見る）。
        by_configuration = QQ(0)
        for sigma in configurations(L):
            term = q ** broken_bond_count(L, sigma)
            # 本文 Step 2: 各項は正。
            assert term > 0, (L, q, term)
            by_configuration += term
        assert value == by_configuration, (L, q, value, by_configuration)
        # 本文 Step 3-4: 値は正の有理数。
        assert value in QQ, (L, q, value)
        assert value > 0, (L, q, value)


# --- def_finite_free_entropy ---------------------------------------------------

def check_free_entropy(L):
    for q in RATIONAL_POINTS:
        value = partition_polynomial(L)(q)
        exponents = free_entropy(L, q)
        # Phi_L(q) の指数ベクトルから値を復元できること（対数が素因数分解であることの確認）。
        reconstructed = QQ(1)
        for (p, e) in exponents.items():
            reconstructed *= QQ(p) ** e
        assert reconstructed == value, (L, q, reconstructed, value)
    print('L =', L)
    for q in RATIONAL_POINTS:
        print('  q =', q,
              ' Z_L(q) =', partition_polynomial(L)(q),
              ' Phi_L(q) の指数ベクトル =', free_entropy(L, q))


def check_text_example():
    """本文 def_finite_free_entropy の具体例 Phi_2(1/2) = l_353 - 7 l_2。"""
    value = partition_polynomial(2)(QQ(1) / QQ(2))
    assert value == QQ(353) / QQ(2) ** 7, value
    assert ZZ(353).is_prime()
    assert free_entropy(2, QQ(1) / QQ(2)) == {ZZ(2): ZZ(-7), ZZ(353): ZZ(1)}, (
        free_entropy(2, QQ(1) / QQ(2)))
    print('OK: 本文の具体例 Phi_2(1/2) = l_353 - 7 l_2 を確認した')


check_well_defined()
for L in [1, 2, 3]:
    check_value_positive(L)
for L in [1, 2, 3]:
    check_free_entropy(L)
check_text_example()

print()
print('OK: Z_L(q) は正の有理数であり、Phi_L(q) = log Z_L(q) は Lambda の元として'
      ' L = 1, 2, 3 で確認した（厳密計算）')
