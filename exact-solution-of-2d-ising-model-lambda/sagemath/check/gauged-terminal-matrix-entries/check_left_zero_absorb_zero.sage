# 対象ラベル: claim_gauged_terminal_matrix_entries
# 式ペア: 0A_{\vec g,\vec f} = 0
# 帰属: 有限な辺添字、円分体とその一変数多項式環。
import os
if '_gt_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_gt_check('left_zero', 3, 'check_left_zero_absorb_zero')
