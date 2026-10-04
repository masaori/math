# 対象ラベル: claim_gauged_terminal_matrix_entries
# 式ペア: C\bigl(c(v_{\vec e}u_{\vec f})\bigr)A_{\vec e,\vec f} = C(w_{\vec e,\vec f})A_{\vec e,\vec f}
# 帰属: 有限な辺添字、円分体とその一変数多項式環。
import os
if '_gt_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_gt_check('main', 9, 'check_main_weight_definition')
