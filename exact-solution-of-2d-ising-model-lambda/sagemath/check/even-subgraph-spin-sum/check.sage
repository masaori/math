# 対象ラベル: claim_even_subgraph_spin_sum
# 帰属: 頂点・辺・配位は有限集合、次数は ZZ。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))
load(os.path.join(_dir, 'check_monomial_regrouping.sage'))


for L in (1, 2):
    checked = 0
    for subset in edge_subsets(L):
        expected = ZZ(2) ** (L * L) if is_even_subgraph(L, subset) else ZZ(0)
        assert direct_spin_sum(L, subset) == expected
        assert factorized_spin_sum(L, subset) == expected
        checked += 1
    print("L=%d: %d 個の辺部分集合を配位の全数和で検査" % (L, checked))

L = 3
checked = 0
for subset in edge_subsets(L):
    expected = ZZ(2) ** (L * L) if is_even_subgraph(L, subset) else ZZ(0)
    assert factorized_spin_sum(L, subset) == expected
    checked += 1
print("L=3: %d 個の辺部分集合を頂点ごとの厳密因数分解で検査" % checked)

print("RESULT: PASS")
