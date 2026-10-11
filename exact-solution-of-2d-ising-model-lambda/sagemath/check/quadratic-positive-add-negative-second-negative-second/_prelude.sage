# 対象ラベル: claim_quadratic_positive_add_negative_second_negative_second
# 帰属: QQ と二次体の厳密計算。二つの s²=2 の根を用いる。
from itertools import product

if 'qps_pairs' not in globals():
    qps_positive = tuple(sorted(set(QQ(n) / QQ(d) for n in range(1, 7) for d in range(1, 7))))
    qps_pairs = tuple((a, -b) for a, b in product(qps_positive, repeat=2)
                      if 2 * (b * b) < a * a)
    assert len(qps_positive) == 23
    assert len(qps_pairs) == 213
    qps_field = QuadraticField(2, 's')
    qps_generator = qps_field.gen()

def qps_cases():
    for (a, b), (ap, bp) in product(qps_pairs, repeat=2):
        yield a, b, ap, bp, a + ap, b + bp

def qps_rep(value, sign):
    # 数体の正規形から係数を読む。和の表示式は用いない。
    return QQ(value[0]), QQ(sign * value[1])

def qps_algebraic_cases():
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qps_generator
        assert s * s == 2
        for a, b, ap, bp, A, B in qps_cases():
            xi = qps_field(a) + qps_field(b) * s
            eta = qps_field(ap) + qps_field(bp) * s
            assert qps_rep(xi, sign) == (a, b)
            assert qps_rep(eta, sign) == (ap, bp)
            yield sign, xi, eta, a, b, ap, bp, A, B

def qps_positive_coefficient(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0))
            or (0 < a and b < 0 and 2 * (b * b) < a * a)
            or (a < 0 and 0 < b and a * a < 2 * (b * b)))

