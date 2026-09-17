# 対象ラベル: claim_binary_ca_commuting_configuration_symmetries_finite_group
# 式ペア・判定: F と可換する全単射が恒等写像・合成・逆写像で閉じる。
# 帰属: 有限集合とその上の有限写像表。実数体、対数、除算、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

map_count = ZZ(0)
product_count = ZZ(0)
inverse_count = ZZ(0)
for size in range(1, 5):
    identity = identity_table(size)
    for global_map in self_maps(size):
        symmetries = commuting_symmetries(global_map)
        symmetry_set = set(symmetries)
        assert identity in symmetry_set
        for symmetry in symmetries:
            assert compose(symmetry, global_map) == compose(global_map, symmetry)
            assert inverse_permutation(symmetry) in symmetry_set
            inverse_count += 1
            for other in symmetries:
                assert compose(symmetry, other) in symmetry_set
                product_count += 1
        map_count += 1

assert map_count == ZZ(288)
assert product_count > 0
assert inverse_count > 0
print('global maps checked:', map_count)
print('symmetry products checked:', product_count)
print('symmetry inverses checked:', inverse_count)
print('RESULT: PASS')
