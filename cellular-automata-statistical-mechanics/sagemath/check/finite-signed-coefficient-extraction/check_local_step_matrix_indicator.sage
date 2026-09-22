# 対象ラベル: theorem_finite_local_factor_step_matrix_equals_update_indicator
# 式チェーン: S_F(x,y)=Top_V(K_F(x,y))=prod_v delta^F_v(x,y)=1_{y=F(x)}=D_F(x,y)。
# 帰属: 二元有限配位集合、有限外積係数表、ZZ と {0,1}。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cells = (ZZ(0), ZZ(1))
states = binary_configurations(cells)
rule_family_checks = ZZ(0)
matrix_entry_checks = ZZ(0)
one_entries = ZZ(0)
zero_entries = ZZ(0)

for truth_bits in product((ZZ(0), ZZ(1)), repeat=len(cells) * len(states)):
    rule_family = full_neighborhood_rule_family(cells, states, truth_bits)
    global_update = global_update_from_full_neighborhood(cells, states, rule_family)
    indicator_matrix = self_map_indicator_matrix(states, global_update)
    extracted_matrix = {}
    for source, target in product(states, repeat=2):
        ordered_product = explicit_ordered_local_product(cells, rule_family, source, target)
        extracted = top_coefficient(cells, ordered_product)
        local_indicator_product = prod(
            local_update_indicator(cells, rule_family, cell, source, target)
            for cell in cells
        )
        expected = ZZ(1) if target == global_update[source] else ZZ(0)
        assert extracted == local_indicator_product
        assert local_indicator_product == expected
        assert expected == indicator_matrix[(source, target)]
        extracted_matrix[(source, target)] = extracted
        matrix_entry_checks += 1
        one_entries += extracted
        zero_entries += ZZ(1) - extracted
    assert extracted_matrix == indicator_matrix
    for source in states:
        assert sum(extracted_matrix[(source, target)] for target in states) == ZZ(1)
    rule_family_checks += 1

assert rule_family_checks == ZZ(256)
assert matrix_entry_checks == rule_family_checks * len(states) ** 2
assert one_entries == rule_family_checks * len(states)
assert zero_entries == matrix_entry_checks - one_entries
print('finite global updates checked:', rule_family_checks)
print('step-matrix entries checked:', matrix_entry_checks)
print('one and zero entries:', one_entries, zero_entries)
print('RESULT: PASS')
