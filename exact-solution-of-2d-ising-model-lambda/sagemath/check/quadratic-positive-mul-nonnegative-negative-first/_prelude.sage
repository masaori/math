# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_first
# 帰属: QQ と二次体。浮動小数点を使わない。
from itertools import product

if 'qpf_base_cases' not in globals():
    qpf_nonnegative = tuple(sorted(set(QQ(n) / QQ(d)
        for n in range(5) for d in range(1, 5))))
    qpf_positive = tuple(q for q in qpf_nonnegative if q > 0)
    qpf_base_cases = tuple((a, b, c, bp, -c,
        2 * (b * bp) - a * c, a * bp - b * c,
        a * c - 2 * (b * bp), b * c - a * bp)
        for a, b, c, bp in product(qpf_nonnegative, qpf_nonnegative,
                                   qpf_positive, qpf_positive))
    assert len(qpf_nonnegative) == 12
    assert len(qpf_positive) == 11
    assert len(qpf_base_cases) == 17424
    qpf_field = QuadraticField(2, 's')
    qpf_generator = qpf_field.gen()

def qpf_cases():
    # 背理法の全仮定ではなく、各行が使う局所条件を行ファイルで課す。
    return iter(qpf_base_cases)

def qpf_domain(a, b, c, bp):
    return (a, b) != (0, 0) and c * c < 2 * (bp * bp)

def qpf_rep(value, sign):
    # 積の係数公式とは独立に、数体の正規形の係数を読む。
    return QQ(value[0]), QQ(sign * value[1])

def qpf_algebraic_cases():
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qpf_generator
        assert s * s == 2
        for a, b, c, bp, ap, A, B, C, V in qpf_cases():
            if not qpf_domain(a, b, c, bp):
                continue
            xi = qpf_field(a) + qpf_field(b) * s
            eta = qpf_field(ap) + qpf_field(bp) * s
            assert qpf_rep(xi, sign) == (a, b)
            assert qpf_rep(eta, sign) == (ap, bp)
            yield sign, xi, eta, a, b, c, bp, ap, A, B, C, V

def qpf_cone_nonnegative(ab):
    a, b = ab
    return 0 <= a and 0 <= b and (a, b) != (0, 0)

def qpf_cone_negative_first(ab):
    a, b = ab
    return a < 0 and 0 < b and a * a < 2 * (b * b)

def qpf_cone_negative_second(ab):
    a, b = ab
    return 0 < a and b < 0 and 2 * (b * b) < a * a
