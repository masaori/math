# =========================================================================
# check_01: def_check_index_set (1)〜(5)
#
#  (1) μ ≠ ν ∈ 𝓜̌ なら θ~_μ ≠ θ~_ν、かつ 0 < θ~_μ < 2π
#      （θ~_1 = π/M、θ~_M = 2π - π/M、θ~_{μ+1} - θ~_μ = 2π/M）
#  (2) μ ∈ 𝓜̌ ⟹ M+1-μ ∈ 𝓜̌
#  (3) (M+1-μ) - (1-μ) = M、すなわち 1-μ ≡ M+1-μ (mod M)
#  (4) M+1-μ = μ ⟺ M が奇数かつ μ = (M+1)/2。そのとき θ~_μ = π
#  (5) μ, ν ∈ 𝓜̌ について μ+ν ≡ 1 (mod M) ⟺ ν = M+1-μ
#      （したがって δ^M_{(μ+ν,1)} = δ_{ν,M+1-μ}）
#  さらに 𝓜̌ の最小性: 𝓜̌ から 1 つでも除くと θ~ の像が M 個に足りなくなる
#
# 対象: structured-latex def_check_index_set
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_01: 𝓜̌ = {1,...,M} の性質 (1)-(5) ===")

ok_all = True
w_distinct = 0.0     # 相異なること（最小差 - 2π/M の残差）
w_range = 0          # 0 < θ~_μ < 2π の違反件数
w_ends = 0.0         # θ~_1 = π/M, θ~_M = 2π - π/M の残差
w_step = 0.0         # θ~_{μ+1} - θ~_μ = 2π/M の残差
v_closed = 0         # (2) の違反件数
v_congr = 0          # (3) の違反件数
v_self = 0           # (4) の違反件数
w_selfpi = 0.0       # 自己共役点で θ~_μ = π の残差
v_pair = 0           # (5) の違反件数
v_minimal = 0        # 最小性の違反件数
n_self = 0           # 自己共役点の個数の合計

for M in INDEX_M:
    Mc = check_M(M)
    ths = [th_tilde(M, mu) for mu in Mc]
    # (1)
    for i in range(len(Mc)):
        t = ths[i]
        if not (0 < float(t) < float(2 * pi)):
            v_range = 1
            w_range += 1
        for j in range(i + 1, len(Mc)):
            # 相異なることは |θ~_μ - θ~_ν| >= 2π/M で保証される
            if abs(float(ths[i] - ths[j])) < float(2 * pi) / M - 1e-12:
                w_distinct = max(w_distinct, 1.0)
    w_ends = max(w_ends, abs(float(ths[0] - RDF(pi) / M)),
                 abs(float(ths[-1] - (RDF(2 * pi) - RDF(pi) / M))))
    for i in range(len(Mc) - 1):
        w_step = max(w_step, abs(float(ths[i + 1] - ths[i] - RDF(2 * pi) / M)))
    for mu in Mc:
        # (2)
        if (M + 1 - mu) not in Mc:
            v_closed += 1
        # (3)
        if (M + 1 - mu) - (1 - mu) != M:
            v_congr += 1
        if ((1 - mu) - (M + 1 - mu)) % M != 0:
            v_congr += 1
        # (4)
        lhs = (M + 1 - mu == mu)
        rhs = (M % 2 == 1 and 2 * mu == M + 1)
        if lhs != rhs:
            v_self += 1
        if lhs:
            n_self += 1
            w_selfpi = max(w_selfpi, abs(float(th_tilde(M, mu) - RDF(pi))))
        # (5)
        for nu in Mc:
            if ((mu + nu - 1) % M == 0) != (nu == M + 1 - mu):
                v_pair += 1
    # 最小性: 𝓜̌ から 1 点除くと [0,2π) 内の相異なる M 個を尽くせない
    for drop in Mc:
        rest = [th_tilde(M, mu) for mu in Mc if mu != drop]
        if len(set(round(float(x), 10) for x in rest)) >= M:
            v_minimal += 1
    # 共役について閉じることの最小性: {M+1-μ : μ ∈ 𝓜̌} = 𝓜̌
    if sorted(M + 1 - mu for mu in Mc) != Mc:
        v_closed += 1

ok_all &= report("(1) θ~_μ (μ ∈ 𝓜̌) は相異なる", w_distinct, TOL)
ok_all &= report("(1) 0 < θ~_μ < 2π の違反件数", RDF(w_range), TOL)
ok_all &= report("(1) θ~_1 = π/M, θ~_M = 2π - π/M", w_ends, TOL)
ok_all &= report("(1) θ~_{μ+1} - θ~_μ = 2π/M", w_step, TOL)
ok_all &= report("(2) M+1-μ ∈ 𝓜̌ の違反件数", RDF(v_closed), TOL)
ok_all &= report("(3) 1-μ ≡ M+1-μ (mod M) の違反件数", RDF(v_congr), TOL)
ok_all &= report("(4) 自己共役点の特徴づけの違反件数", RDF(v_self), TOL)
ok_all &= report("(4) 自己共役点で θ~_μ = π", w_selfpi, TOL)
ok_all &= report("(5) μ+ν≡1 (mod M) ⟺ ν = M+1-μ の違反件数", RDF(v_pair), TOL)
ok_all &= report("最小性: 1 点除くと M 個を尽くせない（違反件数）", RDF(v_minimal), TOL)
print(f"  （M = {INDEX_M[0]}..{INDEX_M[-1]} を全探索。自己共役点は合計 {n_self} 個"
      f" = M が奇数の場合の数 {sum(1 for M in INDEX_M if M % 2 == 1)}）")
ok_all &= (n_self == sum(1 for M in INDEX_M if M % 2 == 1))

print("check_01:", "PASS" if ok_all else "FAIL")
