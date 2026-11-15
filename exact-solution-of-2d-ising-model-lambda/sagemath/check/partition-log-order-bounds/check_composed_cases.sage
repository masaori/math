# 対象ラベル: claim_partition_log_order_bounds
# 符号による二場合の合成を、辺長 1〜3 の実際の Q^{a,b}_L（軌道ごとの明示積）と、
# 配位の総当たりで数えた Z_L(q) で検算する。q^2+2q-1 < 0 なら四つの値は正で M^abs_L(q) = M_L(q)、
# M_L(q)/2 <= Z_L(q) から M^abs_L(q)/4 <= Z_L(q)。どちらの場合も M^abs_L(q)/4 <= Z_L(q) <= 2 M^abs_L(q)、
# Z_L(q) > 0 と上界から M^abs_L(q) > 0。
from itertools import product as cartesian_product
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

def partition_value(length, q):
    sites = [(i, j) for i in range(length) for j in range(length)]
    total = QQ(0)
    for spins in cartesian_product((1, -1), repeat=len(sites)):
        sigma = dict(zip(sites, spins))
        broken = 0
        for (i, j) in sites:
            for (k, l) in (((i + 1) % length, j), (i, (j + 1) % length)):
                if sigma[(i, j)] != sigma[(k, l)]:
                    broken += 1
        total += q^broken
    return total

def rational(value):
    assert value.imag() == 0
    return QQ(value.real())

for length in range(1, 4):
    polynomials = {}
    for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
        points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
        polynomials[(a, b)] = prod(factors, R.one())
    for q in (QQ(1)/10, QQ(1)/4, QQ(2)/5, QQ(1)/2, QQ(3)/5, QQ(9)/10):
        c = q^2 + 2*q - 1
        assert c != 0
        Qq = {spin: rational(P(q)) for spin, P in polynomials.items()}
        M_abs = max(abs(v) for v in Qq.values())
        Z = partition_value(length, q)
        if c < 0:
            assert all(v > 0 for v in Qq.values())
            M = max(Qq.values())
            assert M_abs == M
            assert M/2 <= Z <= 2*M
            assert M_abs/4 <= M_abs/2
        assert M_abs/4 <= Z <= 2*M_abs
        assert Z > 0
        assert M_abs > 0
print('RESULT: PASS composed sign cases')
