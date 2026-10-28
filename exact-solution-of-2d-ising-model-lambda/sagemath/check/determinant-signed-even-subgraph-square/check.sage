# 対象ラベル: claim_determinant_signed_even_subgraph_square
# 行列式、Pfaffian 平方、符号付き偶部分グラフ多項式の式鎖を有限トーラスで検算する。
load('sagemath/check/torus-kac-ward-even-subgraph-square/construction.sage')

checked = 0
for L in (2, 3):
    oriented = edges(L)
    evens = even_subgraphs(L)
    for a in (0, 1):
        for b in (0, 1):
            q = P(0)
            for subset in evens:
                h = sum(seam_parities(L, edge)[0] for edge in subset) % 2
                v = sum(seam_parities(L, edge)[1] for edge in subset) % 2
                q += ZZ(-1) ** ((1+a)*h + (1+b)*v + h*v) * x ** len(subset)
            transition = matrix(P, len(oriented), len(oriented),
                                lambda r, s: P(transition_entry(L, a, b, oriented[r], oriented[s])))
            determinant = (identity_matrix(P, len(oriented)) - x * transition).det()
            assert determinant == q ** 2
            checked += 1

print('RESULT: PASS; %d torus/twist cases in ZZ[x]' % checked)
