# 対象ラベル: claim_binary_ca_real_parameter_symmetry_action_trivial
# 式ペア・判定: m=|Sym(F)|! に対し全 g in Sym(F) で g^m=id。
# 帰属: 有限集合、NN、有限置換表。t=m(t/m) は実数加法群の整除可能性として本文で扱う。
# 実数を浮動小数点で近似せず、位相、対数、極限、微分は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

map_count = ZZ(0)
power_count = ZZ(0)
for size in range(1, 5):
    identity = identity_table(size)
    for global_map in self_maps(size):
        symmetries = commuting_symmetries(global_map)
        exponent = ZZ(factorial(len(symmetries)))
        assert exponent > 0
        for symmetry in symmetries:
            assert table_power(symmetry, exponent) == identity
            power_count += 1
        map_count += 1

assert map_count == ZZ(288)
assert power_count > 0
print('global maps checked:', map_count)
print('finite-group power identities checked:', power_count)
print('RESULT: PASS')
