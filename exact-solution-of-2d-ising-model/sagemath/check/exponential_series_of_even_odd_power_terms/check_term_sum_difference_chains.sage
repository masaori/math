# 対象ラベル: exponential_series_of_even_odd_power_terms
# 中間目標「各項」（偶数 10 行・奇数 12 行）、「部分和」（成分の 11 行）、「差」（成分の 9 行）の全行を、大きさ d = 1, 2, 3、
# n = 0..N_MAX、N = 0..N_MAX で厳密に確かめる。ℂ は QQ(i)（GAUSSIAN）上の多項式環 P で、A・B の成分と c は P の独立な不定元、
# x と cosh x・sinh x の値 ch・sh は ℝ の不定元（QQ 上の多項式環 Rr の元）で、ℝ の量は Rr で作ってから包含 Rr → P（r ↦ r + 0i）で ℂ へ移す。
# 差の中間目標は cosh・sinh の定義を使わないので、その値を独立な不定元に置く。不定元での等号は、任意の実数 x と
# 任意の複素数 c・A・B の成分を代入しても成り立つ。行列の和・スカラー倍・差・有限和は本文の成分の式（matrix_operations_by_definition.sage）で組む。
load("_prelude.sage")

N_MAX = 10
Rr = PolynomialRing(QQ, ['x', 'ch', 'sh'])
xr, chr_, shr = Rr.gens()


def setting(d):
    names = ['x', 'ch', 'sh', 'c'] + [f"A_{p}_{q}" for p in range(d) for q in range(d)] + [f"B_{p}_{q}" for p in range(d) for q in range(d)]
    P = PolynomialRing(GAUSSIAN, names)
    g = P.gens()
    A = matrix(P, d, d, g[4:4 + d * d])
    B = matrix(P, d, d, g[4 + d * d:])
    return P, g[3], A, B


def a_r(n):
    return (rpow(xr, n) + rpow(-xr, n)) / (2 * factorial(n))


def b_r(n):
    return (rpow(xr, n) - rpow(-xr, n)) / (2 * factorial(n))


def E_r(y, N):
    return sum(rpow(y, n) / factorial(n) for n in range(N + 1))


for d in [1, 2, 3]:
    P, c, A, B = setting(d)
    inc = lambda r: P(Rr(r))          # 包含 ℝ → ℂ（r ↦ r + 0i）
    xC = inc(xr)
    O = matrix(P, d, d)
    one = lambda n: inc(QQ(1) / factorial(n))   # (1/n!)_C

    def T(n):
        """仮定の列 T_n。"""
        return body_scalar(rpow(xC, n), A) if n % 2 == 0 else body_scalar(c * rpow(xC, n), B)

    # ---- 各項 ----
    for n in range(N_MAX + 1):
        tag = f"d={d} n={n}"
        an, bn = inc(a_r(n)), inc(b_r(n))
        target = body_sum(body_scalar(an, A), body_scalar(c * bn, B))
        if n % 2 == 0:
            lines = [
                ("(1/n!)_C T_n", body_scalar(one(n), T(n))),
                ("(1/n!)_C((x_C)^n A)", body_scalar(one(n), body_scalar(rpow(xC, n), A))),
                ("((1/n!)_C (x_C)^n) A", body_scalar(one(n) * rpow(xC, n), A)),
                ("((1/n!)_C (x^n)_C) A", body_scalar(one(n) * inc(rpow(xr, n)), A)),
                ("((1/n!) x^n)_C A", body_scalar(inc(rpow(xr, n) / factorial(n)), A)),
                ("(a_n)_C A", body_scalar(an, A)),
                ("(a_n)_C A + O", body_sum(body_scalar(an, A), O)),
                ("(a_n)_C A + 0_C B", body_sum(body_scalar(an, A), body_scalar(P(0), B))),
                ("(a_n)_C A + (c 0_C) B", body_sum(body_scalar(an, A), body_scalar(c * P(0), B))),
                ("(a_n)_C A + (c (0)_C) B", body_sum(body_scalar(an, A), body_scalar(c * inc(0), B))),
                ("(a_n)_C A + (c (b_n)_C) B", target),
            ]
        else:
            lines = [
                ("(1/n!)_C T_n", body_scalar(one(n), T(n))),
                ("(1/n!)_C((c (x_C)^n) B)", body_scalar(one(n), body_scalar(c * rpow(xC, n), B))),
                ("((1/n!)_C (c (x_C)^n)) B", body_scalar(one(n) * (c * rpow(xC, n)), B)),
                ("(((1/n!)_C c) (x_C)^n) B", body_scalar((one(n) * c) * rpow(xC, n), B)),
                ("((c (1/n!)_C) (x_C)^n) B", body_scalar((c * one(n)) * rpow(xC, n), B)),
                ("(c ((1/n!)_C (x_C)^n)) B", body_scalar(c * (one(n) * rpow(xC, n)), B)),
                ("(c ((1/n!)_C (x^n)_C)) B", body_scalar(c * (one(n) * inc(rpow(xr, n))), B)),
                ("(c ((1/n!) x^n)_C) B", body_scalar(c * inc(rpow(xr, n) / factorial(n)), B)),
                ("(c (b_n)_C) B", body_scalar(c * bn, B)),
                ("O + (c (b_n)_C) B", body_sum(O, body_scalar(c * bn, B))),
                ("0_C A + (c (b_n)_C) B", body_sum(body_scalar(P(0), A), body_scalar(c * bn, B))),
                ("(0)_C A + (c (b_n)_C) B", body_sum(body_scalar(inc(0), A), body_scalar(c * bn, B))),
                ("(a_n)_C A + (c (b_n)_C) B", target),
            ]
        run_chain(lines, f"{tag} 各項")
        report(one(n) * T(n) == target, f"{tag}: 各項の両端を Sage の演算で比べても一致")
        if n >= 1:
            report(body_scalar(one(n), T(n)) != body_sum(body_scalar(inc(b_r(n)), A), body_scalar(c * inc(a_r(n)), B)),
                   f"{tag}: 対照 a_n と b_n を入れ替えると一致しない")

    # ---- 部分和 ----
    for N in range(N_MAX + 1):
        tag = f"d={d} N={N}"
        S_N = body_finite_sum([body_scalar(one(n), T(n)) for n in range(N + 1)])
        report(S_N == sum((QQ(1) / factorial(n)) * T(n) for n in range(N + 1)), f"{tag}: S_N（本文の有限和）が Sage の和と一致")
        alpha = (E_r(xr, N) + E_r(-xr, N)) / 2
        beta = (E_r(xr, N) - E_r(-xr, N)) / 2
        for p in range(d):
            for q in range(d):
                terms = [body_scalar(inc(a_r(n)), A) + body_scalar(c * inc(b_r(n)), B) for n in range(N + 1)]
                lines = [
                    ("(S_N)_pq", S_N[p, q]),
                    ("Σ((1/n!)_C T_n)_pq", sum(body_scalar(one(n), T(n))[p, q] for n in range(N + 1))),
                    ("Σ((a_n)_C A + (c(b_n)_C)B)_pq", sum(body_sum(body_scalar(inc(a_r(n)), A), body_scalar(c * inc(b_r(n)), B))[p, q] for n in range(N + 1))),
                    ("Σ(((a_n)_C A)_pq + ((c(b_n)_C)B)_pq)", sum(body_scalar(inc(a_r(n)), A)[p, q] + body_scalar(c * inc(b_r(n)), B)[p, q] for n in range(N + 1))),
                    ("Σ((a_n)_C A_pq + (c(b_n)_C)B_pq)", sum(inc(a_r(n)) * A[p, q] + (c * inc(b_r(n))) * B[p, q] for n in range(N + 1))),
                    ("Σ(a_n)_C A_pq + Σ(c(b_n)_C)B_pq", sum(inc(a_r(n)) * A[p, q] for n in range(N + 1)) + sum((c * inc(b_r(n))) * B[p, q] for n in range(N + 1))),
                    ("(Σ(a_n)_C)A_pq + (cΣ(b_n)_C)B_pq", sum(inc(a_r(n)) for n in range(N + 1)) * A[p, q] + (c * sum(inc(b_r(n)) for n in range(N + 1))) * B[p, q]),
                    ("(Σa_n)_C A_pq + (c(Σb_n)_C)B_pq", inc(sum(a_r(n) for n in range(N + 1))) * A[p, q] + (c * inc(sum(b_r(n) for n in range(N + 1)))) * B[p, q]),
                    ("((1/2)(Σx^n/n! + Σ(-x)^n/n!))_C A_pq + ...", inc((sum(rpow(xr, n) / factorial(n) for n in range(N + 1)) + sum(rpow(-xr, n) / factorial(n) for n in range(N + 1))) / 2) * A[p, q]
                     + (c * inc((sum(rpow(xr, n) / factorial(n) for n in range(N + 1)) - sum(rpow(-xr, n) / factorial(n) for n in range(N + 1))) / 2)) * B[p, q]),
                    ("(α_N)_C A_pq + (c(β_N)_C)B_pq", inc(alpha) * A[p, q] + (c * inc(beta)) * B[p, q]),
                    ("((α_N)_C A)_pq + ((c(β_N)_C)B)_pq", body_scalar(inc(alpha), A)[p, q] + body_scalar(c * inc(beta), B)[p, q]),
                    ("((α_N)_C A + (c(β_N)_C)B)_pq", body_sum(body_scalar(inc(alpha), A), body_scalar(c * inc(beta), B))[p, q]),
                ]
                run_chain(lines, f"{tag} p={p+1} q={q+1} 部分和")
        S_claim = body_sum(body_scalar(inc(alpha), A), body_scalar(c * inc(beta), B))
        report(S_N == S_claim, f"{tag}: 部分和の中間目標 S_N = (α_N)_C A + (c(β_N)_C)B")

        # ---- 差 ----
        L = body_sum(body_scalar(inc(chr_), A), body_scalar(c * inc(shr), B))
        D = body_difference(S_N, L)
        D_claim = body_sum(body_scalar(inc(alpha - chr_), A), body_scalar(c * inc(beta - shr), B))
        for p in range(d):
            for q in range(d):
                Sp = inc(alpha) * A[p, q] + (c * inc(beta)) * B[p, q]
                lines = [
                    ("(S_N - L)_pq", D[p, q]),
                    ("(S_N)_pq - L_pq", S_N[p, q] + body_neg_scalar(L[p, q])),
                    ("(...) - L_pq", Sp + body_neg_scalar(L[p, q])),
                    ("(...) - ((ch)_C A + (c(sh)_C)B)_pq（L の定義）", Sp + body_neg_scalar(body_sum(body_scalar(inc(chr_), A), body_scalar(c * inc(shr), B))[p, q])),
                    ("(...) - (((ch)_C A)_pq + ((c(sh)_C)B)_pq)", Sp + body_neg_scalar(body_scalar(inc(chr_), A)[p, q] + body_scalar(c * inc(shr), B)[p, q])),
                    ("(...) - ((ch)_C A_pq + (c(sh)_C)B_pq)", Sp + body_neg_scalar(inc(chr_) * A[p, q] + (c * inc(shr)) * B[p, q])),
                    ("((α_N)_C - (ch)_C)A_pq + (c((β_N)_C - (sh)_C))B_pq", (inc(alpha) - inc(chr_)) * A[p, q] + (c * (inc(beta) - inc(shr))) * B[p, q]),
                    ("(α_N - ch)_C A_pq + (c(β_N - sh)_C)B_pq", inc(alpha - chr_) * A[p, q] + (c * inc(beta - shr)) * B[p, q]),
                    ("((α_N - ch)_C A)_pq + ((c(β_N - sh)_C)B)_pq", body_scalar(inc(alpha - chr_), A)[p, q] + body_scalar(c * inc(beta - shr), B)[p, q]),
                    ("((α_N - ch)_C A + (c(β_N - sh)_C)B)_pq", D_claim[p, q]),
                ]
                run_chain(lines, f"{tag} p={p+1} q={q+1} 差")
        report(D == S_N - L and D == D_claim, f"{tag}: 差の中間目標（Sage の差とも一致）")
    print(f"d={d}: done")
print("RESULT: PASS")
