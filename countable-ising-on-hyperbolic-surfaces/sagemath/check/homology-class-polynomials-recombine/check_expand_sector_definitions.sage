# SageMath: 類別生成多項式の定義を全ホモロジー類について展開する等式の厳密検算
# 対象ラベル: theorem_homology_class_polynomials_recombine
# 式: sum_h Q_{C,h}(u,v) = sum_h sum_{A in eta_C^{-1}({h})} u^{|E|-|A|}v^{|A|}
# 帰属: 形式的有限集合、GF(2) 上の有限商、ZZ[u,v] だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

assert sector_polynomial_sum == expanded_fiber_sum
assert sector_polynomial_sum == u^3 + 3 * u * v^2

print("RESULT: PASS — expanding every sector polynomial gives the nested finite fiber sum")
