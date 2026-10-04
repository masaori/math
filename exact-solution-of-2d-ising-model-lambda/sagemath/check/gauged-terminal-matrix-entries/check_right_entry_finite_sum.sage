# 対象ラベル: claim_gauged_terminal_matrix_entries
# 式ペア: (B\widehat U)_{\vec e,\vec f} = \sum_{\vec g\in\vec E_L}B_{\vec e,\vec g}\widehat U_{\vec g,\vec f}
# 帰属: 有限な辺添字、円分体とその一変数多項式環。
import os
if '_gt_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_gt_check('right_entry', 0, 'check_right_entry_finite_sum')
