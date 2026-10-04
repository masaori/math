# 対象ラベル: claim_gauged_terminal_matrix_entries
# 式ペア: B_{\vec e,\vec g}C(0) = B_{\vec e,\vec g}0
# 帰属: 有限な辺添字、円分体とその一変数多項式環。
import os
if '_gt_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_gt_check('right_zero', 2, 'check_right_zero_embedded_zero')
