# cycle 13 / T1 step 3: cycle 12 T3 の判定式 (☆) がトーラス族に適用できるかの検討
#
# cycle 12 T3（sagemath/check/cycle12_T3_nonzero_mu_p/README.md）で得た枠組み:
#   - 底グラフ X（有限連結多重グラフ）＋ 1 変数 voltage alpha: E(X) -> ZZ
#   - 導来グラフ X_N（頂点 V x ZZ/N）、塔 N = ell^n が abelian ell-tower
#   - (★) kappa(X_N) = (kappa(X)/N) prod_{zeta^N=1, zeta != 1} det L(zeta)
#   - (☆) mu_ell = v_ell( content_z det L(z) )     [ord_ell(kappa_n) = mu ell^n + lambda n + nu の mu]
#
# 観察 T の対象は L x L トーラスで、L は奇数を動く。この設定へ (☆) が
# そのまま使えるかを、使う前に確認する。
#
# 実行: sage content_criterion_torus.sage

print("=" * 78)
print("1. L x L トーラス族そのもの: voltage は 2 変数（ZZ^2）になる")
print("=" * 78)
S2.<z, w> = LaurentPolynomialRing(ZZ)
detL2 = 4 - z - z ** -1 - w - w ** -1
c2 = gcd([ZZ(c) for c in detL2.coefficients()])
print("  底グラフ X = 1 頂点 + 2 本のループ、voltage (1,0) と (0,1) in ZZ^2。")
print("  導来グラフ X_{(L,L)} = L x L トーラス。voltage ラプラシアンは 1x1 行列:")
print("    det L(z,w) = %s" % detL2)
print("    content = %s" % c2)
print()
print("  ⇒ (☆) は 1 変数 voltage（ZZ-被覆・岩澤代数 ZZ_ell[[T]]）に対して")
print("     Weierstrass 準備定理から導いたものであり、ここは ZZ^2-被覆（2 変数）。")
print("     さらに致命的なのは塔の向きで、観察 T は L を「奇数」で動かす。")
print("     ell=2 に対して N=L は ell と互いに素であり、これは ell-tower ではない")
print("     （Washington–Sinnott 型の p != ell の状況, arXiv:2201.05186 系）。")
print("  ⇒ 結論: (☆) は観察 T にそのままは適用できない。")

print()
print("=" * 78)
print("2. では (☆) が本当に使える部分族はどこか: 幅 W を固定した W x 2^n の塔")
print("=" * 78)
print("  底グラフ X_W := 長さ W のサイクル C_W の各頂点に voltage 1 のループを 1 本。")
print("  導来グラフ (X_W)_N = W x N トーラス。N = 2^n が abelian 2-tower。")
print("  これは 1 変数 voltage なので (☆) の設定にそのまま乗る。")
print()
S.<z> = LaurentPolynomialRing(ZZ)

def voltage_laplacian_cycle(W):
    """C_W の各頂点に voltage 1 のループ 1 本を付けた底グラフの voltage ラプラシアン。"""
    M = matrix(S, W, W)
    for i in range(W):
        M[i, i] = 4 - z - z ** -1          # ループ(2 - z - z^-1) + C_W の次数 2
        if W == 2:
            M[i, (i + 1) % W] = -2         # C_2 は二重辺
        else:
            M[i, (i + 1) % W] = -1
            M[i, (i - 1) % W] = -1
    return M

R.<x> = ZZ[]

def p_seq(n):
    a, b = R(2), x
    if n == 0:
        return a
    for _ in range(n - 1):
        a, b = b, x * b - a
    return b

def f_poly(L):
    return p_seq(L) - 2

def tau_WL(W, L):
    """W x L トーラスの全域木数（積公式の終結式形）。"""
    qW = f_poly(W) // (x - 2)
    return ZZ(L) / ZZ(W) * qW.resultant(R(f_poly(L)(4 - x)))

# 実グラフとの照合（この tau_WL が本当に全域木数か）
print("  まず tau_WL を Kirchhoff の matrix-tree 定理と照合:")
for (W, L) in [(3, 4), (3, 5), (4, 6), (5, 7), (3, 8), (6, 5)]:
    G = graphs.CycleGraph(W).cartesian_product(graphs.CycleGraph(L))
    print("    W=%d L=%d : 一致=%s" % (W, L, tau_WL(W, L) == G.spanning_trees_count()))
print()
print("  W   content_z det L_W(z)   (☆)の予測 mu_2   実測 v_2(kappa_n), n=1..7        差分")
for W in range(2, 10):
    M = voltage_laplacian_cycle(W)
    d = M.det()
    co = gcd([ZZ(c) for c in d.coefficients()])
    mu_pred = ZZ(co).valuation(2)
    vs = [ZZ(tau_WL(W, 2 ** n)).valuation(2) for n in range(1, 8)]
    diffs = [vs[i + 1] - vs[i] for i in range(len(vs) - 1)]
    print("  %d        %-6s              %d           %-28s  %s"
          % (W, co, mu_pred, vs, diffs))
print()
print("  ⇒ どの W でも content = 1、すなわち (☆) の予測は mu_2 = 0。")
print("     実測でも v_2(kappa_n) は n について（十分大きい n で）線形＝2^n の項が無い。")
print("     ＝ (☆) はこの 1 変数部分族では正しく機能する。")
print("     しかしこれは L = 2^n（偶数方向）の話であって、観察 T（L 奇数）とは別方向である。")

print()
print("=" * 78)
print("3. 整合性の注記（証明ではない）")
print("=" * 78)
print("  2 変数 det L(z,w) = 4 - z - 1/z - w - 1/w の content は 1（上記 1.）。")
print("  もし 2 変数岩澤理論の類推で「mu = 0」を読むなら、v_2(tau(L)) は")
print("  頂点数 L^2 に比例して伸びてはいけない。実際 v_2(tau(L)) = 2(L-1) は L の 1 次で、")
print("  L^2 に対して劣線形である。この整合は励みになるが、2(L-1) という")
print("  具体的な値を導くものではない。観察 T の決着には別の議論が必要であり、")
print("  それが README §2 の初等的な証明である。")
