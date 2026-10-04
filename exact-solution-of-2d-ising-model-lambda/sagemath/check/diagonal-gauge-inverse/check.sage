# 対象ラベル: claim_diagonal_gauge_inverse
import os
_dg_check_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dg_check_dir, "_prelude.sage"))
for case in _dg_cases:
    assert case["z"]^4 == -1 and case["z"] != 0
    assert all(0 <= r < 4 for r in case["directions"])
    assert all(k in (0, 1) for k in case["parities"])
    U, V = case["U"], case["V"]
    I = identity_matrix(_dg_field, U.nrows())
    assert V == U.inverse()
    assert U * V == I and V * U == I
assert _dg_field(0)^4 != -1
print("独立な逆行列計算: PASS (%s 行列)" % len(_dg_cases))
check_files = ('check_associate_outer.sage', 'check_associate_inner.sage', 'check_combine_q_powers.sage', 'check_cancel_q_exponents.sage', 'check_q_zero_power.sage', 'check_remove_unit.sage', 'check_combine_p_powers.sage', 'check_cancel_p_exponents.sage', 'check_p_zero_power.sage', 'check_forward_weight.sage', 'check_forward_inverse_weight.sage', 'check_forward_cancellation.sage', 'check_backward_inverse_weight.sage', 'check_backward_weight.sage', 'check_backward_double_negative_p.sage', 'check_backward_double_negative_q.sage', 'check_backward_cancellation.sage', 'check_zero_entry.sage', 'check_zero_product.sage', 'check_matrix_product.sage', 'check_remove_zero_terms.sage', 'check_left_diagonal_entry.sage', 'check_right_diagonal_entry.sage', 'check_diagonal_product.sage', 'check_identity_diagonal.sage', 'check_right_zero_entry.sage', 'check_right_zero_product.sage', 'check_identity_off_diagonal.sage')
for check_file in check_files:
    load(os.path.join(_dg_check_dir, check_file))
print("RESULT: PASS (%s 行別ファイル)" % len(check_files))
