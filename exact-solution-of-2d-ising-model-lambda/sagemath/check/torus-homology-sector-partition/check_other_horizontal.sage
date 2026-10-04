# 対象ラベル: claim_torus_homology_sector_partition
# 式ペア: a' = epsilon_h(A)
# 帰属: 有限集合と ZZ の非負整数。

load('sagemath/check/torus-homology-sector-partition/construction.sage')

checked = 0
for L, subset, witness, candidates in sector_partition_rows():
    for candidate in candidates:
        assert candidate[0] == sector_partition_witness(L, subset)[0]
    checked += 1
assert checked == 1060
print('check_other_horizontal.sage: RESULT: PASS (%d 偶部分グラフ)' % checked)
