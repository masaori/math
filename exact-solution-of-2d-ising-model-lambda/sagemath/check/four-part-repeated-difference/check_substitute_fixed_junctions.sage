# 対象ラベル: claim_four_part_repeated_difference
# 固定した接合和の代入。帰属: ZZ^2 と ZZ。
import os
import sys
if '_four_part_repeat_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for case in _four_part_repeat_cases:
    assert case['stages'][3] == case['stages'][4]
print('PASS: substitute_fixed_junctions (%d cases)' % len(_four_part_repeat_cases))
