# 対象ラベル: claim_classical_nondegeneracy_does_not_imply_yang_baxter
# 式ペア: (Q12 o Q23 o Q12)(1,0,0)=(0,1,1)、(Q23 o Q12 o Q23)(1,0,0)=(1,1,1)。
# 帰属: 二元有限集合と有限写像表。実数体・複素数体・浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

size = ZZ(2)
table = (0, 2, 3, 1)
witness = (ZZ(1), ZZ(0), ZZ(0))

left_first = adjacent_12(table, size, witness)
left_second = adjacent_23(table, size, left_first)
left_result = adjacent_12(table, size, left_second)
right_first = adjacent_23(table, size, witness)
right_second = adjacent_12(table, size, right_first)
right_result = adjacent_23(table, size, right_second)

assert left_first == (1, 1, 0)
assert left_second == (1, 1, 1)
assert left_result == (0, 1, 1)
assert right_first == (1, 0, 0)
assert right_second == (1, 1, 0)
assert right_result == (1, 1, 1)
assert left_result == braid_left(table, size, witness)
assert right_result == braid_right(table, size, witness)
assert left_result != right_result
assert any(braid_left(table, size, triple) != braid_right(table, size, triple) for triple in all_triples(size))
print('left composition at witness:', left_result)
print('right composition at witness:', right_result)
print('RESULT: PASS')
