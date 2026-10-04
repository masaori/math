# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: 2 sum_{B in B_L} x^{|B|} = 2 sum_{B in B_L} x^{|Delta_L(B)|}
# 帰属: ZZ[x]。
for L, attainable, _, _, _, _ in polynomial_rows:
    assert ZZ(2) * sum((x ** ZZ(len(B)) for B in attainable), R.zero()) == ZZ(2) * sum(
        (x ** ZZ(len(delta_restriction(L, B))) for B in attainable), R.zero())
print('weight_cardinality_substitution PASS', len(polynomial_rows))
