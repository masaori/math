# 対象ラベル: claim_decomposition_of_identity_matrix_into_matrix_units
# 単位行列の分解 Σ_{x∈X} 1 ∗ E_{x,x} = 1_{Mat_X} の証明の各行を、
# X = {0,..,n-1}（n = 1,2,3,4）のすべての p,q,x で整数の厳密計算により確かめる。
# Sage と Python の両方で同じ結果になる書き方にしてある（冪 ^ を使わず、整数だけを扱う）。
# 成分の等式そのものの検算であり、証明の代わりにはしない。

def delta(a, b):
    return 1 if a == b else 0

def E(x, y, X):
    return {(u, v): delta(x, u) * delta(y, v) for u in X for v in X}

def mat_add(A, B, X):
    return {(u, v): A[(u, v)] + B[(u, v)] for u in X for v in X}

def smul(lam, A, X):
    return {(u, v): lam * A[(u, v)] for u in X for v in X}

def ident(X):
    return {(u, v): delta(u, v) for u in X for v in X}

checked = 0
for n in (1, 2, 3, 4):
    X = list(range(n))
    # 左辺: 行列の線型空間の中の和（番号付け k ↦ X[k] で番号順に足す）
    S = {(u, v): 0 for u in X for v in X}
    for x in X:
        S = mat_add(S, smul(1, E(x, x, X), X), X)
    assert S == ident(X), ("主張", n)
    for p in X:
        for q in X:
            # 準備の等式（各 x）
            for x in X:
                line = [
                    1 * E(x, x, X)[(p, q)],
                    1 * (delta(x, p) * delta(x, q)),
                    delta(x, p) * delta(x, q),
                    delta(p, x) * delta(q, x),
                ]
                assert len(set(line)) == 1, ("準備", n, p, q, x)
            # (p,q) 成分の鎖
            chain = [
                S[(p, q)],
                sum(1 * E(x, x, X)[(p, q)] for x in X),
                sum(delta(p, x) * delta(q, x) for x in X),
                delta(q, p),
                delta(p, q),
                ident(X)[(p, q)],
            ]
            assert len(set(chain)) == 1, ("鎖", n, p, q)
            checked += 1
print("OK: (n,p,q) の組", checked, "件で、主張・準備の等式・成分の鎖のすべての行が一致")
