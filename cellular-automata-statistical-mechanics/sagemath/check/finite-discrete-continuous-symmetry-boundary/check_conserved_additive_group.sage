# 対象ラベル: claim_binary_ca_integer_conserved_observables_additive_group
# 式ペア・判定: 保存写像は零写像を含み、点ごとの整数加法と符号反転で閉じる。
# 帰属: 有限集合、ZZ、有限整数値表。実数体、対数、除算、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

map_count = ZZ(0)
addition_count = ZZ(0)
negation_count = ZZ(0)
for size in range(1, 5):
    zero = tuple(ZZ(0) for _ in range(size))
    for global_map in self_maps(size):
        observables = conserved_observables(global_map)
        assert is_conserved(global_map, zero)
        for observable in observables:
            assert is_conserved(global_map, observable_negate(observable))
            negation_count += 1
            for other in observables:
                assert is_conserved(global_map, observable_add(observable, other))
                addition_count += 1
        map_count += 1

assert map_count == ZZ(288)
assert addition_count > 0
assert negation_count > 0
print('global maps checked:', map_count)
print('observable sums checked:', addition_count)
print('observable negations checked:', negation_count)
print('RESULT: PASS')
