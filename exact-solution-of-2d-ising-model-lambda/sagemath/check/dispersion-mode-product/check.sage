# 対象ラベル: claim_dispersion_mode_product
# 既存の Fourier 相似とファイバーの検査を読み、最後の有限積を照合する。
import os
import sys

base = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(base, '..', 'fourier-similarity-determinant', 'check.sage'))
load(os.path.join(base, '..', 'fourier-mode-block-entries', 'check.sage'))

for L in range(1, 3):
    edges = [(i, j, d) for i in range(L) for j in range(L) for d in range(4)]
    for a in (0, 1):
        for b in (0, 1):
            pairs = [(v, w)
                     for v in (xroots**L - (-1)**a).roots(K, multiplicities=False)
                     for w in (xroots**L - (-1)**b).roots(K, multiplicities=False)]
            M = matrix(K, len(edges), len(edges),
                       lambda i, j: twist(edges[j], L, a, b) *
                       phase(edges[i][2], edges[j][2])
                       if edges[j][:2] == target(edges[i], L)
                       and edges[j][2] != (edges[i][2] + 2) % 4 else 0)
            D = (identity_matrix(R, len(edges)) - x * M.change_ring(R)).det()
            factors = [((1 + x**2)**2 - x * (1 - x**2) *
                        (v + v**(-1) + w + w**(-1))) for v, w in pairs]
            assert D == prod(factors)
print('PASS: determinant equals the dispersion product for L=1,2 and four twists')
