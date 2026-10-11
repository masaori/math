# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_second
# 帰属: QQ と二次体。浮動小数点・実数体・複素数体は使わない。
from itertools import product

qps_nonnegative = tuple(sorted(set(QQ(n) / QQ(d) for n in range(5) for d in range(1, 5))))
qps_positive = tuple(q for q in qps_nonnegative if 0 < q)
qps_negative = tuple(-q for q in qps_positive)
qps_field = QuadraticField(2, 's')
qps_generator = qps_field.gen()

def qps_cases(branch=None):
    for a, b, ap, bp in product(qps_nonnegative, qps_nonnegative, qps_positive, qps_negative):
        if (a, b) == (0, 0) or not 2 * (bp * bp) < ap * ap:
            continue
        A, B = a + ap, b + bp
        if branch == 'nonnegative' and not 0 <= B:
            continue
        if branch == 'negative' and 0 <= B:
            continue
        yield a, b, ap, bp, A, B

def qps_rep(value, sign):
    # 数体の正規形から係数を取り出す。入力係数と和の公式は用いない。
    return QQ(value[0]), QQ(sign * value[1])

def qps_algebraic_cases(branch=None):
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qps_generator
        assert s * s == 2
        for a, b, ap, bp, A, B in qps_cases(branch):
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
