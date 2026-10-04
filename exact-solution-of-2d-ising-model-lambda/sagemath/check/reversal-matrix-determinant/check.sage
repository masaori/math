# 対象ラベル: claim_reversal_matrix_determinant_one / def_integer_matrix_determinant
# 全行別検算と、ZZ 行列の行列式の独立計算。
for _name in (
    "check_pair_support.sage",
    "check_swap_commutation.sage",
    "check_composition_action.sage",
    "check_swap_action.sage",
    "check_reversal_action.sage",
    "check_sign_composition_substitution.sage",
    "check_sign_multiplicativity.sage",
    "check_transposition_signs.sage",
    "check_constant_sign_product.sage",
    "check_edge_cardinality.sage",
    "check_power_multiplication.sage",
    "check_negative_one_square.sage",
    "check_unit_power.sage",
    "check_mismatch_entry.sage",
    "check_zero_row_product.sage",
    "check_zero_product_substitution.sage",
    "check_zero_weighted_term.sage",
    "check_determinant_definition.sage",
    "check_sum_single_reversal.sage",
    "check_selected_entries.sage",
    "check_unit_product.sage",
    "check_unit_multiplication.sage",
    "check_reversal_sign_one.sage",
):
    load('sagemath/check/reversal-matrix-determinant/' + _name)

for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    computed = J.det()
    sage_sign = Permutation([image + 1 for image in reverse]).signature()
    assert computed == ZZ(1)
    assert sign(reverse) == sage_sign
    nonzero = nonzero_permutations(J)
    assert nonzero == (reverse,)
    selected = selected_permutations(L)
    assert len(selected) == (24 if L == 1 else 2 * len(directed))
    print("L=%d: dimension=%d, representative_permutations=%d, nonzero_terms=%d, det=%s"
          % (L, len(directed), len(selected), len(nonzero), computed))
print("RESULT: PASS (independent integer determinants, 5 matrices)")
