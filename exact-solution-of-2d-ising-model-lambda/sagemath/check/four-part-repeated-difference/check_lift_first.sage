# 対象ラベル: claim_four_part_repeated_difference
# 反復列の端点の同定。帰属: ZZ^2 と ZZ。
import os
import sys
if '_four_part_repeat_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for case in _four_part_repeat_cases:
    assert case['ends'][0][0] == case['ends'][0][1]
print('PASS: lift_first (%d cases)' % len(_four_part_repeat_cases))
