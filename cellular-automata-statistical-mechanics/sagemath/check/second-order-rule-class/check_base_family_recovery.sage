# 対象ラベル: claim_second_order_base_family_unique
# 二次規則からの基礎表の回復と、同じ二次表を与える基礎表の一意性を全数検査する。
# 帰属: 有限集合と二元体加法の有限表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

neighborhood_count = ZZ(0)
base_table_count = ZZ(0)
candidate_comparison_count = ZZ(0)
for cell_count in range(3):
    cells = tuple(range(cell_count))
    for flags in itertools.product((False, True), repeat=cell_count):
        neighborhood = frozenset(cell for cell, present in zip(cells, flags) if present)
        local_inputs = inputs(neighborhood)
        base_tables = all_tables(local_inputs)
        for base in base_tables:
            lifted = lift_base_table(neighborhood, base)
            recovered = recovered_base_table(neighborhood, lifted)
            assert recovered == base
            assert is_second_order(neighborhood, lifted)
            for candidate in base_tables:
                candidate_represents_lifted = all(
                    lifted[(local_input, previous)] == add(candidate[local_input], previous)
                    for local_input, previous in second_order_domain(neighborhood)
                )
                assert candidate_represents_lifted == (candidate == base)
                candidate_comparison_count += 1
            base_table_count += 1
        neighborhood_count += 1

assert neighborhood_count == ZZ(7)
assert base_table_count == ZZ(34)
assert candidate_comparison_count == ZZ(316)
print('neighborhoods checked:', neighborhood_count)
print('base truth tables checked:', base_table_count)
print('uniqueness comparisons checked:', candidate_comparison_count)
print('RESULT: PASS')
