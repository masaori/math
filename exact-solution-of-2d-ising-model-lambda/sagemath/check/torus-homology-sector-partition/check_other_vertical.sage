# 対象ラベル: claim_torus_homology_sector_partition
# 式ペア: b' = epsilon_v(A)
# 帰属: 有限集合と ZZ の非負整数。

load('sagemath/check/torus-homology-sector-partition/construction.sage')

checked = 0
for L, subset, witness, candidates in sector_partition_rows():
    for candidate in candidates:
        assert candidate[1] == sector_partition_witness(L, subset)[1]
    checked += 1
assert checked == 1060
print('check_other_vertical.sage: RESULT: PASS (%d 偶部分グラフ)' % checked)
