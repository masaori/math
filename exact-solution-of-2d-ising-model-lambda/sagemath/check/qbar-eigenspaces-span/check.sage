# 対象ラベル: claim_qbar_eigenspaces_span
# QQbar による厳密計算だけを使う。

def projector(L, A, z, v):
    return sum((z ** (L - k) * (A ** k) * v for k in range(L)),
               vector(QQbar, [0] * A.nrows()))


def check_span():
    count = 0
    for L in range(1, 5):
        dimension = 2 ** L
        roots = [QQbar.zeta(L) ** j for j in range(L)]
        A = diagonal_matrix(QQbar, [roots[j % L] for j in range(dimension)])
        assert A ** L == identity_matrix(QQbar, dimension)
        v = vector(QQbar, [QQbar(j + 1) for j in range(dimension)])
        terms = []
        for z in roots:
            u = QQbar(1) / QQbar(L) * projector(L, A, z, v)
            assert A * u == z * u
            terms.append(u)
        assert sum(terms, vector(QQbar, [0] * dimension)) == v
        count += 1
    print("claim_qbar_eigenspaces_span: %d つの L ですべて通過" % count)


check_span()
