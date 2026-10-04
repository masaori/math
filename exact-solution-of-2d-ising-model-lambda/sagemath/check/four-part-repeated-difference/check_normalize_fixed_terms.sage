# 対象ラベル: claim_four_part_repeated_difference
# 二つの反復内部和と固定項への整理。帰属: ZZ^2 と ZZ。
import os
import sys
if '_four_part_repeat_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for case in _four_part_repeat_cases:
    assert case['stages'][4] == case['stages'][5]
print('PASS: normalize_fixed_terms (%d cases)' % len(_four_part_repeat_cases))
