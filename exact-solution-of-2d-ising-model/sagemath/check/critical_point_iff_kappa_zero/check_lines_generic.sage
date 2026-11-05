# 対象ラベル: critical_point_iff_kappa_zero
# 証明の準備と同値の鎖のうち、値を独立な不定元に置いても成り立つ行（四則・記号の書き換え）と、
# 引いた関係式だけで成り立つ行を、QQ 上の多項式環で厳密に確かめる。浮動小数点は使わない。
#
# 不定元の対応（証明の記号 → 不定元）:
#   s1, s2, s2s : s_1 = sinh 2K_1, s_2 = sinh 2K_2, s_2^* = sinh 2K_2^*
#   w           : 1/s_2（s_2 ≠ 0 なので s_2 w = 1 を関係式として持つ）
#   k1, k2s     : K_1, K_2^*
#   kap         : κ
# 同値 f = 0 ⟺ g = 0 は、「f が g の倍元」と「g が f の倍元」を、その行が引く関係式の生成するイデアルを法として示して確かめる
# （両向きの倍元がそろえば、関係式の成り立つ点で f と g の零点は一致する）。関係式を抜くと成り立たない行は、それも確かめる。
import sys

R = PolynomialRing(QQ, 's1,s2,s2s,w,k1,k2s,kap', order='degrevlex')
s1, s2, s2s, w, k1, k2s, kap = R.gens()

def in_ideal(d, rels):
    d = R(d)
    if not rels:
        return d == 0
    return d in R.ideal(rels)

def equiv_mod(f, g, hf, hg, rels):
    """f − hf·g と g − hg·f がともに rels のイデアルに入るか（hf, hg は証明の割る・掛けるに当たる倍元）。"""
    return in_ideal(f - hf * g, rels) and in_ideal(g - hg * f, rels)

ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

inv = s2 * w - 1          # s_2 ≠ 0 から 1/s_2 を置く関係式（s_2 > 0 は indexed_hyperbolic_abbreviations_positive）
dual = s2 * s2s - 1       # second_dual_coupling_relation（sinh 2K_2 sinh 2K_2^* = 1）
kdef = kap - (2 * k1 - 2 * k2s)   # def_kappa

# 準備の鎖 s_2^* = s_2 s_2^*/s_2 = sinh(2K_2) sinh(2K_2^*)/s_2 = 1/s_2（/s_2 は w を掛けることで表す）
P = [s2s, s2 * s2s * w, s2 * s2s * w, w]
check("準備 1→2 行目: s_2^* = s_2 s_2^*/s_2 は s_2 w = 1 だけで成り立つ", in_ideal(P[0] - P[1], [inv]))
check("準備 1→2 行目 対照: s_2 w = 1 を抜くと成り立たない", not in_ideal(P[0] - P[1], []))
check("準備 2→3 行目: 略記の展開（両辺は同じ式。書き写しの形の一致のみ）", in_ideal(P[1] - P[2], []))
check("準備 3→4 行目: second_dual_coupling_relation だけで成り立つ", in_ideal(P[2] - P[3], [dual]))
check("準備 3→4 行目 対照: second_dual_coupling_relation を抜くと成り立たない", not in_ideal(P[2] - P[3], [inv]))

# (1) ⟺ (2) の鎖
check("(1)⟺(2) 1 行目: s_1 s_2 − 1 と s_1 − 1/s_2 は s_2 w = 1 のもとで互いの倍元（s_2 で割る・掛ける）",
      equiv_mod(s1 * s2 - 1, s1 - w, s2, w, [inv]))
check("(1)⟺(2) 1 行目 対照: s_2 w = 1 を抜くと s_1 s_2 − 1 は s_2(s_1 − w) と一致しない",
      not in_ideal((s1 * s2 - 1) - s2 * (s1 - w), []))
check("(1)⟺(2) 2 行目: s_1 − 1/s_2 と s_1 − s_2^* は準備の s_2^* = 1/s_2 だけで一致する（準備の二つの関係式から）",
      equiv_mod(s1 - w, s1 - s2s, 1, 1, [inv, dual]))
check("(1)⟺(2) 2 行目 対照: second_dual_coupling_relation を抜くと一致しない",
      not in_ideal((s1 - w) - (s1 - s2s), [inv]))
# 3 行目は略記の展開、4 行目は sinh の単射性で、多項式の等号では表せない（check_lines_with_balls.sage）
check("(1)⟺(2) 5 行目: 2K_1 − 2K_2^* と K_1 − K_2^* は互いの倍元（2 で割る・掛ける）",
      equiv_mod(2 * k1 - 2 * k2s, k1 - k2s, 2, QQ(1) / 2, []))
check("(1)⟺(2) 5 行目 対照: 係数を 1 に誤ると互いの倍元にならない",
      not equiv_mod(2 * k1 - 2 * k2s, k1 - k2s, 1, 1, []))

# (2) ⟺ (3) の鎖
check("(2)⟺(3) 1 行目: κ と 2K_1 − 2K_2^* は def_kappa だけで一致する", equiv_mod(kap, 2 * k1 - 2 * k2s, 1, 1, [kdef]))
check("(2)⟺(3) 1 行目 対照: def_kappa を抜くと一致しない", not in_ideal(kap - (2 * k1 - 2 * k2s), []))
check("(2)⟺(3) 2 行目: 2K_1 − 2K_2^* = 2(K_1 − K_2^*)（多項式の等号）", in_ideal((2 * k1 - 2 * k2s) - 2 * (k1 - k2s), []))
check("(2)⟺(3) 3 行目: 2(K_1 − K_2^*) と K_1 − K_2^* は互いの倍元", equiv_mod(2 * (k1 - k2s), k1 - k2s, 2, QQ(1) / 2, []))
check("(2)⟺(3) 4 行目: K_1 − K_2^* = 0 ⟺ K_1 = K_2^*（移項。左辺の差が同じ多項式）", in_ideal((k1 - k2s) - (k1 - k2s), []))

# 鎖全体: s_1 s_2 − 1 と s_1 − s_2^* は二つの関係式のもとで互いの倍元
check("鎖全体: s_1 s_2 − 1 と s_1 − s_2^* は s_2 w = 1 と second_dual_coupling_relation のもとで互いの倍元",
      equiv_mod(s1 * s2 - 1, s1 - s2s, s2, w, [inv, dual]))

# 主張そのものの厳密な確認（証明の行とは独立）。
# t := exp(−2K_2^*)、u := exp(−2K_1) とおく（K_1, K_2^* > 0 なので 0 < t, u < 1）。
# def_second_dual_coupling_constant の K_2^* = −(1/2) log(tanh K_2) は tanh K_2 = t と同じであり、
# sinh 2x = 2 tanh x/(1 − tanh^2 x)、sinh 2x = (exp(2x) − exp(−2x))/2 から
#   s_2 = 2t/(1 − t^2)、s_2^* = (1/t − t)/2 = (1 − t^2)/(2t)、s_1 = (1 − u^2)/(2u)
# となる（これらの書き換えは本文の証明には無く、検算の側で使う標準の恒等式である）。
F = FractionField(PolynomialRing(QQ, 't,u'))
t, u = F.gens()
S2 = 2 * t / (1 - t^2)
S2s = (1 - t^2) / (2 * t)
S1 = (1 - u^2) / (2 * u)
check("厳密: s_2 s_2^* = 1（second_dual_coupling_relation）が QQ(t) の中で成り立つ", S2 * S2s == 1)
check("厳密: 準備の s_2^* = 1/s_2 が QQ(t) の中で成り立つ", S2s == 1 / S2)
check("厳密: 臨界の点 K_1 = K_2^*（u = t）で s_1 s_2 = 1", (S1 * S2).subs(u=t) == 1)
num = ((S1 * S2 - 1) * u * (1 - t^2)).numerator()
Pt = num.parent()
tt, uu = Pt.gens()
check("厳密: (s_1 s_2 − 1)·u(1 − t^2) = (t − u)(1 + tu)（K_1 = K_2^* ⟺ u = t との同値の核）",
      num == (tt - uu) * (1 + tt * uu) and ((S1 * S2 - 1) * u * (1 - t^2)).denominator() == 1)
# 恒等式から先の「1 + tu > 0 なので s_1 s_2 = 1 ⟺ u = t」と「u = t ⟺ K_1 = K_2^*（exp の単射性）」は論証であって、ここでは検算しない
check("厳密 対照: s_2 を 2t/(1 + t^2)（cosh の逆数の形）に誤ると s_2 s_2^* = 1 が成り立たない", 2 * t / (1 + t^2) * S2s != 1)

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
