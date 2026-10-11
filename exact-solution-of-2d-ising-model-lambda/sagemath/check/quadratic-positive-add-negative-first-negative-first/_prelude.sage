# 対象ラベル: claim_quadratic_positive_add_negative_first_negative_first
# 帰属: QQ と二次体の厳密計算。二つの s²=2 の根を用いる。
from itertools import product

if 'qpf_pairs' not in globals():
    qpf_positive = tuple(sorted(set(QQ(n) / QQ(d) for n in range(1, 7) for d in range(1, 7))))
    qpf_pairs = tuple((-a, b) for a, b in product(qpf_positive, repeat=2)
                      if a * a < 2 * (b * b))
    assert len(qpf_positive) == 23
    assert len(qpf_pairs) == 316
    qpf_field = QuadraticField(2, 's')
    qpf_generator = qpf_field.gen()

def qpf_cases():
    for (a, b), (ap, bp) in product(qpf_pairs, repeat=2):
        yield a, b, ap, bp, a + ap, b + bp

def qpf_rep(value, sign):
    # 数体の正規形から係数を読む。和の表示式は用いない。
    return QQ(value[0]), QQ(sign * value[1])

def qpf_algebraic_cases():
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qpf_generator
        assert s * s == 2
        for a, b, ap, bp, A, B in qpf_cases():
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
