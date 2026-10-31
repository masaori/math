"""Kac--Ward 行列式の置換項の非零条件を有限標本で厳密検査する。"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")

for L in (2,):
    oriented = edges(L)
    for a in (0, 1):
        for b in (0, 1):
            m = matrix(K8, len(oriented), len(oriented), lambda r, s:
                       transition_entry(L, a, b, oriented[r], oriented[s]))
            # 先頭六辺だけを置換し、残りは固定する。6! 個を全数検査する。
            for image in Permutations(range(6)):
                sigma = list(image) + list(range(6, len(oriented)))
                product = P(1)
                condition = True
                for i in range(len(oriented)):
                    diagonal = P(1) if i == sigma[i] else P(0)
                    product *= diagonal - x * P(m[i, sigma[i]])
                    if sigma[i] != i:
                        condition = condition and m[i, sigma[i]] != 0
                assert (product != 0) == condition

print("PASS: determinant term nonzero iff every moved transition is nonzero")
