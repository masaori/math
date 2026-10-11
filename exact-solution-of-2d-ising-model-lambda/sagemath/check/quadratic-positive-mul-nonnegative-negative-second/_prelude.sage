# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_second
# 帰属: QQ と二次体。浮動小数点を使わない。
from itertools import product

if 'qpn_base_cases' not in globals():
    qpn_nonnegative = tuple(sorted(set(QQ(n) / QQ(d)
        for n in range(5) for d in range(1, 5))))
    qpn_positive = tuple(q for q in qpn_nonnegative if q > 0)
    qpn_base_cases = tuple((a, b, ap, u, -u,
        a * ap - 2 * (b * u), b * ap - a * u,
        a * u - b * ap, 2 * (b * u) - a * ap)
        for a, b, ap, u in product(qpn_nonnegative, qpn_nonnegative,
                                  qpn_positive, qpn_positive))
    assert len(qpn_nonnegative) == 12
    assert len(qpn_positive) == 11
    assert len(qpn_base_cases) == 17424
    qpn_field = QuadraticField(2, 's')
    qpn_generator = qpn_field.gen()

def qpn_cases():
    # 背理法の全仮定はここでは課さない。各行が使う条件は行ファイルに明記する。
    return iter(qpn_base_cases)

def qpn_domain(a, b, ap, u):
    return (a, b) != (0, 0) and 2 * (u * u) < ap * ap

def qpn_rep(value, sign):
    # 積の係数公式と独立に、数体の正規形から二つの係数を読む。
    return QQ(value[0]), QQ(sign * value[1])

def qpn_algebraic_cases():
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qpn_generator
        assert s * s == 2
        for a, b, ap, u, bp, A, B, V, C in qpn_cases():
            if not qpn_domain(a, b, ap, u):
                continue
            xi = qpn_field(a) + qpn_field(b) * s
            eta = qpn_field(ap) + qpn_field(bp) * s
            assert qpn_rep(xi, sign) == (a, b)
            assert qpn_rep(eta, sign) == (ap, bp)
            yield sign, xi, eta, a, b, ap, u, bp, A, B, V, C

def qpn_cone_nonnegative(ab):
    a, b = ab
    return 0 <= a and 0 <= b and (a, b) != (0, 0)

def qpn_cone_negative_second(ab):
    a, b = ab
    return 0 < a and b < 0 and 2 * (b * b) < a * a

def qpn_cone_negative_first(ab):
    a, b = ab
    return a < 0 and 0 < b and a * a < 2 * (b * b)

def qpn_cone(ab):
    return (qpn_cone_nonnegative(ab) or qpn_cone_negative_second(ab)
        or qpn_cone_negative_first(ab))
