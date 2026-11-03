# 対象ラベル: anticommutator_of_check_psi
# 行列の鎖を一行ずつ確かめる: 準備 1（[Y̌_μ, Ž_ν]_+ = O の 4 等号）、準備 2（係数 u, u', h を残した展開の 13 等号）、
# 準備 3（δ = 0 の場合の 4 等号と 2 等号）、主張の三つの式の左辺からの鎖（定義・準備 2・場合分けの行）。
# 厳密: 行列は L = QQ(ζ_{4M}) の成分で本文の成分の式（積・和・スカラー倍・有限和・反交換子）から組む。
#   準備 2 は u, u', h を L 上の多項式環の不定元 U, V, H に置き、全ての複素数 u, u', h について一度に確かめる。
#   主張の鎖は、対の添字（ν = M+1-μ）では r = |a_μ| を L(R)（R^2 = a_μ conj(a_μ)）に持ち、
#   対でない添字では r_μ, r_ν を L 上の多項式環の不定元に置く（δ = 0 なので r の値に依らず O になることを見る）。
# 対照: 準備 2 の第 4 行で anticommutator_of_check_Z_Y の右辺を整数運動量のデルタ δ^{(M)}_{(μ,ν)} にすると一致しない。
#   主張で ψ̌^† の係数の符号を ψ̌ と同じ +r にすると、対の添字で第 2 式の右辺が I にならない（0 になる）。
# 範囲: 準備 1 と準備 2 は M = 2..4 の全ての μ, ν ∈ M̌、主張の鎖は結合定数 4 組 × M = 2..4 の全ての μ, ν、
#   主張そのもの（Sage の行列演算で組んだ独立な経路）は結合定数 4 組 × M = 2..5 の全ての μ, ν。
load("_prelude.sage")

rep = Report("anticommutator_of_check_psi: 行列の鎖")


def eq_chain(rows, label):
    ok = all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
    if not ok:
        for i in range(len(rows) - 1):
            if rows[i] != rows[i + 1]:
                print("  differ at row", i, "->", i + 1)
    rep.check(ok, label, quiet=True)
    return ok


def r_root(S, n):
    """R^2 = n の R を、L に無ければ二次拡大に持つ。（F, R）を返す。"""
    L = S.L
    if n.is_square():
        rs = [w for w in n.sqrt(all=True) if S.emb(w) > 0]
        assert len(rs) == 1
        return L, rs[0]
    x = polygen(L)
    F = L.extension(x**2 - n, 'R')
    return F, F.gen()


for M in range(2, 6):
    S = Setting(M)
    L = S.L
    Mh = list(range(1, M + 1))
    n = S.n
    O = matrix(L, n, n, 0)
    IL = body_identity(L, n)
    Zc, Yc = S.checkZ, S.checkY
    omega = {(mv, nv): L(2) * L(M) * L(kron_delta(M, nv, M + 1 - mv)) for mv in Mh for nv in Mh}
    small = M <= 4

    if small:
        # ---- 準備 1 ----
        for mv in Mh:
            for nv in Mh:
                rows = [acomm_body(Yc[mv], Zc[nv]),
                        body_sum(body_product(Yc[mv], Zc[nv]), body_product(Zc[nv], Yc[mv])),
                        body_sum(body_product(Zc[nv], Yc[mv]), body_product(Yc[mv], Zc[nv])),
                        acomm_body(Zc[nv], Yc[mv]),
                        O]
                eq_chain(rows, f"準備 1 M={M} μ={mv} ν={nv}")
                rep.check(acomm_sage(Yc[mv], Zc[nv]) == O, f"準備 1（Sage の演算） M={M} μ={mv} ν={nv}", quiet=True)

        # ---- 準備 2（u, u', h は不定元）----
        P = PolynomialRing(L, ['U', 'V', 'H'])
        U, V, H = P.gens()
        toP = lambda A: A.change_ring(P)
        IP = body_identity(P, n)
        OP = matrix(P, n, n, 0)
        for mv in Mh:
            for nv in Mh:
                Zm, Ym, Zn, Yn = toP(Zc[mv]), toP(Yc[mv]), toP(Zc[nv]), toP(Yc[nv])
                w = P(omega[(mv, nv)])
                Xs, xs = [Zm, Ym], [U, H]
                Ws, ys = [Zn, Yn], [V, H]
                left = body_sum(body_scalar(U, Zm), body_scalar(H, Ym))
                right = body_sum(body_scalar(V, Zn), body_scalar(H, Yn))
                AZZ, AZY, AYZ, AYY = acomm_body(Zm, Zn), acomm_body(Zm, Yn), acomm_body(Ym, Zn), acomm_body(Ym, Yn)
                rows = [
                    acomm_body(left, right),
                    acomm_body(body_finite_sum([body_scalar(xs[j], Xs[j]) for j in range(2)]),
                               body_finite_sum([body_scalar(ys[k], Ws[k]) for k in range(2)])),
                    body_finite_sum([body_finite_sum([body_scalar(xs[j] * ys[k], acomm_body(Xs[j], Ws[k])) for k in range(2)])
                                     for j in range(2)]),
                    body_sum(body_sum(body_scalar(U * V, AZZ), body_scalar(U * H, AZY)),
                             body_sum(body_scalar(H * V, AYZ), body_scalar(H * H, AYY))),
                    body_sum(body_sum(body_scalar(U * V, body_scalar(w, IP)), body_scalar(U * H, OP)),
                             body_sum(body_scalar(H * V, AYZ), body_scalar(H * H, body_scalar(w, IP)))),
                    body_sum(body_sum(body_scalar(U * V, body_scalar(w, IP)), body_scalar(U * H, OP)),
                             body_sum(body_scalar(H * V, OP), body_scalar(H * H, body_scalar(w, IP)))),
                    body_sum(body_sum(body_scalar(U * V, body_scalar(w, IP)), OP),
                             body_sum(OP, body_scalar(H * H, body_scalar(w, IP)))),
                    body_sum(body_scalar(U * V, body_scalar(w, IP)),
                             body_sum(OP, body_scalar(H * H, body_scalar(w, IP)))),
                    body_sum(body_scalar(U * V, body_scalar(w, IP)), body_scalar(H * H, body_scalar(w, IP))),
                    body_sum(body_scalar((U * V) * w, IP), body_scalar((H * H) * w, IP)),
                    body_finite_sum([body_scalar(c, IP) for c in [(U * V) * w, (H * H) * w]]),
                    body_scalar(sum([(U * V) * w, (H * H) * w], P(0)), IP),
                    body_scalar((U * V) * w + (H * H) * w, IP),
                    body_scalar((U * V + H * H) * w, IP),
                ]
                eq_chain(rows, f"準備 2 M={M} μ={mv} ν={nv}")
                # 第 4 行の中身（anticommutator_of_check_Z_Y）: 右辺を ω I・O と読めること
                rep.check(AZZ == body_scalar(w, IP) and AYY == body_scalar(w, IP) and AZY == OP,
                          f"準備 2 第 4 行の根拠 M={M} μ={mv} ν={nv}", quiet=True)
                # 対照: 整数運動量のデルタ（μ+ν ≡ 0 mod M）では一致しない組がある
                wbad = P(2 * M * (1 if (mv + nv) % M == 0 else 0))
                if wbad != w:
                    rep.check(AZZ != body_scalar(wbad, IP), f"対照 準備 2 M={M} μ={mv} ν={nv}", quiet=True)
                # Sage の演算（独立な経路）との比較
                rep.check(acomm_sage(U * Zm + H * Ym, V * Zn + H * Yn) == ((U * V + H * H) * w) * IP,
                          f"準備 2（Sage の演算） M={M} μ={mv} ν={nv}", quiet=True)

        # ---- 準備 3 ----
        Q = PolynomialRing(L, 'Wv'); Wv = Q.gen()
        IQ = body_identity(Q, n); OQ = matrix(Q, n, n, 0)
        for mv in Mh:
            for nv in Mh:
                if nv == M + 1 - mv:
                    continue
                d = Q(kron_delta(M, nv, M + 1 - mv))
                rows = [body_scalar(Wv * Q(omega[(mv, nv)]), IQ),
                        body_scalar(Wv * ((Q(2) * Q(M)) * Q(0)), IQ),
                        body_scalar(Wv * Q(0), IQ),
                        body_scalar(Q(0), IQ),
                        OQ]
                eq_chain(rows, f"準備 3 M={M} μ={mv} ν={nv}")
                eq_chain([body_scalar(d, IQ), body_scalar(Q(0), IQ), OQ], f"準備 3 δI M={M} μ={mv} ν={nv}")

    # ---- 主張の鎖と主張そのもの ----
    for kk in COUPLINGS:
        k = couplings(*kk)
        a = {lam: S.gamma2(+1, lam, k) for lam in Mh}
        b = {lam: S.gamma2(-1, lam, k) for lam in Mh}
        nrm = {lam: a[lam] * a[lam].conjugate() for lam in Mh}
        t = L(2) * S.s
        assert t != 0 and all(b[lam] != 0 and nrm[lam] != 0 for lam in Mh)
        for mv in Mh:
            for nv in Mh:
                paired = (nv == M + 1 - mv)
                if paired:
                    assert nrm[nv] == nrm[mv]          # r_ν = r_μ（準備 5 の鎖。check_coefficients.sage で各行）
                    F, R = r_root(S, nrm[mv])
                    rmu, rnu = F(R), F(R)
                else:
                    F = PolynomialRing(L, ['Rm', 'Rn'])
                    rmu = F.gen(0)
                    rnu = F.gen(0) if nv == mv else F.gen(1)
                IF = body_identity(F, n); OF = matrix(F, n, n, 0)
                toF = lambda A: A.change_ring(F)
                Zm, Ym, Zn, Yn = toF(Zc[mv]), toF(Yc[mv]), toF(Zc[nv]), toF(Yc[nv])
                rr = {mv: rmu, nv: rnu}
                # def_check_fermi の係数（本文の式 ∓r/(2√M b)・1/(2√M) をそのまま）
                fermi = lambda lam, sg, Zl, Yl: body_sum(body_scalar(F(sg) * rr[lam] / F(2 * S.s * b[lam]), Zl),
                                                       body_scalar(F(1) / F(2 * S.s), Yl))
                # 準備の読み: u^∓_λ := (∓ρ_λ) d_λ^{-1}、d_λ := t b_λ、h := 1_C t^{-1}
                u = lambda lam, sg: (F(sg) * rr[lam]) * F(1 / (t * b[lam]))
                h = F(1 / t)
                delta = kron_delta(M, nv, M + 1 - mv)
                w = F(omega[(mv, nv)])
                for name, sg1, sg2, rhs in [("第 1 式", -1, -1, OF), ("第 3 式", +1, +1, OF),
                                            ("第 2 式", -1, +1, body_scalar(F(delta), IF))]:
                    psi1, psi2 = fermi(mv, sg1, Zm, Ym), fermi(nv, sg2, Zn, Yn)
                    u1, u2 = u(mv, sg1), u(nv, sg2)
                    rep.check(acomm_sage(psi1, psi2) == rhs, f"主張（Sage の演算） {name} M={M} {kk} μ={mv} ν={nv}", quiet=True)
                    if not small:
                        continue
                    coef = (u1 * u2 + h * h) * w
                    rows = [acomm_body(psi1, psi2),
                            acomm_body(body_sum(body_scalar(u1, Zm), body_scalar(h, Ym)),
                                       body_sum(body_scalar(u2, Zn), body_scalar(h, Yn))),
                            body_scalar(coef, IF)]
                    if not paired:
                        rows += [OF]                                   # 準備 3
                        if name == "第 2 式":
                            rows += [body_scalar(F(delta), IF)]
                    elif name != "第 2 式":
                        rows += [body_scalar(F(0) * w, IF), body_scalar(F(0), IF), OF]
                    else:
                        rows += [body_scalar(F(1), IF), body_scalar(F(delta), IF)]
                    eq_chain(rows, f"主張の鎖 {name} M={M} {kk} μ={mv} ν={nv}")
                    rep.check(rows[-1] == rhs, f"主張の鎖の終わり {name} M={M} {kk} μ={mv} ν={nv}", quiet=True)
                # 対照: ψ̌^† の係数の符号を +r にすると、対の添字で第 2 式が I にならない
                if paired:
                    bad = acomm_sage(fermi(mv, +1, Zm, Ym), fermi(nv, +1, Zn, Yn))
                    rep.check(bad != IF, f"対照 第 2 式の符号 M={M} {kk} μ={mv}", quiet=True)
    print(f"M={M} 済み")

rep.finish()
