# 対象ラベル: claim_integer_stage_full_configurations_uncountable
# 併せて検証: def_integer_stage_finite_support_configurations, def_negation_map
# 判定: 候補列の有限接頭辞を二値行列で全数列挙し、対角成分を反転した行が
#       各候補行とその行番号の成分で異なることを確かめる。
# 帰属: 有限集合と NN。浮動小数点、除算、R/C、位相、測度、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

prefixes_checked = 0
candidate_lists_checked = 0
row_inequalities_checked = 0

for prefix_length in range(1, 5):
    for flattened in itertools.product(STATES, repeat=prefix_length * prefix_length):
        candidate_rows = tuple(
            tuple(flattened[row * prefix_length + column]
                  for column in range(prefix_length))
            for row in range(prefix_length)
        )
        diagonal = diagonal_prefix(candidate_rows)

        assert len(diagonal) == prefix_length
        assert all(value in STATES for value in diagonal)
        for index, candidate in enumerate(candidate_rows):
            assert diagonal[index] == ZZ(1) - candidate[index]
            assert diagonal[index] != candidate[index]
            assert diagonal != candidate
            row_inequalities_checked += 1

        candidate_lists_checked += 1
    prefixes_checked += 1

assert prefixes_checked > 0
assert candidate_lists_checked > 0
assert row_inequalities_checked > 0
print('prefix lengths checked:', prefixes_checked)
print('candidate lists checked:', candidate_lists_checked)
print('row inequalities checked:', row_inequalities_checked)
print('RESULT: PASS')
