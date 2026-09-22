# 対象ラベル: def_finite_local_update_coefficient_factor
# 場合分け: y(v)=f_v(x|N(v)) なら L^F_v(x,y)=e_{\{v\}}、そうでなければ L^F_v(x,y)=0_V。
# 帰属: 二元有限配位集合、有限真理値表、ZZ。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cells = (ZZ(0), ZZ(1))
states = binary_configurations(cells)
rule_family_checks = ZZ(0)
factor_checks = ZZ(0)
matching_factors = ZZ(0)
zero_factors = ZZ(0)

for truth_bits in product((ZZ(0), ZZ(1)), repeat=len(cells) * len(states)):
    rule_family = full_neighborhood_rule_family(cells, states, truth_bits)
    rule_family_checks += 1
    for source, target, cell in product(states, states, cells):
        factor = local_update_coefficient_factor(cells, rule_family, cell, source, target)
        indicator = local_update_indicator(cells, rule_family, cell, source, target)
        expected = basis_table(cells, (cell,)) if indicator == 1 else zero_table(cells)
        assert factor == expected
        assert set(factor.values()).issubset({ZZ(0), ZZ(1)})
        factor_checks += 1
        matching_factors += indicator
        zero_factors += ZZ(1) - indicator

assert rule_family_checks == ZZ(2) ** (len(cells) * len(states))
assert factor_checks == rule_family_checks * len(states) ** 2 * len(cells)
assert matching_factors == zero_factors
print('full-neighborhood rule families checked:', rule_family_checks)
print('local coefficient factors checked:', factor_checks)
print('matching and zero factors:', matching_factors, zero_factors)
print('RESULT: PASS')
