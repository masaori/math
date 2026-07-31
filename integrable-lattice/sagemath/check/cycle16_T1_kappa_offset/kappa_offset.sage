# cycle 16 / T1: 全域木数 kappa と Monsky の和 S_n の間のオフセットを厳密に確認する。
#
# 検証する 2 つの候補式（unramified な Z_p^d 塔、d=1）:
#   (K)  ord_p(kappa_{X_n}) = S_n - d*n + ord_p(kappa_X)                     … Kataoka Prop 4.4
#   (P)  ord_p(kappa_{X_n}) = S_n - d*n + ord_p(kappa_X) - ord_p(#V_X)       … 論文 001 現行の「規約の注意」
# ここで S_n = sum_{chi in Gamma_n^ \ {1}} ord_p(chi(det L_alpha)).
#
# #V_X が p で割れる基底グラフを入れてあるので、(K) と (P) は区別できる。
# 整数・円分体の厳密計算のみ。浮動小数点も Q_p も使わない。

import itertools

R = LaurentPolynomialRing(ZZ, 'z')
z = R.gen()


def voltage_laplacian(nv, edges):
    """L_alpha(z): 電圧付きグラフのラプラシアン（nv x nv, Z[z^{+-1}] 係数）。
    edges = [(u, v, a)] は u -> v の辺で電圧 a。u == v はループ。"""
    M = matrix(R, nv, nv)
    for (u, v, a) in edges:
        if u == v:
            M[u, u] += 2 - z**a - z**(-a)
        else:
            M[u, u] += 1
            M[v, v] += 1
            M[u, v] += -z**a
            M[v, u] += -z**(-a)
    return M


def derived_graph_laplacian(nv, edges, N):
    """導来グラフ X_n（Gamma_n = Z/N）の整数ラプラシアン。頂点は (v, g) を v*N+g で番号付け。"""
    n = nv * N
    L = matrix(ZZ, n, n)
    for (u, v, a) in edges:
        for g in range(N):
            i = u * N + g
            j = v * N + ((g + a) % N)
            L[i, i] += 1
            L[j, j] += 1
            L[i, j] -= 1
            L[j, i] -= 1
    return L


def kappa(L):
    """Matrix-Tree: 全域木数（既約ラプラシアンの行列式）。厳密整数。"""
    n = L.nrows()
    if n == 1:
        return ZZ(1)
    return L.delete_rows([0]).delete_columns([0]).determinant()


def S_n_exact(Malpha, N, p):
    """S_n = sum_{zeta^N = 1, zeta != 1} ord_p(det M_alpha(zeta)) を円分体で厳密に計算する。
    det M_alpha(zeta) の p 進付値は、その体ノルムの p 進付値を conjugate 数で割って得られる。
    ここでは全 zeta にわたる積（= 整数）の p 進付値としてまとめて計算する。"""
    detM = Malpha.determinant()
    # Laurent -> 多項式（z の冪は単元なので付値に影響しない）
    num = R(detM).polynomial_construction()[0] if hasattr(R(detM), 'polynomial_construction') else None
    P0 = PolynomialRing(ZZ, 'x')
    x = P0.gen()
    d0 = detM.dict()
    lo = min(d0.keys())
    poly = sum(c * x**(e - lo) for e, c in d0.items())
    poly = P0(poly)
    Phi = P0((x**N - 1) // (x - 1))          # 非自明指標に対応する因子
    res = Phi.resultant(poly)                # = prod_{zeta^N=1, zeta!=1} detM(zeta) （符号を除く）
    assert res != 0
    return ZZ(res).abs().valuation(p)


CASES = [
    # (名前, nv, edges, p, 期待される #V_X)
    ("banana(2頂点2重辺, 電圧0,1), p=2", 2, [(0, 1, 0), (0, 1, 1)], 2),
    ("C_3(3頂点閉路, 電圧0,0,1), p=3", 3, [(0, 1, 0), (1, 2, 0), (2, 0, 1)], 3),
    ("2頂点3重辺(電圧0,1,2), p=3", 2, [(0, 1, 0), (0, 1, 1), (0, 1, 2)], 3),
    ("bouquet(1頂点1ループ, 電圧1)… 対照, p=3", 1, [(0, 0, 1)], 3),
    ("C_2 x 2重辺付き(4頂点), p=2", 4, [(0, 1, 0), (1, 2, 0), (2, 3, 0), (3, 0, 1), (0, 2, 0)], 2),
]

print("=" * 78)
print("cycle 16 / T1: kappa オフセットの厳密確認（d=1, unramified）")
print("=" * 78)

bad_K = 0
bad_P = 0
for (name, nv, edges, p) in CASES:
    Malpha = voltage_laplacian(nv, edges)
    L0 = derived_graph_laplacian(nv, edges, 1)
    kX = kappa(L0)
    if kX == 0:
        print("skip(基底が非連結): %s" % name)
        continue
    print("\n--- %s" % name)
    print("    #V_X = %d, kappa_X = %d, ord_p(kappa_X) = %d, ord_p(#V_X) = %d"
          % (nv, kX, ZZ(kX).valuation(p), ZZ(nv).valuation(p)))
    print("    %3s %10s %8s %10s %10s %6s" % ("n", "kappa_Xn", "ord_p", "S_n", "(K)予測", "(P)予測"))
    for n in range(0, 5):
        N = p**n
        if nv * N > 250:
            break
        Ln = derived_graph_laplacian(nv, edges, N)
        kn = kappa(Ln)
        if kn == 0:
            print("    n=%d: X_n が非連結（kappa=0）。スキップ" % n)
            continue
        ordk = ZZ(kn).valuation(p)
        S = S_n_exact(Malpha, N, p)
        predK = S - 1 * n + ZZ(kX).valuation(p)
        predP = predK - ZZ(nv).valuation(p)
        okK = "OK" if predK == ordk else "NG"
        okP = "OK" if predP == ordk else "NG"
        if predK != ordk:
            bad_K += 1
        if predP != ordk:
            bad_P += 1
        print("    %3d %10d %8d %10d %10d %s %6d %s"
              % (n, kn, ordk, S, predK, okK, predP, okP))

print("\n" + "=" * 78)
print("不一致件数:  (K) Kataoka Prop 4.4 形 = %d 件   (P) 論文 001 現行形 = %d 件" % (bad_K, bad_P))
print("=" * 78)
