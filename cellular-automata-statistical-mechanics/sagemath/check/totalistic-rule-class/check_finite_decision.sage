# 対象ラベル: claim_totalistic_membership_finite_decidable
# 併せて検証: claim_totalistic_pairwise_characterization, def_totalistic_local_rule_family
# 有限走査の判定と、有限表 phi の全数列挙による存在判定が一致することを検査する。
# 帰属: 有限集合、有限写像表、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stage_count = ZZ(0)
family_count = ZZ(0)
accepted_count = ZZ(0)
rejected_count = ZZ(0)

for cell_count in range(3):
    for cells, stage in closed_neighborhood_stages(cell_count):
        stage_count += 1
        entries = local_input_entries(cells, stage)
        candidate_tables = all_binary_tables(signature_domain(cell_count))
        for outputs in itertools.product(STATES, repeat=len(entries)):
            family = dict(zip(entries, outputs))
            by_finite_scan = pairwise_condition(cells, stage, family)
            by_table_existence = any(
                family_matches_table(cells, stage, family, table)
                for table in candidate_tables
            )
            assert by_finite_scan == by_table_existence
            if by_finite_scan:
                accepted_count += 1
            else:
                rejected_count += 1
            family_count += 1

assert stage_count == ZZ(4)
assert family_count == ZZ(277)
assert accepted_count == ZZ(25)
assert rejected_count == ZZ(252)
assert accepted_count + rejected_count == family_count
print('closed-neighborhood stages checked:', stage_count)
print('all local-rule families checked:', family_count)
print('accepted and rejected:', accepted_count, rejected_count)
print('RESULT: PASS')
