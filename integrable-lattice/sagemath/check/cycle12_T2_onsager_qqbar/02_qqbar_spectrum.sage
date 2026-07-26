# cycle 12 / T2→T1: 2D Ising Step 3 の帰属検証（有理点 x=q での対角化は ℚ̄ で閉じる）。
#   有理点 q ∈ ℚ_{>0} で T(q) ∈ M_{2^L}(ℚ) の固有値が
#     (a) すべて実代数的数（AA）で正、
#     (b) 最小多項式の次数がすべて 2 冪（自由フェルミオン＝多重2次拡大の痕跡）、
#     (c) minpoly を witness として提示できる
#   ことを厳密（QQ / QQbar / AA）に確認する。
# 参照: 09 Step 3、themes.md 探索方向 C（ℝ脱出隔離 / 自由フェルミオン構造）
# 既知結果（Onsager–Kaufman）の可算・厳密な書き換えであり、新しい厳密解ではない。

def states(L):
    return [tuple(1 - 2*((i >> j) & 1) for j in range(L)) for i in range(2^L)]

def h(s):
    L = len(s)
    return sum(1 for j in range(L) if s[j] != s[(j+1) % L])

def v(s, t):
    return sum(1 for j in range(len(s)) if s[j] != t[j])

def transfer_at(L, q):
    S = states(L)
    n = len(S)
    return matrix(QQ, n, n, lambda i, j: q^(h(S[j]) + v(S[i], S[j])))

def is_two_power(n):
    return n == 2^(n.bit_length() - 1)

xc = AA(2).sqrt() - 1   # 臨界点 x_c = √2 − 1 ≈ 0.41421（03/04 で代数的に導出）

print("=== Step 3: 有理点 x=q での T(q) スペクトルの ℚ̄ 帰属 ===")
print(f"（臨界点 x_c = √2 − 1 = {RR(xc)}。q > x_c は高温側、q < x_c は低温側）")
for q in [QQ(1)/2, QQ(1)/3, QQ(2)/5]:
    side = "高温側" if q > xc else "低温側"
    print()
    print(f"--- q = {q} ({side}) ---")
    for L in [2, 3, 4]:
        T = transfer_at(L, q)
        cp = T.charpoly()
        evs = T.eigenvalues(extend=True)
        all_alg = all(e in QQbar for e in evs)
        all_real = all(QQbar(e).imag() == 0 for e in evs)
        all_pos = all(AA(QQbar(e).real()) > 0 for e in evs)
        degs = sorted(set(QQbar(e).minpoly().degree() for e in evs))
        twopow = all(is_two_power(ZZ(d)) for d in degs)
        print(f"  L={L}: dim={T.nrows()}, 全固有値∈QQbar={all_alg}, 全実={all_real}, 全正={all_pos}")
        print(f"        最小多項式の次数集合={degs}, すべて2冪={twopow}")
        print(f"        charpoly の ℚ[λ] 因数分解 = {cp.factor()}")
        # witness: 最大固有値の最小多項式
        lmax = max(AA(QQbar(e).real()) for e in evs)
        mp = QQbar(lmax).minpoly()
        print(f"        λ_max = {RR(lmax)} , minpoly(λ_max) = {mp} (deg {mp.degree()}, 既約={mp.is_irreducible()})")
