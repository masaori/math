# 対象ラベル: claim_high_temperature_partition_bounds
# 符号を除いた自己双対性（claim_signed_even_subgraph_duality_up_to_sign）を x = q で評価し、
# 符号の値を使わずに (1+q)^{2N}/2^N Q^{a,b}_L(t) = |Q^{a,b}_L(q)| と
# (1+q)^{2N}/2^N M_L(t) = M^abs_L(q) を得て、両側評価 M^abs_L(q)/4 <= Z_L(q) <= 2 M^abs_L(q) に着く段を、
# 辺長 1〜3 の実際の Q^{a,b}_L（軌道ごとの明示積）と、配位の総当たりで数えた Z_L(q) で検算する。
from itertools import product as cartesian_product
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

def partition_value(length, q):
    # 周期境界の正方格子で、破れたボンドの本数 m に q^m を割り当てて総和を取る
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
    N = length^2
    polynomials = {}
    for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
        points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
        polynomials[(a, b)] = prod(factors, R.one())
    for q in (QQ(1)/2, QQ(3)/5, QQ(3)/4, QQ(9)/10):
        # 高温側の条件
        assert 0 < q < 1 and q^2 + 2*q - 1 > 0
        t = (1 - q)/(1 + q)
        assert 0 < t < 1 and t^2 + 2*t - 1 < 0
        Qq = {spin: rational(P(q)) for spin, P in polynomials.items()}
        Qt = {spin: rational(P(t)) for spin, P in polynomials.items()}
        scale = (1 + q)^(2*N)/2^N
        for spin in polynomials:
            # 符号を除いた自己双対性の x = q での値（符号は 1 か -1 のどちらか）
            assert (1 + q)^(2*N)*Qt[spin] in (2^N*Qq[spin], -2^N*Qq[spin])
            # 双対点の値は正（claim_signed_even_subgraph_rational_sign）
            assert Qt[spin] > 0
            # 左辺は正なので絶対値に等しい
            assert scale*Qt[spin] == abs(Qq[spin])
        M_t = max(Qt.values())
        M_abs = max(abs(v) for v in Qq.values())
        # 正の有理数倍は最大値を保つ
        assert scale*M_t == M_abs
        Z = partition_value(length, q)
        # 有限トーラス公式
        assert 2*Z == sum(Qq.values())
        # 下界の書き直しと両側評価
        assert Z >= (1 + q)^(2*N)/2^(N + 2)*M_t
        assert (1 + q)^(2*N)/2^(N + 2)*M_t == M_abs/4
        assert M_abs/4 <= Z <= 2*M_abs
print('RESULT: PASS duality absolute values')
