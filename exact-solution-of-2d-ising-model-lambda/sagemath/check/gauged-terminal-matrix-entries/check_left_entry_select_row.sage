# 対象ラベル: claim_gauged_terminal_matrix_entries
# 式ペア: \sum_{\vec g\in\vec E_L}\widehat V_{\vec e,\vec g}A_{\vec g,\vec f} = \widehat V_{\vec e,\vec e}A_{\vec e,\vec f}
# 帰属: 有限な辺添字、円分体とその一変数多項式環。
import os
if '_gt_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_gt_check('left_entry', 1, 'check_left_entry_select_row')
