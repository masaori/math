# 対象ラベル: anticommutator_of_check_psi
# 準備 4（ℂ の符号と逆元の規則）と準備 5（ν = M+1-μ の場合の係数）の鎖を一行ずつ確かめる。準備 5 は:
#   a_ν・b_ν の各 3 等号、r_ν の 11 等号、b_μ b_ν の 8 等号、t t の 7 等号、d_μ d_ν の 4 等号、d_μ^{-1} d_ν^{-1} の 4 等号、
#   u^-u^- の 8 等号、u^+u^+ の 7 等号、u^-u^+ の 6 等号、h h の 3 等号、二つの和の各 2 等号、(u^-u^+ + hh)ω の 11 等号。
# 一般の点: 各行を QQ 上の有理関数（a_μ, b_μ, a_ν, b_ν, ρ, σ, M を不定元）として本文の式どおりに別々に組み、
#   隣り合う行の差の分子が、その行の根拠の関係（periodicity_of_check_fermi (3) の a_ν = b_μ・b_ν = a_μ、
#   relation_of_gamma_2_theta_tilde (2) の a_μ b_μ = -ρρ、平方根の σσ = M）だけで生成したイデアルに入ることを見る。
#   関係を引く行は、関係なしでは一致しない（差が 0 でない）ことも対照として確かめる。
# 具体値: 結合定数 4 組（臨界点 2 組を含む）× M_col = 2..6 の全 μ ∈ M̌ で、γ_2 を円分体 L = QQ(ζ_{4M}) に、
#   r = |a_μ| を L(R)（R^2 = a_μ conj(a_μ)）に持ち、全行を厳密に確かめる。絶対値の行は値の 2 乗（L の実の元）で比べる
#   （両辺とも ℝ_{≥0} の元なので、2 乗の一致と同値）。
load("_prelude.sage")

rep = Report("anticommutator_of_check_psi: 準備 4・準備 5 の係数の鎖")

# ---------------- 一般の点 ----------------
Pg = PolynomialRing(QQ, ['am', 'bm', 'an', 'bn', 'rho', 'sig', 'Mc', 'x', 'y'])
am, bm, an, bn, rho, sig, Mc, x, y = Pg.gens()
Kg = Pg.fraction_field()


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p

REL = dict(per=[an - bm, bn - am], rel2=[am * bm + rho**2], sq=[sig**2 - Mc])


def in_ideal(f, rels):
    f = Kg(f)
    num = f.numerator()
    if not rels:
        return num == 0
    return num in Pg.ideal(rels)


def generic_chain(rows, uses, label):
    """uses[i]: 行 i → 行 i+1 が引く関係の名前の一覧（空なら関係なしで一致）。"""
    assert len(uses) == len(rows) - 1, label
    for i in range(len(rows) - 1):
        rels = sum((REL[u] for u in uses[i]), [])
        diff = Kg(rows[i]) - Kg(rows[i + 1])
        rep.check(in_ideal(diff, rels), f"{label} 第 {i+1}→{i+2} 行（関係 {uses[i]}）")
        if uses[i]:
            rep.check(not in_ideal(diff, []), f"対照 {label} 第 {i+1}→{i+2} 行は関係なしでは一致しない")


t = 2 * sig
dm, dn = t * bm, t * bn
tt = t * t
rr = rho * rho

# 二乗は def_power_of_real_number の冪（m = 2）として rpow で組み、積の形とは square_of_real_number_is_product の行で行き来する。
generic_chain([bm * bn, bm * am, am * bm, -(rpow(rho, 2)), -(rpow(rho, 2)), -(rho * rho), (-1) * (rho * rho), -(rho * rho), -(rho * rho)],
              [['per'], [], ['rel2'], [], [], [], [], []], "b_μ b_ν")
generic_chain([(2 * sig) * (2 * sig), (2 * 2) * (sig * sig), (2 * 2) * (sig * sig), 4 * (sig * sig), 4 * rpow(sig, 2), 4 * Mc, 4 * Mc],
              [[], [], [], [], ['sq'], []], "t t")
generic_chain([(t * bm) * (t * bn), (t * t) * (bm * bn), tt * (-rr), -(tt * rr)],
              [[], ['per', 'rel2'], []], "d_μ d_ν")
generic_chain([(1 / dm) * (1 / dn), 1 / (dm * dn), 1 / (-(tt * rr)), -(1 / (tt * rr)), -((1 / tt) * (1 / rr))],
              [[], ['per', 'rel2'], [], []], "d_μ^{-1} d_ν^{-1}")
DD = -((1 / tt) * (1 / rr))   # 上の鎖の右端
generic_chain([((-rho) / dm) * ((-rho) / dn), ((-rho) * (-rho)) * ((1 / dm) * (1 / dn)), rr * ((1 / dm) * (1 / dn)),
               rr * DD, -(rr * ((1 / tt) * (1 / rr))), -((1 / tt) * (rr * (1 / rr))), -((1 / tt) * 1), -(1 / tt)],
              [[], [], ['per', 'rel2'], [], [], [], []], "u^- u^-")
generic_chain([(rho / dm) * (rho / dn), rr * ((1 / dm) * (1 / dn)), rr * DD, -(rr * ((1 / tt) * (1 / rr))),
               -((1 / tt) * (rr * (1 / rr))), -((1 / tt) * 1), -(1 / tt)],
              [[], ['per', 'rel2'], [], [], [], []], "u^+ u^+")
generic_chain([((-rho) / dm) * (rho / dn), ((-rho) * rho) * ((1 / dm) * (1 / dn)), (-rr) * ((1 / dm) * (1 / dn)),
               -(rr * ((1 / dm) * (1 / dn))), -(-(1 / tt)), 1 / tt],
              [[], [], [], ['per', 'rel2'], []], "u^- u^+")
generic_chain([(1 * (1 / t)) * (1 * (1 / t)), (1 / t) * (1 / t), 1 / tt], [[], []], "h h")
generic_chain([-(1 / tt) + 1 / tt, 0], [[]], "u^-u^- + hh")
om = 2 * Mc   # δ = 1
generic_chain([(1 / tt + 1 / tt) * om, (1 * (1 / tt) + 1 * (1 / tt)) * om, ((1 + 1) * (1 / tt)) * om, (2 * (1 / tt)) * om,
               (2 * (1 / tt)) * ((2 * Mc) * 1), (2 * (1 / tt)) * (2 * Mc), ((2 * 2) * Mc) * (1 / tt), ((2 * 2) * Mc) * (1 / tt),
               (4 * Mc) * (1 / tt), tt * (1 / tt), 1],
              [[], [], [], [], [], [], [], [], ['sq'], []], "(u^-u^+ + hh)ω")
# r_ν の鎖の成分の行: (-1, 0)(x, -y) = ((-1)x - 0(-y), (-1)(-y) + 0x) = (-x, y)、(-x)^2 + y^2 = x^2 + y^2
rep.check(((-1) * x - 0 * (-y), (-1) * (-y) + 0 * x) == (-x, y), "r_ν の鎖 definition_of_cc の積の行（一般の点）")
rep.check((-x)**2 + y**2 == x**2 + y**2, "r_ν の鎖 (-x)^2 = x^2 の行（一般の点）")


# ---------------- 準備 4（ℂ の符号と逆元の規則）----------------
# 一般の点では各行が有理関数として同じ元になる（体の公理だけの変形）。具体値で、ℂ を本文どおり実数の対で持って
# (i) の成分の行を、L の元 z, w の組で (ii)〜(ix) の各行を確かめる。
m1 = (QQ(-1), QQ(0))
cc_mul = lambda p, q: (p[0] * q[0] - p[1] * q[1], p[0] * q[1] + p[1] * q[0])   # definition_of_cc の積
rep.check(cc_mul(m1, m1) == ((-1) * (-1) - 0 * 0, (-1) * 0 + 0 * (-1)) == (QQ(1), QQ(0)), "準備 4 (i) の成分の行")
L8 = CyclotomicField(8, 'z'); z8 = L8.gen()
samples = [L8(3), L8(-2) + z8, z8**3 - 5 * z8, L8(1) / 7 + z8**2]
mo = L8(-1)
for zz in samples:
    for ww in samples:
        ok = (zz * (mo * ww) == mo * (zz * ww)                                         # (ii)
              and (mo * zz) * ww == mo * (zz * ww)                                     # (iii)
              and mo * (mo * zz) == (mo * mo) * zz == zz                               # (iv)
              and (mo * zz) * (mo * ww) == mo * (zz * (mo * ww)) == mo * (mo * (zz * ww)) == zz * ww   # (v)
              and (zz * ww) * (zz**-1 * ww**-1) == (zz * zz**-1) * (ww * ww**-1) == 1   # (vi)
              and (mo * zz) * (mo * zz**-1) == zz * zz**-1 == 1                        # (vii)
              and zz * ww != 0 and (zz * ww)**-1 == zz**-1 * ww**-1                    # (viii)
              and mo * zz != 0 and (mo * zz)**-1 == mo * zz**-1)                       # (ix)
        rep.check(ok, f"準備 4 (ii)〜(ix) z={zz} w={ww}", quiet=True)

# ---------------- 具体値 ----------------
for M in range(2, 7):
    S = Setting(M, with_ops=False)
    L = S.L
    Iu = S.I
    for kk in COUPLINGS:
        k = couplings(*kk)
        for mu in range(1, M + 1):
            nv = M + 1 - mu
            a_m, b_m = S.gamma2(+1, mu, k), S.gamma2(-1, mu, k)
            a_n, b_n = S.gamma2(+1, nv, k), S.gamma2(-1, nv, k)
            tag = f"M={M} {kk} μ={mu}"
            # a_ν・b_ν の鎖（第 1 行は θ~_ν の式から、第 2 行は -θ~_μ・θ~_μ の式から別々に作る）
            rep.check(a_n == S.gamma2(-1, mu, k) == b_m, f"a_ν の鎖 {tag}", quiet=True)
            rep.check(b_n == S.gamma2(+1, mu, k) == a_m, f"b_ν の鎖 {tag}", quiet=True)
            # r_ν の鎖（各行の値の 2 乗）
            ab2 = lambda z: z * z.conjugate()
            xm = (a_m + a_m.conjugate()) / 2
            ym = (a_m - a_m.conjugate()) / (2 * Iu)
            assert xm == xm.conjugate() and ym == ym.conjugate() and a_m == xm + Iu * ym
            cb = -a_m.conjugate()
            assert b_m == cb                                     # relation_of_gamma_2_theta_tilde (1)
            prod_pair = ((-1) * xm - 0 * (-ym), (-1) * (-ym) + 0 * xm)
            rows = [ab2(a_n), ab2(b_m), ab2(-a_m.conjugate()), ab2(L(-1) * a_m.conjugate()),
                    ab2(L(-1) * (xm - Iu * ym)), ab2(L(-1) * (xm - Iu * ym)),
                    ab2(prod_pair[0] + Iu * prod_pair[1]), (-xm)**2 + ym**2, xm**2 + ym**2, ab2(a_m)]
            rep.check(all(rows[i] == rows[i + 1] for i in range(len(rows) - 1)), f"r_ν の鎖 {tag}", quiet=True)
            rep.check(prod_pair == (-xm, ym) and (L(-1) * a_m.conjugate()) == prod_pair[0] + Iu * prod_pair[1],
                      f"r_ν の鎖 成分の行 {tag}", quiet=True)
            n2 = ab2(a_m)
            rep.check(S.emb(n2) > 0, f"r > 0 {tag}", quiet=True)
            # r = √n2 を L(R) に持つ
            if n2.is_square():
                F = L; R = [w for w in n2.sqrt(all=True) if S.emb(w) > 0][0]
            else:
                F = L.extension(polygen(L)**2 - n2, 'R'); R = F.gen()
            rho_ = F(R); sg = F(S.s); t_ = F(2) * sg; Mf = F(M)
            bm_, bn_, am_ = F(b_m), F(b_n), F(a_m)
            chk = lambda rows, lab: rep.check(all(rows[i] == rows[i + 1] for i in range(len(rows) - 1)), f"{lab} {tag}", quiet=True)
            rr_ = rho_ * rho_
            chk([bm_ * bn_, bm_ * am_, am_ * bm_, F(-n2), -rpow(rho_, 2), -rr_, F(-1) * rr_, -rr_, -rr_], "b_μ b_ν")
            chk([(F(2) * sg) * (F(2) * sg), (F(2) * F(2)) * (sg * sg), F(2 * 2) * (sg * sg), F(4) * (sg * sg), F(4) * rpow(sg, 2), F(4) * Mf, F(4) * Mf], "t t")
            tt_ = t_ * t_
            dm_, dn_ = t_ * bm_, t_ * bn_
            rep.check(t_ != 0 and rr_ != 0 and dm_ != 0 and dn_ != 0, f"t, ρρ, d ≠ 0 {tag}", quiet=True)
            chk([dm_ * dn_, tt_ * (bm_ * bn_), tt_ * (-rr_), -(tt_ * rr_)], "d_μ d_ν")
            DDv = -(tt_**-1 * rr_**-1)
            chk([dm_**-1 * dn_**-1, (dm_ * dn_)**-1, (-(tt_ * rr_))**-1, -((tt_ * rr_)**-1), DDv], "d_μ^{-1} d_ν^{-1}")
            chk([((-rho_) * dm_**-1) * ((-rho_) * dn_**-1), ((-rho_) * (-rho_)) * (dm_**-1 * dn_**-1), rr_ * (dm_**-1 * dn_**-1),
                 rr_ * DDv, -(rr_ * (tt_**-1 * rr_**-1)), -(tt_**-1 * (rr_ * rr_**-1)), -(tt_**-1 * 1), -(tt_**-1)], "u^- u^-")
            chk([(rho_ * dm_**-1) * (rho_ * dn_**-1), rr_ * (dm_**-1 * dn_**-1), rr_ * DDv, -(rr_ * (tt_**-1 * rr_**-1)),
                 -(tt_**-1 * (rr_ * rr_**-1)), -(tt_**-1 * 1), -(tt_**-1)], "u^+ u^+")
            chk([((-rho_) * dm_**-1) * (rho_ * dn_**-1), ((-rho_) * rho_) * (dm_**-1 * dn_**-1), (-rr_) * (dm_**-1 * dn_**-1),
                 -(rr_ * (dm_**-1 * dn_**-1)), -(-(tt_**-1)), tt_**-1], "u^- u^+")
            chk([(1 * t_**-1) * (1 * t_**-1), t_**-1 * t_**-1, tt_**-1], "h h")
            om_ = (F(2) * Mf) * F(1)
            # 二つの和と (u^-u^+ + hh)ω の第 1 行: 係数を準備の定義から作った値と、鎖で求めた値の代入
            um = lambda: (-rho_) * dm_**-1
            umn = lambda: (-rho_) * dn_**-1
            up = lambda: rho_ * dn_**-1
            hv = 1 * t_**-1
            rep.check(um() * umn() + hv * hv == -(tt_**-1) + tt_**-1, f"u^-u^- + hh 第 1 行 {tag}", quiet=True)
            rep.check((rho_ * dm_**-1) * up() + hv * hv == -(tt_**-1) + tt_**-1, f"u^+u^+ + hh 第 1 行 {tag}", quiet=True)
            rep.check((um() * up() + hv * hv) * om_ == (tt_**-1 + tt_**-1) * om_, f"(u^-u^+ + hh)ω 第 1 行 {tag}", quiet=True)
            chk([-(tt_**-1) + tt_**-1, F(0)], "u^-u^- + hh")
            chk([(tt_**-1 + tt_**-1) * om_, (F(1) * tt_**-1 + F(1) * tt_**-1) * om_, ((F(1) + F(1)) * tt_**-1) * om_,
                 (F(2) * tt_**-1) * om_, (F(2) * tt_**-1) * ((F(2) * Mf) * F(1)), (F(2) * tt_**-1) * (F(2) * Mf),
                 ((F(2) * F(2)) * Mf) * tt_**-1, (F(2 * 2) * Mf) * tt_**-1, (F(4) * Mf) * tt_**-1, tt_ * tt_**-1, F(1)], "(u^-u^+ + hh)ω")
            # 対照: 対でない添字 ν' = μ（μ ≠ M+1-μ のとき）では a_{ν'} ≠ b_μ
            if mu != nv:
                rep.check(S.gamma2(+1, mu, k) != b_m, f"対照 a_μ ≠ b_μ {tag}", quiet=True)
    print(f"M={M} 済み")

rep.finish()
