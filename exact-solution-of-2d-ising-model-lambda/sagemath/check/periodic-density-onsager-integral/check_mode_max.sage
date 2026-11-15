# 対象ラベル: theorem_periodic_density_onsager_integral
# 四つのモード和の最大値を L^{-2} log_R M^abs_L(q) と同定する段を、辺長 1〜3 の実際の Q^{a,b}_L(q) で検算する。
# Q^{a,b}_L は claim_signed_even_subgraph_orbit_product の軌道ごとの明示積として計算する。
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

RR150 = RealField(150)
for length in range(1, 4):
    products = {}
    for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
        points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
        products[(a, b)] = prod(factors, R.one())
    for q in (QQ(1)/10, QQ(1)/3, QQ(2)/5, QQ(1)/2, QQ(3)/4, QQ(9)/10):
        # q^2 + 2q - 1 != 0（claim_no_rational_square_two）
        assert q^2 + 2*q - 1 != 0
        values = {}
        for spin, polynomial in products.items():
            value = polynomial(q)
            # Q^{a,b}_L(q) は有理数（実部だけ）で、零でない（claim_signed_even_subgraph_rational_sign）
            assert value.imag() == 0
            rational_value = QQ(value.real())
            assert rational_value != 0
            values[spin] = rational_value
        # rho_{R->R}(Q(q)) = iota(Q(q))（claim_cut_realization_agrees_on_rationals）なので被対数は |Q(q)| > 0
        absolute = {spin: abs(value) for spin, value in values.items()}
        maximum = max(absolute.values())
        assert maximum > 0
        # u_{L,a,b} = L^{-2} log_R |Q^{a,b}_L(q)|、v_L = max u
        u = {spin: RR150(value).log() / length^2 for spin, value in absolute.items()}
        v = max(u.values())
        w = RR150(maximum).log() / length^2
        # 最大値を与える添字は、有理数の比較と実対数の比較で一致する（実対数の単調性）
        rational_argmax = {spin for spin, value in absolute.items() if value == maximum}
        real_argmax = {spin for spin, value in u.items() if value == v}
        assert rational_argmax == real_argmax
        # v_L = L^{-2} log_R M^abs_L(q)
        assert v == w
print('RESULT: PASS mode maximum identification')
