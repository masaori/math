# 対象ラベル: claim_gauged_terminal_matrix_entries
# 式ペア: C(V_{\vec e,\vec e})A_{\vec e,\vec f} = C(v_{\vec e})A_{\vec e,\vec f}
# 帰属: 有限な辺添字、円分体とその一変数多項式環。
import os
if '_gt_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_gt_check('left_entry', 3, 'check_left_entry_diagonal_weight')
