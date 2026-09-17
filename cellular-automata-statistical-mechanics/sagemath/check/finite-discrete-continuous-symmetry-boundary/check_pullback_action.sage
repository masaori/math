# 対象ラベル: claim_binary_ca_symmetry_pullback_preserves_conserved_observables
# 式ペア・判定: 逆写像による引き戻しが保存性、単位律、積との整合律を満たす。
# 帰属: 有限集合、ZZ、有限写像表。実数体、対数、除算、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

preservation_count = ZZ(0)
identity_count = ZZ(0)
compatibility_count = ZZ(0)
for size in range(1, 4):
    identity = identity_table(size)
    for global_map in self_maps(size):
        symmetries = commuting_symmetries(global_map)
        observables = conserved_observables(global_map)
        for observable in observables:
            assert pullback(identity, observable) == observable
            identity_count += 1
            for symmetry in symmetries:
                transformed = pullback(symmetry, observable)
                assert is_conserved(global_map, transformed)
                preservation_count += 1
                for other in symmetries:
                    left = pullback(compose(symmetry, other), observable)
                    right = pullback(symmetry, pullback(other, observable))
                    assert left == right
                    compatibility_count += 1

assert preservation_count > 0
assert identity_count > 0
assert compatibility_count > 0
print('pullback preservation cases checked:', preservation_count)
print('action identity cases checked:', identity_count)
print('action compatibility cases checked:', compatibility_count)
print('RESULT: PASS')
