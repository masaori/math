# 対象ラベル: claim_torus_homology_sector_partition
# 式ペア: epsilon_v(A) = b
# 帰属: 有限集合と ZZ の非負整数。

load('sagemath/check/torus-homology-sector-partition/construction.sage')

checked = 0
for L, subset, witness, candidates in sector_partition_rows():
    assert sector_partition_witness(L, subset)[1] == witness[1]
    checked += 1
assert checked == 1060
print('check_witness_vertical.sage: RESULT: PASS (%d 偶部分グラフ)' % checked)
