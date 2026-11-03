# 対象ラベル: def_gamma1_gamma2_of_theta
# 各行の等号を不定元の多項式環 QQ(i)[...] で確かめる。(∵) が環の演算だけの行は多項式として等しいこと、
# 関係式を引く行は「引いた関係式だけが生成するイデアル」で等しく、かつ多項式としては等しくないことを確かめる。
load("_prelude.sage")

rep = Report("def_gamma1_gamma2_of_theta: 鎖の各行と主張（一般の不定元）")

def in_ideal(f, names):
    if not names:
        return f == 0
    return R.ideal([RELATIONS[n] for n in names]).reduce(f) == 0

for name, lines in CHAINS.items():
    for k in range(1, len(lines)):
        prev = lines[k - 1][0]
        expr, rels = lines[k]
        diff = prev - expr
        ok = in_ideal(diff, rels)
        if rels:
            rep.check(ok and diff != 0, f"{name} 第 {k} 行 → 第 {k+1} 行（引く関係式 {rels} のイデアルで等しく、多項式としては異なる）")
        else:
            rep.check(ok, f"{name} 第 {k} 行 → 第 {k+1} 行（環の演算だけで等しい）")

# 証明の第一段落: (1,1)・(2,2)・(1,2) 成分は定義式そのもの
rep.check(A[0, 0] == gamma1_def(co), "(1,1) 成分 = γ_1(θ)（多項式として同一）")
rep.check(A[1, 1] == gamma1_def(co), "(2,2) 成分 = γ_1(θ)（多項式として同一）")
rep.check(A[0, 1] == gamma2_def(ep, co, si), "(1,2) 成分 = γ_2(θ)（多項式として同一）")

# 二つの鎖のつなぎ: A(θ)_{2,1} の鎖の終点は γ_2(-θ) の鎖の終点の符号反転
rep.check(CHAINS['A(θ)_{2,1}'][-1][0] == -CHAINS['γ_2(-θ)'][-1][0], "A(θ)_{2,1} の鎖の終点 = −（γ_2(-θ) の鎖の終点）")

# 主張: 三つの関係式で A(θ) = [[γ_1(θ), γ_2(θ)], [−γ_2(−θ), γ_1(θ)]]。どれか一つを抜くと従わない
G = matrix(R, 2, 2, [gamma1_def(co), gamma2_def(ep, co, si), -gamma2_def(epm, com, sim), gamma1_def(co)])
D = A - G
base = list(RELATIONS)
I_all = R.ideal([RELATIONS[n] for n in base])
rep.check(all(I_all.reduce(D[r, c]) == 0 for r in range(2) for c in range(2)), "主張: 三つの関係式で A(θ) が γ_1・γ_2 の行列に等しい")
for drop in base:
    I_d = R.ideal([RELATIONS[n] for n in base if n != drop])
    rep.check(any(I_d.reduce(D[r, c]) != 0 for r in range(2) for c in range(2)), f"対照: 関係式 {drop} を抜くと主張が従わない")
# 対照: (2,1) 成分を +γ_2(−θ) にした行列とは一致しない
G2 = matrix(R, 2, 2, [gamma1_def(co), gamma2_def(ep, co, si), gamma2_def(epm, com, sim), gamma1_def(co)])
rep.check(any(I_all.reduce((A - G2)[r, c]) != 0 for r in range(2) for c in range(2)), "対照: (2,1) 成分の符号を逆にした行列とは一致しない")

rep.finish()
