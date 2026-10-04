# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
import os
_pdgi_check_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_pdgi_check_dir, "_prelude.sage"))
for case in _pdgi_cases:
    Ux, Vx = case["Ux"], case["Vx"]
    I = identity_matrix(case["C"], Ux.nrows())
    assert all(p.degree() <= 0 for p in Ux.list() + Vx.list())
    assert Ux * Vx == I and Vx * Ux == I
    assert Vx == Ux.inverse()
print("独立な多項式行列の逆行列計算: PASS (%s 行列)" % len(_pdgi_cases))
check_files = ['check_empty_sum_source.sage', 'check_empty_sum_zero.sage', 'check_empty_sum_target.sage', 'check_insert_sum_source.sage', 'check_insert_sum_add.sage', 'check_insert_sum_induction.sage', 'check_insert_sum_target.sage', 'check_identity_diagonal_source.sage', 'check_identity_diagonal_one.sage', 'check_identity_diagonal_target.sage', 'check_identity_off_diagonal_source.sage', 'check_identity_off_diagonal_zero.sage', 'check_identity_off_diagonal_target.sage', 'check_matrix_product_definition.sage', 'check_matrix_entries.sage', 'check_matrix_product_map.sage', 'check_matrix_sum_map.sage', 'check_matrix_source_product.sage', 'check_matrix_source_inverse.sage', 'check_matrix_identity_map.sage']
for check_file in check_files:
    load(os.path.join(_pdgi_check_dir, check_file))
print("RESULT: PASS (%s 行別ファイル)" % len(check_files))
