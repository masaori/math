# 対象ラベル: claim_classical_nondegeneracy_does_not_imply_yang_baxter
# 判定: 本文の二元二体写像 Q の四つの片側写像が全単射である。
# 帰属: 二元有限集合と有限写像表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

size = ZZ(2)
# Q(0,0)=(0,0), Q(0,1)=(1,0), Q(1,0)=(1,1), Q(1,1)=(0,1)
table = (0, 2, 3, 1)

assert left_slice(table, size, 0) == (0, 1)
assert left_slice(table, size, 1) == (1, 0)
assert right_slice(table, size, 0) == (0, 1)
assert right_slice(table, size, 1) == (0, 1)
assert is_classically_nondegenerate(table, size)
print('left slices:', left_slice(table, size, 0), left_slice(table, size, 1))
print('right slices:', right_slice(table, size, 0), right_slice(table, size, 1))
print('RESULT: PASS')
