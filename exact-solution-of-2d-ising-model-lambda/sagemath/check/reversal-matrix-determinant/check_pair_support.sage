# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: S_e=\{(e,0),(e,1)\},\quad S_e\cap S_f=\varnothing\ (e\ne f)
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    supports = []
    for e, swap in enumerate(swaps, 1):
        support = frozenset(edge for k, edge in enumerate(directed) if swap[k] != k)
        assert support == frozenset(((e, 0), (e, 1)))
        supports.append(support)
        checked += 1
    for e in range(len(supports)):
        for f in range(e + 1, len(supports)):
            assert supports[e].isdisjoint(supports[f])
            checked += 1
print("RESULT: PASS (pair_support, %d cases)" % checked)
