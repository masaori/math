# 対象ラベル: factorization_of_A_theta_general
# 各行の等号を、不定元の多項式環 QQ(i)[a,b,C,S,e_+,e_-,cos,sin,c_1,s_1,c_2,c_2^*,s_2^*] で確かめる。
# (∵) が環の演算だけの行は多項式として等しいこと、関係式を引く行は「引いた関係式だけが生成するイデアル」で
# 等しく、かつ多項式としては等しくない（その関係式を実際に使っている）ことを確かめる。
load("_prelude.sage")

rep = Report("factorization_of_A_theta_general: 鎖の各行（一般の不定元）")

def in_ideal(f, names):
    if not names:
        return f == 0
    return R.ideal([RELATIONS[n] for n in names]).reduce(f) == 0

# e_+ の鎖の 3 行目 → 4 行目は e_- を exp(-(i(θ)_C)) へ 2 箇所で書き換えるが、(e_+ + e_-)/2 + (e_+ - e_-)/2 の中で
# e_- の項は打ち消し合うので、どちらの行も多項式としては e_+ である。代わりに、書き換える前の二つの分数のそれぞれが
# 関係式 em=emn を実際に使って書き換わることを確かめる。
def _ep_row_uses_relation():
    I1 = R.ideal([RELATIONS['em=emn']])
    pairs = [((ep + em)/2, (ep + emn)/2), ((ep - em)/(2*i), (ep - emn)/(2*i))]
    return all(I1.reduce(u - w) == 0 and u != w for u, w in pairs)
CANCELLED_IN_NORMAL_FORM = {('e_+', 3): _ep_row_uses_relation}

for name, lines in CHAINS.items():
    for k in range(1, len(lines)):
        prev, cur = lines[k - 1][0], lines[k]
        expr, rels = cur
        diff = prev - expr
        ok = in_ideal(diff, rels)
        if rels and (name, k) in CANCELLED_IN_NORMAL_FORM:
            # 行の書き換えは関係式を使うが、書き換えた項どうしが多項式の正規形で打ち消し合うので差が 0 になる
            rep.check(ok and diff == 0 and CANCELLED_IN_NORMAL_FORM[(name, k)](), f"{name} 第 {k} 行 → 第 {k+1} 行（引く関係式 {rels} で書き換えた項が正規形で打ち消し合う）")
        elif rels:
            used = diff != 0
            rep.check(ok and used, f"{name} 第 {k} 行 → 第 {k+1} 行（引く関係式 {rels} のイデアルで等しく、多項式としては異なる）")
        else:
            rep.check(ok, f"{name} 第 {k} 行 → 第 {k+1} 行（環の演算だけで等しい）")

# 準備の鎖の終点が、Step で引く関係式そのものであること
rep.check(CHAINS['e_+ + e_-'][0][0] - CHAINS['e_+ + e_-'][-1][0] == RELATIONS['ep+em=2co'], "準備の 5 本目の終点 = 関係式 ep+em=2co")
rep.check(CHAINS['e_+'][0][0] - CHAINS['e_+'][-1][0] == RELATIONS['ep=co+i*si'], "準備の 6 本目の終点 = 関係式 ep=co+i*si")
rep.check(CHAINS['e_-'][0][0] - CHAINS['e_-'][-1][0] == RELATIONS['em=co-i*si'], "準備の 7 本目の終点 = 関係式 em=co-i*si")
rep.check(CHAINS['補助的な等式の 1 本目'][0][0] - CHAINS['補助的な等式の 1 本目'][-1][0] == RELATIONS['aux+'], "補助的な等式の 1 本目の終点 = 関係式 aux+")
rep.check(CHAINS['補助的な等式の 2 本目'][0][0] - CHAINS['補助的な等式の 2 本目'][-1][0] == RELATIONS['aux-'], "補助的な等式の 2 本目の終点 = 関係式 aux-")
rep.check(CHAINS['C = S(c_2)_C'][0][0] - CHAINS['C = S(c_2)_C'][-1][0] == RELATIONS['C=S*c2'], "C = S(c_2)_C の鎖の終点 = 関係式 C=S*c2")

# 各成分の鎖の終点が A(θ) の対応する成分そのもの
for key, entry in A_ENTRY_OF.items():
    rep.check(CHAINS[key][-1][0] == entry, f"{key} の鎖の終点 = def_A_theta の対応する成分")

# Step 6: 括弧の付け方によらない（mat_mult_associative）
rep.check((B1 * B2) * B1 == B1 * (B2 * B1), "(B_1 B_2) B_1 = B_1 (B_2 B_1)（多項式行列として）")

# 主張: 証明が引く関係式の全体で B_1 B_2 B_1 - A(θ) の各成分が消え、どれか一つを抜くと消えない
base = ['a2+b2=c1', '2ab=s1', 'a2-b2=1', 'ep*em=1', 'em=emn', 'euler1', 'euler2', 'C=c2s', 'S=s2s', 'dual']
D = B1 * B2 * B1 - A
I_all = R.ideal([RELATIONS[n] for n in base])
rep.check(all(I_all.reduce(D[r, c]) == 0 for r in range(2) for c in range(2)),
          "主張: 基本の関係式（双曲線関数・指数・(-i)z = -(iz)・Euler・C,S の定義・双対関係）で B_1B_2B_1 = A(θ)")
for drop in base:
    I_d = R.ideal([RELATIONS[n] for n in base if n != drop])
    survives = any(I_d.reduce(D[r, c]) != 0 for r in range(2) for c in range(2))
    rep.check(survives, f"対照: 関係式 {drop} を抜くと主張が従わない")

rep.finish()
