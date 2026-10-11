# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 帰属: QQ と二次体の厳密計算。二つの s²=2 の根を用いる。
from itertools import product

if 'qpm_data' not in globals():
    qpm_positive = tuple(sorted(set(QQ(n) / QQ(d) for n in range(1, 7) for d in range(1, 7))))
    qpm_left = tuple((a, -u) for a, u in product(qpm_positive, repeat=2) if 2*u*u < a*a)
    qpm_right = tuple((-c, bp) for c, bp in product(qpm_positive, repeat=2) if c*c < 2*bp*bp)
    assert len(qpm_positive) == 23
    assert len(qpm_left) == 213 and len(qpm_right) == 316
    def qpm_values(a, b, ap, bp):
        c, u, A, B = -ap, -b, a + ap, b + bp
        return a, b, ap, bp, c, u, A, B, u - bp, c - a
    qpm_all = tuple(qpm_values(a, b, ap, bp) for (a, b), (ap, bp) in product(qpm_left, qpm_right))
    qpm_data = {
        'all': qpm_all,
        'first': tuple(t for t in qpm_all if t[6] >= 0 and t[7] >= 0),
        'second': tuple(t for t in qpm_all if t[6] >= 0 and t[7] < 0),
        'third': tuple(t for t in qpm_all if t[6] < 0),
    }
    assert tuple(len(qpm_data[k]) for k in ('all','first','second','third')) == (67308,46944,10182,10182)
    # 背理法内の局所計算は、正錐の二つの平方条件を仮定せず、非空の局所標本で検査する。
    qpm_aux_positive = (QQ(1)/2, QQ(1), QQ(2), QQ(3))
    qpm_aux = tuple(qpm_values(a, -u, -c, bp) for a,c,u,bp in product(qpm_aux_positive, repeat=4))
    qpm_data['aux_zero_pair'] = tuple(t for t in qpm_aux if t[6] == 0 and t[7] == 0)
    qpm_data['aux_zero_first'] = tuple(t for t in qpm_aux if t[6] == 0 and t[7] < 0)
    qpm_data['aux_nonpositive_second'] = tuple(t for t in qpm_aux if t[6] < 0 and t[7] <= 0)
    assert tuple(len(qpm_data[k]) for k in ('aux_zero_pair','aux_zero_first','aux_nonpositive_second')) == (16,24,60)
    qpm_field = QuadraticField(2, 's')
    qpm_generator = qpm_field.gen()

def qpm_cases(kind):
    return iter(qpm_data[kind])

def qpm_rep(value, sign):
    # 和の係数式は使わず、二次体の正規形から係数を読む。
    return QQ(value[0]), QQ(sign * value[1])

def qpm_algebraic_cases(kind):
    for sign in (ZZ.one(), -ZZ.one()):
        s = sign * qpm_generator
        assert s*s == 2
        for a,b,ap,bp,c,u,A,B,U,C in qpm_cases(kind):
            xi = qpm_field(a) + qpm_field(b)*s
            eta = qpm_field(ap) + qpm_field(bp)*s
            assert qpm_rep(xi, sign) == (a,b)
            assert qpm_rep(eta, sign) == (ap,bp)
            yield sign,xi,eta,a,b,ap,bp,c,u,A,B,U,C

def qpm_first(ab):
    a,b = ab
    return 0 <= a and 0 <= b and (a,b) != (0,0)

def qpm_second(ab):
    a,b = ab
    return 0 < a and b < 0 and 2*(b*b) < a*a

def qpm_third(ab):
    a,b = ab
    return a < 0 and 0 < b and a*a < 2*(b*b)
