# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_first
# 帰属: QQ と二次体。浮動小数点・実数体・複素数体は使わない。
from itertools import product

qpf_nonnegative = tuple(sorted(set(QQ(n) / QQ(d) for n in range(5) for d in range(1, 5))))
qpf_positive = tuple(q for q in qpf_nonnegative if 0 < q)
qpf_negative = tuple(-q for q in qpf_positive)
qpf_field = QuadraticField(2, 's')
qpf_generator = qpf_field.gen()

def qpf_cases(branch=None):
    for a, b, ap, bp in product(qpf_nonnegative, qpf_nonnegative, qpf_negative, qpf_positive):
        if (a, b) == (0, 0) or not ap * ap < 2 * (bp * bp):
            continue
        A, B = a + ap, b + bp
        if branch == 'nonnegative' and not 0 <= A:
            continue
        if branch == 'negative' and 0 <= A:
            continue
        yield a, b, ap, bp, A, B

def qpf_rep(value, sign):
    # 数体の正規形から係数を取り出す。入力係数と和の公式は用いない。
    return QQ(value[0]), QQ(sign * value[1])

def qpf_algebraic_cases(branch=None):
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qpf_generator
        assert s * s == 2
        for a, b, ap, bp, A, B in qpf_cases(branch):
            xi = qpf_field(a) + qpf_field(b) * s
            eta = qpf_field(ap) + qpf_field(bp) * s
            assert qpf_rep(xi, sign) == (a, b)
            assert qpf_rep(eta, sign) == (ap, bp)
            yield sign, xi, eta, a, b, ap, bp, A, B

def qpf_positive_coefficient(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0))
            or (0 < a and b < 0 and 2 * (b * b) < a * a)
            or (a < 0 and 0 < b and a * a < 2 * (b * b)))
