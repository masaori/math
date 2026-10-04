# 対象ラベル: claim_torus_homology_sector_partition
# 式ペア: A in E_L^{a,b}
# 帰属: 有限集合と ZZ の非負整数。

load('sagemath/check/torus-homology-sector-partition/construction.sage')

checked = 0
for L, subset, witness, candidates in sector_partition_rows():
    assert sector_partition_membership(L, subset, witness)
    checked += 1
assert checked == 1060
print('check_witness_membership.sage: RESULT: PASS (%d 偶部分グラフ)' % checked)
