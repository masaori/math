# 対象ラベル: claim_four_part_repeated_difference
# 四部分分割。帰属: ZZ^2 と ZZ。
import os
import sys
if '_four_part_repeat_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for case in _four_part_repeat_cases:
    assert case['stages'][0] == case['stages'][1]
print('PASS: four_part_split (%d cases)' % len(_four_part_repeat_cases))
