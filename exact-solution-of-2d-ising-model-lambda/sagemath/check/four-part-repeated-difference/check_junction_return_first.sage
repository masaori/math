# 対象ラベル: claim_four_part_repeated_difference
# 四接合への一つの端点の代入。帰属: ZZ^2 と ZZ。
import os
import sys
if '_four_part_repeat_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for case in _four_part_repeat_cases:
    assert case['joints'][1] == case['joints'][2]
print('PASS: junction_return_first (%d cases)' % len(_four_part_repeat_cases))
