# 対象ラベル: claim_probabilistic_membership_finite_decidable
# 併せて検証: def_rational_probabilistic_local_rule_family
# 有限有理表の全項比較による所属判定を、明示した候補値と局所入力の全表で検査する。
# 帰属: 有限集合、QQ、ZZ。有理数体上の除算だけを使い、未定義の対数・除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_common.sage'))

candidate_weights = (QQ(-1) / QQ(2), QQ(0), QQ(1) / QQ(2), QQ(1), QQ(3) / QQ(2))
table_count = ZZ(0)
accepted_count = ZZ(0)
rejected_count = ZZ(0)
comparison_count = ZZ(0)

for cell_count in (1, 2):
    inputs = configurations(cell_count)
    for table in local_tables(cell_count, candidate_weights):
        comparisons = tuple(QQ(0) <= table[local_input] <= QQ(1) for local_input in inputs)
        decision = all(comparisons)
        assert decision == is_probabilistic_table(table)
        assert decision == all(table[local_input] in (QQ(0), QQ(1) / QQ(2), QQ(1)) for local_input in inputs)
        table_count += 1
        comparison_count += len(inputs)
        if decision:
            accepted_count += 1
        else:
            rejected_count += 1

assert table_count == ZZ(650)
assert accepted_count == ZZ(90)
assert rejected_count == ZZ(560)
assert comparison_count == ZZ(2550)
print('candidate rational tables checked:', table_count)
print('accepted tables:', accepted_count)
print('rejected tables:', rejected_count)
print('rational order comparisons checked:', comparison_count)
print('RESULT: PASS')
