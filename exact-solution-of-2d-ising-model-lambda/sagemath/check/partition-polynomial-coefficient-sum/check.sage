# 対象ラベル: claim_coefficient_sum
#
# 本文（structured-latex/content/partition-polynomial.ts）の主張
#     sum_m Omega_L(m) = 2^(L^2)
# を、小さい L で総当たりに数え上げて確かめる。
#
# 厳密計算のみ（ZZ / QQ / ZZ['x']）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def report(L):
    """L x L 周期格子について、本文の各段を数え上げで確かめる。"""
    Z = partition_polynomial(L)                 # def_partition_polynomial
    multiplicities = multiplicity_vector(L)     # def_multiplicity
    coefficient_sum = sum(multiplicities)       # 本文 Step 3 の右辺
    configuration_count = ZZ(2) ** (L * L)      # def_configuration（本文 Step 4）

    # 本文 Step 5: 係数の総和と配位の総数が一致する。
    assert coefficient_sum == configuration_count, (L, coefficient_sum, configuration_count)
    # 同じことを多項式の 1 での値としても見る（Z_L(1) = 係数和）。
    assert Z(1) == configuration_count, (L, Z(1), configuration_count)
    # 係数はすべて非負整数（数え上げなので N の元）。
    assert all(c >= 0 for c in Z.coefficients(sparse=False)), L
    # 次数は辺数 2L^2 を超えない（def_broken_bond_count の上界）。
    assert Z.degree() <= 2 * L * L, (L, Z.degree())

    # 有理点での値と、その素因数分解（章「有限系の自由エントロピー」への橋渡し）。
    q = QQ(1) / 2
    value = Z(q)
    factorization = factor(value)

    print('L =', L)
    print('  Z_L(x)              =', Z)
    print('  sum_m Omega_L(m)    =', coefficient_sum)
    print('  2^(L^2)             =', configuration_count)
    print('  Z_L(1/2)            =', value, '=', factorization)
    print('  Phi_L = log Z_L(1/2) の指数ベクトル（素数: 指数）:',
          {p: e for (p, e) in factorization})


for L in [1, 2, 3]:
    report(L)

print()
print('OK: sum_m Omega_L(m) = 2^(L^2) を L = 1, 2, 3 で確認した（厳密計算）')
