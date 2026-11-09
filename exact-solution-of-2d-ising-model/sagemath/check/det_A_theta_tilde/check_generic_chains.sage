# 対象ラベル: det_A_theta_tilde
# 証明の鎖を一般の点（不定元）で一行ずつ確かめる。隣り合う行の差の分子が、その行の (∵) が引く関係だけで
# 生成したイデアルに入ることを見る。関係を引く行では、関係なしでは一致しないこと（関係が要ること）も見る。
# 実数の対で持つ ℂ（_shared/complex_as_real_pairs.sage）で −(−z) = z・ii = −1_C・対の第 1 成分の比較を確かめる。浮動小数点なし。
load("_prelude.sage")
load("_chains.sage")

rep = Report("det_A_theta_tilde: 一般の点での鎖")

def num_in(d, gens):
    n = Fg(d).numerator()
    if not gens:
        return n == 0
    return n in Rg.ideal(gens)

for (name, ch) in CHAINS:
    for k in range(1, len(ch)):
        e_prev, _ = ch[k - 1]
        e, rels = ch[k]
        gens = sum((REL[r] for r in rels), [])
        rep.check(num_in(e - e_prev, gens), f"{name} 第 {k} 行 = 第 {k+1} 行（関係: {', '.join(rels) or 'なし'}）")
        if rels:
            rep.check(not num_in(e - e_prev, []), f"{name} 第 {k+1} 行は関係 {', '.join(rels)} なしでは前の行に一致しない（対照）")

# γ_2(±θ) の表示（g2form）は上の二本の鎖から従う: g2def・A21gamma・A21def・a0 だけで g2form が出る
J = Rg.ideal(REL['g2def'] + REL['A21gamma'] + REL['A21def'] + REL['a0'])
rep.check(all(g in J for g in REL['g2form']), "γ_2(±θ) の表示は def_gamma1_gamma2_of_theta・def_A_theta・a_0 の定義から従う")
# γ_2(θ)γ_2(-θ) の鎖の結論（g2prod）は g2form・ii・ee から従う
J = Rg.ideal(REL['g2form'] + REL['ii'] + REL['ee'])
rep.check(REL['g2prod'][0] in J, "γ_2(θ)γ_2(-θ) = -(s_2^*)^2(a_0^2 + v^2) は γ_2(±θ) の表示・ii = -1・e_+e_- = 1 から従う")
# 第 2 の等式の結論は、引いた関係だけから従い、どの一つを抜いても従わない
used = ['g1def', 'g2prod', 'uv', 'a0', 'hyp_iii', 'hyp_i', 'hyp_ii']
target = REL['second'][0]
rep.check(target in Rg.ideal(sum((REL[r] for r in used), [])), "第 2 の等式は g1def・g2prod・uv・a0・hyp_iii・hyp_i・hyp_ii から従う")
for r in used:
    rest = sum((REL[q] for q in used if q != r), [])
    rep.check(target not in Rg.ideal(rest), f"第 2 の等式は関係 {r} を抜くと従わない")

# u + iv = e_+ と exp_of_negative_i_real_as_cos_minus_i_sin の e_- = u - iv は、Euler の式（euler_formula_cos_sin）の二本と両立する
Je = Rg.ideal(REL['euler'] + [I**2 + 1])
rep.check(REL['upiv'][0] in Je and REL['eminus'][0] in Je, "u + iv = e_+、e_- = u - iv は Euler の式の二本（と ii = -1）から従う")
# 第 1 行の def_det_two_by_two は Sage の det と一致
rep.check(det_by_definition(Agam) == Agam.det(), "def_det_two_by_two の det = Sage の det（A(θ) の γ の形で）")

# e_+e_- の鎖の第 4 行（ほぼ自明な行。記録のために残す）: iθ + (-iθ) = 0 を QQ(i)[θ] で
K0.<i0> = QuadraticField(-1)
Rt.<t> = PolynomialRing(K0)
rep.check(i0 * t + (-(i0 * t)) == 0, "e_+e_- の鎖 第 4 行: iθ + (-iθ) = 0_C")

# −(−z) = z の鎖 5 行（実数の対で）
Rxy.<x, y> = PolynomialRing(QQ)
z = (x, y)
mm = [
    cc_neg(cc_neg(z, Rxy), Rxy),
    cc_mul(iota(-1, Rxy), cc_mul(iota(-1, Rxy), z)),
    cc_mul(cc_mul(iota(-1, Rxy), iota(-1, Rxy)), z),
    cc_mul(iota((-1) * (-1), Rxy), z),
    cc_mul(iota(1, Rxy), z),
    z,
]
for k in range(1, len(mm)):
    rep.check(mm[k - 1] == mm[k], f"−(−z) = z の鎖 第 {k} 行 = 第 {k+1} 行")
rep.check(cc_mul(iota(-1, Rxy), iota(-1, Rxy)) == iota((-1) * (-1), Rxy), "real_inclusion_preserves_product: (-1)_C(-1)_C = ((-1)(-1))_C")

# ii = -1_C の鎖 4 行（実数の対で）
ip = (QQ(0), QQ(1))
ii_chain = [cc_mul(ip, ip), (QQ(0) * 0 - 1 * 1, QQ(0) * 1 + 1 * 0), (QQ(-1), QQ(0)), iota(-1, QQ)]
for k in range(1, len(ii_chain)):
    rep.check(ii_chain[k - 1] == ii_chain[k], f"ii = -1_C の鎖 第 {k} 行 = 第 {k+1} 行")

# 第 3・最後の等式の対の比較: (a, 0) = a_C、1_C = (1, 0)、(1 + r^2)_C = 1_C + (r^2)_C
Rab.<a, rr> = PolynomialRing(QQ)
rep.check(iota(a, Rab) == (a, Rab(0)) and iota(1, Rab) == (Rab(1), Rab(0)), "inclusion_rr_to_cc: a_C = (a, 0)、1_C = (1, 0)")
rep.check(cc_add(iota(1, Rab), cc_mul(iota(rr, Rab), iota(rr, Rab))) == iota(1 + rr**2, Rab), "準備の像の読み方: 1_C + r_C r_C = (1 + r^2)_C")
rep.check(cc_add(iota(rr, Rab), iota(a, Rab)) == iota(rr + a, Rab) and cc_mul(iota(rr, Rab), iota(a, Rab)) == iota(rr * a, Rab),
          "準備の像の読み方: 実数の和・積の像は像の和・積")
rep.check(cc_sub(iota(rr, Rab), iota(a, Rab), Rab) == iota(rr - a, Rab), "準備の像の読み方: 実数の差の像は像の差（def_complex_difference）")

rep.finish()
