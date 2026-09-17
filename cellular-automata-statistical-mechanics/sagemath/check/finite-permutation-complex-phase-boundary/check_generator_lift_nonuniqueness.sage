# 対象ラベル: claim_binary_ca_real_phase_generator_not_unique
# 式ペア・判定: k/d+n は n により異なるが、整数剰余では全て k/d と同じ位相符号を表す。
# 帰属: 有限集合、ZZ、QQ。2*pi/tau は正の共通実数係数として本文で扱い、浮動小数点、複素対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

permutation_count = ZZ(0)
phase_code_count = ZZ(0)
lift_pair_count = ZZ(0)
lift_indices = tuple(ZZ(index) for index in range(-4, 5))
for size in range(1, 9):
    for table in permutations(range(size)):
        permutation = tuple(table)
        for cycle in cycle_partition(permutation):
            cycle_length = ZZ(len(cycle))
            for code in range(cycle_length):
                base = QQ(code) / QQ(cycle_length)
                lifts = {index: base + QQ(index) for index in lift_indices}
                for index, lift in lifts.items():
                    assert lift - base == QQ(index)
                    assert (lift - base).denominator() == 1
                for left in lift_indices:
                    for right in lift_indices:
                        if left != right:
                            assert lifts[left] != lifts[right]
                            assert lifts[left] - lifts[right] == QQ(left - right)
                            lift_pair_count += 1
                phase_code_count += 1
        permutation_count += 1

assert permutation_count == ZZ(46233)
assert phase_code_count > 0
assert lift_pair_count > 0
print('permutations checked:', permutation_count)
print('phase codes checked:', phase_code_count)
print('distinct integer-lift pairs checked:', lift_pair_count)
print('RESULT: PASS')

