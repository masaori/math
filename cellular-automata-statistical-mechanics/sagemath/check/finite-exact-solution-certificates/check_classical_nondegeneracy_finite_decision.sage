# 対象ラベル: claim_finite_pair_map_classical_nondegeneracy_decidable
# 判定: 二元集合上の全二体写像について、片側値表の重複検査と全単射判定が一致する。
# 帰属: 有限集合、有限写像表、NN。実数体・複素数体・浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

size = ZZ(2)
pair_map_count = ZZ(0)
slice_count = ZZ(0)
nondegenerate_count = ZZ(0)
for table in product(range(size ** 2), repeat=size ** 2):
    duplicate_scan = all(
        len(set(left_slice(table, size, left))) == size
        for left in range(size)
    ) and all(
        len(set(right_slice(table, size, right))) == size
        for right in range(size)
    )
    permutation_scan = all(
        sorted(left_slice(table, size, left)) == list(range(size))
        for left in range(size)
    ) and all(
        sorted(right_slice(table, size, right)) == list(range(size))
        for right in range(size)
    )
    assert duplicate_scan == permutation_scan
    assert duplicate_scan == is_classically_nondegenerate(table, size)
    pair_map_count += 1
    slice_count += 2 * size
    nondegenerate_count += ZZ(duplicate_scan)

assert pair_map_count == 256
assert slice_count == 1024
assert nondegenerate_count == 16
print('binary pair maps checked:', pair_map_count)
print('one-sided tables checked:', slice_count)
print('classically nondegenerate maps:', nondegenerate_count)
print('RESULT: PASS')
