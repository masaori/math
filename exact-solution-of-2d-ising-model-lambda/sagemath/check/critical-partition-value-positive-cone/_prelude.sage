# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 有理二次体の係数対で正錐を判定する。両方の代数的根で評価する。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '../../_shared/defs.sage'))
R = PolynomialRing(QQ, 'y')
y = R.gen()
modulus = y*y-2
xc = y-1

def reduced(value):
    return R(value).mod(modulus)

def positive(value):
    value = reduced(value)
    a, b = value[0], value[1]
    return ((a >= 0 and b >= 0 and (a != 0 or b != 0))
        or (a > 0 and b < 0 and 2*b*b < a*a)
        or (a < 0 and b > 0 and a*a < 2*b*b))

fixtures = []
for L in (1, 2, 3):
    omega = multiplicity_vector(L)
    terms = [reduced(omega[m]*xc**m) for m in range(2*L*L+1)]
    partials = [sum(terms[:n+1], R.zero()) for n in range(len(terms))]
    fixtures.append((L, omega, terms, partials))
