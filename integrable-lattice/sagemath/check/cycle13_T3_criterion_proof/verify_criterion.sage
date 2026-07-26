# cycle 13 / T3 Pure: 主定理（μ の content 判定式 (☆) と λ の判定式）の機械検証。
#
# 証明本体: outputs/reports/cycle13_T3_mu_content_criterion_proof.md 定理 6.1。
#   ℓ ∤ d（＝全ての X_{ℓ^n} が連結）のとき、f(T) = det L(1+T) ∈ ℤ_ℓ[[T]] の
#   Weierstrass 不変量 (μ(f), λ(f)) に対し、n ≫ 0 で
#       ord_ℓ(κ_n) = μ(f)·ℓ^n + (λ(f) − 1)·n + ν,      μ(f) = v_ℓ(content_z det L(z))   …(☆)
#
# ここでは κ_n を導来グラフの Kirchhoff 行列式から**直接**計算し、(☆) と λ 予測を照合する。
# 照合は「証明の確認」であって証明の代用ではない（有限個の n しか計算できない）。

import os, sys
_HERE = os.path.dirname(os.path.abspath(sys.argv[0])) if (sys.argv and sys.argv[0]) else os.getcwd()
_LIB = os.path.join(_HERE, "lib_voltage.sage")
load(_LIB if os.path.exists(_LIB) else "lib_voltage.sage")

NFAIL = 0

def check(cond, msg):
    global NFAIL
    if not cond:
        NFAIL += 1
        print("    *** FAIL: " + msg)


def tower_report(name, m, edges, ell, nmax):
    """ℓ-塔 X_1 ⊂ X_ℓ ⊂ … ⊂ X_{ℓ^nmax} で予測と実測を照合する。"""
    D = detL(m, edges)
    print(f"\n[{name}]  ℓ = {ell}")
    if D == 0:
        print("    det L ≡ 0（d = 0）→ 全ての n ≥ 1 で X_{ℓ^n} は非連結。定理の仮定外。")
        for n in range(1, min(nmax, 3) + 1):
            check(kappa_derived(m, edges, ell**n) == 0, "d=0 なのに κ_n ≠ 0")
        print("    確認: κ_n = 0 (n=1..): True")
        return
    d = voltage_index(m, edges)
    cont = content_z(D)
    mu_c = ZZ(cont).valuation(ell)
    mu_w, lam_w = weierstrass_mu_lambda(D, ell)
    print(f"    det L(z) = {D}")
    print(f"    d = {d},  content_z = {factor(cont) if cont != 1 else 1}")
    print(f"    (☆) v_ℓ(content) = {mu_c} ,  Weierstrass μ(f) = {mu_w} ,  一致 = {mu_c == mu_w}")
    check(mu_c == mu_w, f"(☆) content = Weierstrass μ が {name} (ℓ={ell}) で破れた")
    print(f"    Weierstrass λ(f) = {lam_w}  →  塔の λ 予測 = λ(f) − 1 = {lam_w - 1}")

    if d % ell == 0:
        print(f"    ℓ | d → 全ての n ≥ 1 で X_{{ℓ^n}} は非連結（定理の仮定外）。")
        for n in range(1, min(nmax, 3) + 1):
            check(kappa_derived(m, edges, ell**n) == 0, "ℓ|d なのに κ_n ≠ 0")
        print("    確認: κ_n = 0 (n=1..): True")
        return

    rows = []
    for n in range(nmax + 1):
        N = ell**n
        k = kappa_derived(m, edges, N)
        check(k > 0, f"ℓ∤d なのに X_{{{N}}} が非連結")
        rows.append((n, N, ZZ(k).valuation(ell)))
    # ν は最大の n から決める（定理は n ≫ 0 での成立しか主張しない）
    n_last, N_last, v_last = rows[-1]
    nu = v_last - mu_w * N_last - (lam_w - 1) * n_last
    print(f"    予測式: v_ℓ(κ_n) = {mu_w}·ℓ^n + {lam_w - 1}·n + {nu}   (ν は n={n_last} から決定)")
    print(f"    {'n':>2} {'実測 v_ℓ(κ_n)':>14} {'予測':>10}  一致")
    ok_from = None
    all_ok = True
    for (n, N, v) in rows:
        p = mu_w * N + (lam_w - 1) * n + nu
        agree = (p == v)
        if not agree:
            all_ok = False
            ok_from = None
        elif ok_from is None:
            ok_from = n
        print(f"    {n:>2} {v:>14} {p:>10}  {agree}")
    if all_ok:
        print(f"    → n = 0..{nmax} の全てで一致（n_0 = 0 が取れている）")
    else:
        print(f"    → n = {ok_from}..{nmax} で一致（定理が主張するのは n ≫ 0 のみ。n_0 > 0 の実例）")
    check(ok_from is not None, f"末尾でも予測が合わない: {name} ℓ={ell}")


print("=" * 78)
print("E. 主定理の照合: cycle 12 の全例 ＋ 追加例で v_ℓ(κ_n) = μ·ℓ^n + (λ(f)−1)·n + ν")
print("=" * 78)

E1 = [(0,1,0),(0,1,1),(0,1,2),(0,0,1),(1,1,1)]
E2 = [(0,1,0),(0,1,1),(0,1,1),(0,1,2),(0,0,1),(1,1,1)]
E3 = [(0,1,0),(0,1,0),(0,1,1),(0,1,2),(0,0,1),(1,1,1),(1,1,1)]
E4 = [(0,1,1),(0,1,1),(0,2,0),(0,2,1),(1,2,1),(1,2,1),(0,0,1),(2,2,1)]
E5 = [(0,1,0),(0,1,0),(0,1,0),(0,1,1)] + [(0,0,1)]*3 + [(1,1,1)]*3
E6 = [(0,1,0),(0,1,1),(1,1,1),(1,1,1)]

tower_report("cycle12 例1 (content 12)", 2, E1, 2, 6)
tower_report("cycle12 例1 (content 12)", 2, E1, 3, 4)
tower_report("cycle12 例1 (content 12)", 2, E1, 5, 2)
tower_report("cycle12 例2 (content 16)", 2, E2, 2, 6)
tower_report("cycle12 例3 (content 23)", 2, E3, 2, 4)
tower_report("cycle12 例3 (content 23)", 2, E3, 23, 1)
tower_report("cycle12 例4 (3頂点, content 48)", 3, E4, 2, 5)
tower_report("cycle12 例4 (3頂点, content 48)", 3, E4, 3, 3)
tower_report("cycle12 例5 (content 9, λ≠1)", 2, E5, 3, 3)
tower_report("cycle12 例5 (content 9, λ≠1)", 2, E5, 2, 4)
tower_report("cycle12 例6 (content 5)", 2, E6, 5, 2)
tower_report("cycle12 例6 (content 5)", 2, E6, 2, 4)

print("\n" + "-" * 78)
print("追加例（μ = 0 側・退化側・λ が大きい側）")
print("-" * 78)
tower_report("bouquet ループ voltage 1（最小）", 1, [(0,0,1)], 2, 6)
tower_report("bouquet ループ voltage 1,2", 1, [(0,0,1),(0,0,2)], 2, 5)
tower_report("bouquet ループ voltage 1,2", 1, [(0,0,1),(0,0,2)], 3, 3)
tower_report("bouquet ループ voltage 1,1,1（ℓ=3 で自明 μ=1）", 1, [(0,0,1)]*3, 3, 3)
tower_report("3 頂点サイクル voltage 0,0,1", 3, [(0,1,0),(1,2,0),(2,0,1)], 2, 5)
tower_report("4 頂点（λ が大きい例）", 4, [(0,1,0),(1,2,0),(2,3,0),(3,0,1),(0,2,1),(1,3,2)], 2, 4)
tower_report("d = 2（ℓ=2 は仮定外, ℓ=3 は成立）", 2, [(0,1,0),(0,1,2),(0,0,4)], 2, 3)
tower_report("d = 2（ℓ=3 は成立）", 2, [(0,1,0),(0,1,2),(0,0,4)], 3, 3)
tower_report("d = 0（potential voltage）", 3, [(0,1,1),(1,2,2),(0,2,3)], 2, 3)

print("\n" + "=" * 78)
print("F. μ_ℓ > 0 ⟺ det(L(z) mod ℓ) = 0（𝔽_ℓ(z) 上で L̄ が特異）")
print("=" * 78)
CASES_F = [
    ("例1", 2, E1), ("例2", 2, E2), ("例3", 2, E3), ("例4", 3, E4),
    ("例5", 2, E5), ("例6", 2, E6),
    ("bouquet {1,2}", 1, [(0,0,1),(0,0,2)]),
    ("bouquet {1,1}", 1, [(0,0,1),(0,0,1)]),
]
for (name, m, edges) in CASES_F:
    D = detL(m, edges)
    cont = content_z(D)
    for ell in [2, 3, 5, 23]:
        Fq = GF(ell)
        RF = LaurentPolynomialRing(Fq, 'w')
        w = RF.gen()
        Lbar = matrix(RF, m, m)
        for (u, v, a) in edges:
            if u == v:
                Lbar[u, u] += 2 - w**a - w**(-a)
            else:
                Lbar[u, u] += 1
                Lbar[v, v] += 1
                Lbar[u, v] -= w**a
                Lbar[v, u] -= w**(-a)
        sing = (det(Lbar) == 0)
        mu = ZZ(cont).valuation(ell)
        check(sing == (mu > 0), f"F が {name} ℓ={ell} で破れた")
        print(f"  {name:>14} ℓ={ell:>2}: μ_ℓ = {mu}, det(L mod ℓ) = 0 ? {sing}, 同値 = {sing == (mu > 0)}")

print("\n" + "=" * 78)
print("G. p ≠ ℓ の場合: v_p(κ_n) ≥ μ_p·ℓ^n + (v_p(κ_0) − μ_p)  （証明した下界）")
print("=" * 78)
print("   等号が成り立つとは限らない＝『残差が有界か』は本セッションで証明していない。")
for (name, m, edges, ell, nmax, plist) in [
    ("例1", 2, E1, 2, 5, [3, 5, 7]),
    ("例1", 2, E1, 3, 3, [2, 5]),
    ("例4", 3, E4, 2, 4, [3, 5]),
    ("例5", 2, E5, 2, 4, [3, 5]),
    ("bouquet {1,2}", 1, [(0,0,1),(0,0,2)], 2, 5, [3, 5, 11]),
]:
    D = detL(m, edges)
    cont = content_z(D)
    k0 = kappa_derived(m, edges, 1)
    for p in plist:
        mu_p = ZZ(cont).valuation(p)
        line = []
        ok = True
        for n in range(nmax + 1):
            N = ell**n
            v = ZZ(kappa_derived(m, edges, N)).valuation(p)
            lb = mu_p * N + (ZZ(k0).valuation(p) - mu_p)
            if v < lb:
                ok = False
            line.append(f"n={n}: v={v} (下界 {lb})")
        check(ok, f"G の下界が {name} ℓ={ell} p={p} で破れた")
        print(f"  {name:>14} ℓ={ell} p={p:>2} (μ_p={mu_p}): " + ", ".join(line) + f"  下界成立={ok}")

print("\n" + "=" * 78)
print(f"FAIL 数: {NFAIL}")
print("=" * 78)
