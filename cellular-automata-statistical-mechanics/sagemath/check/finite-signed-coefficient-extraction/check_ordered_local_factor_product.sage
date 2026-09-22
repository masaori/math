# 対象ラベル: def_finite_ordered_local_factor_product
# 式ペア: 順序付き反交換積 = (prod_v delta^F_v(x,y)) m_V(iota)。
# 帰属: 二元有限配位集合、有限外積係数表、ZZ。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cells = (ZZ(0), ZZ(1))
states = binary_configurations(cells)
rule_family_checks = ZZ(0)
ordered_product_checks = ZZ(0)

for truth_bits in product((ZZ(0), ZZ(1)), repeat=len(cells) * len(states)):
    rule_family = full_neighborhood_rule_family(cells, states, truth_bits)
    rule_family_checks += 1
    for source, target in product(states, repeat=2):
        iterated_product = ordered_local_factor_product(cells, rule_family, source, target)
        explicit_product = explicit_ordered_local_product(cells, rule_family, source, target)
        assert iterated_product == explicit_product
        assert top_coefficient(cells, iterated_product) in (ZZ(0), ZZ(1))
        ordered_product_checks += 1

assert rule_family_checks == ZZ(256)
assert ordered_product_checks == rule_family_checks * len(states) ** 2
print('full-neighborhood rule families checked:', rule_family_checks)
print('ordered local products checked:', ordered_product_checks)
print('RESULT: PASS')
