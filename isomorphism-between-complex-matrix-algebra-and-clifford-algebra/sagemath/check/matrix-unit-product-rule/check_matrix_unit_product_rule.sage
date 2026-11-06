# 対象ラベル: claim_product_of_matrix_units
# 行列単位の積の規則 E_{x,y}·E_{z,w} = δ_{y,z} ∗ E_{x,w} の証明の各行を、
# X = {0,..,n-1}（n = 1,2,3）のすべての x,y,z,w,p,q,t で整数の厳密計算により確かめる。
# Sage と Python の両方で同じ結果になる書き方にしてある（冪 ^ を使わず、整数だけを扱う）。
# 行列への像での確認ではなく、成分の等式そのものの検算である。証明の代わりにはしない。

def delta(a, b):
    return 1 if a == b else 0

def E(x, y, X):
    return {(u, v): delta(x, u) * delta(y, v) for u in X for v in X}

def mat_mul(A, B, X):
    return {(u, v): sum(A[(u, t)] * B[(t, v)] for t in X) for u in X for v in X}

def smul(lam, A, X):
    return {(u, v): lam * A[(u, v)] for u in X for v in X}

checked = 0
for n in (1, 2, 3):
    X = list(range(n))
    for x in X:
        for y in X:
            for z in X:
                for w in X:
                    Exy, Ezw, Exw = E(x, y, X), E(z, w, X), E(x, w, X)
                    lhs_mat = mat_mul(Exy, Ezw, X)
                    rhs_mat = smul(delta(y, z), Exw, X)
                    assert lhs_mat == rhs_mat, ("主張", n, x, y, z, w)
                    for p in X:
                        for q in X:
                            r = {t: (delta(x, p) * delta(w, q)) * delta(z, t) for t in X}
                            # 準備の等式（各 t）
                            for t in X:
                                line = [
                                    (delta(x, p) * delta(y, t)) * (delta(z, t) * delta(w, q)),
                                    (delta(y, t) * delta(x, p)) * (delta(z, t) * delta(w, q)),
                                    delta(y, t) * (delta(x, p) * (delta(z, t) * delta(w, q))),
                                    delta(y, t) * (delta(x, p) * (delta(w, q) * delta(z, t))),
                                    delta(y, t) * ((delta(x, p) * delta(w, q)) * delta(z, t)),
                                    delta(y, t) * r[t],
                                ]
                                assert len(set(line)) == 1, ("準備", n, x, y, z, w, p, q, t)
                            # (p,q) 成分の鎖
                            chain = [
                                lhs_mat[(p, q)],
                                sum(Exy[(p, t)] * Ezw[(t, q)] for t in X),
                                sum((delta(x, p) * delta(y, t)) * (delta(z, t) * delta(w, q)) for t in X),
                                sum(delta(y, t) * r[t] for t in X),
                                r[y],
                                (delta(x, p) * delta(w, q)) * delta(z, y),
                                delta(z, y) * (delta(x, p) * delta(w, q)),
                                delta(y, z) * (delta(x, p) * delta(w, q)),
                                delta(y, z) * Exw[(p, q)],
                                rhs_mat[(p, q)],
                            ]
                            assert len(set(chain)) == 1, ("鎖", n, x, y, z, w, p, q)
                            checked += 1
print("OK: (n,x,y,z,w,p,q) の組", checked, "件で、主張・準備の等式・成分の鎖のすべての行が一致")
