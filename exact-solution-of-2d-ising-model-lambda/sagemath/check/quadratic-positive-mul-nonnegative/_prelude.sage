# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 帰属: QQ と二次体。浮動小数点を使わない。
from itertools import product

qpm_samples = tuple(sorted(set(QQ(n) / QQ(d) for n in range(5) for d in range(1, 5))))
qpm_field = QuadraticField(2, 's')
qpm_generator = qpm_field.gen()

def qpm_cases(branch=None):
    for a, b, ap, bp in product(qpm_samples, repeat=4):
        if (a, b) == (0, 0) or (ap, bp) == (0, 0):
            continue
        if branch == 'aa' and not (0 < a and 0 < ap):
            continue
        if branch == 'ab' and not (0 < a and 0 < bp):
            continue
        if branch == 'ba' and not (0 < b and 0 < ap):
            continue
        if branch == 'bb' and not (0 < b and 0 < bp):
            continue
        A = a * ap + 2 * (b * bp)
        B = a * bp + b * ap
        yield a, b, ap, bp, A, B

def qpm_rep(value, sign):
    # 数体の正規形から係数を取り、積の係数公式を参照しない。
    return QQ(value[0]), QQ(sign * value[1])

def qpm_algebraic_cases():
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qpm_generator
        assert s * s == 2
        for a, b, ap, bp, A, B in qpm_cases():
            xi = qpm_field(a) + qpm_field(b) * s
            eta = qpm_field(ap) + qpm_field(bp) * s
            assert qpm_rep(xi, sign) == (a, b)
            assert qpm_rep(eta, sign) == (ap, bp)
            yield sign, xi, eta, a, b, ap, bp, A, B

def qpm_positive(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0))
            or (0 < a and b < 0 and 2 * (b * b) < a * a)
            or (a < 0 and 0 < b and a * a < 2 * (b * b)))
