# 対象ラベル: claim_four_part_repeated_difference
# 第三列の内部和の増分。帰属: ZZ^2 と ZZ。
import os
import sys
if '_four_part_repeat_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for case in _four_part_repeat_cases:
    assert case['differences'][4] == case['differences'][5]
print('PASS: difference_return (%d cases)' % len(_four_part_repeat_cases))
