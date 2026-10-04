# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: 2 sum_{B in B_L} x^{|Delta_L(B)|} = 2 sum_{A in E_L^{0,0}} x^{|A|}
# 帰属: ZZ[x]。右辺の始域は全辺部分集合から独立に列挙する。
for L, attainable, trivial_sector, _, _, _ in polynomial_rows:
    assert ZZ(2) * sum(
        (x ** ZZ(len(delta_restriction(L, B))) for B in attainable), R.zero()) == ZZ(2) * sum(
        (x ** ZZ(len(A)) for A in trivial_sector), R.zero())
print('reindex_sum PASS', len(polynomial_rows))
