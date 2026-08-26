# 対象ラベル: claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one
# a が全体と a の倍数を割るなら定数項側の差も割ることを ZZ 上で確認する。

checked = ZZ(0)
for a in range(1, 65):
    a = ZZ(a)
    for omega0 in range(0, 33):
        omega0 = ZZ(omega0)
        for S in range(0, 65):
            S = ZZ(S)
            partition_value = omega0 + a * S
            if not a.divides(2 * (partition_value - 1)):
                continue
            assert a.divides(2 * a * S)
            assert 2 * (omega0 - 1) == 2 * (partition_value - 1) - 2 * a * S
            assert a.divides(2 * (omega0 - 1))
            checked += 1

assert checked > 0
print("RESULT: PASS (", checked, " exact cases)")
