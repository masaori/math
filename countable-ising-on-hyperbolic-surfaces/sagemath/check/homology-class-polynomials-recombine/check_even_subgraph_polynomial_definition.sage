# SageMath: 偶辺部分集合上の有限和が偶部分グラフ多項式であることの厳密検算
# 対象ラベル: theorem_homology_class_polynomials_recombine
# 式: sum_{A in Z_1(G)} u^{|E|-|A|}v^{|A|} = Q_G(u,v)
# 帰属: 形式的有限集合と ZZ[u,v] だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

expected_even_subgraph_polynomial = u^3 + 3 * u * v^2

assert even_subgraph_polynomial == expected_even_subgraph_polynomial
assert sector_polynomial_sum == even_subgraph_polynomial

print("RESULT: PASS — the recombined finite sum is exactly the even-subgraph polynomial")
