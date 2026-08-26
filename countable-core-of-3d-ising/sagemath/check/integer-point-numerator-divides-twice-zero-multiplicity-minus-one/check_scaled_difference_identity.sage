# 対象ラベル: claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one
# 定数項分離後に両辺から 1 を引いて 2 倍する等式を ZZ 上で確認する。

R = PolynomialRing(ZZ, names=("a", "omega0", "S"))
a, omega0, S = R.gens()
partition_value = omega0 + a * S

assert 2 * (partition_value - 1) == 2 * (omega0 - 1) + 2 * a * S

print("RESULT: PASS")
