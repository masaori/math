# 対象ラベル: isotropic_A_equals_one
# A = 1 の鎖の各行を、有理関数体 QQ(u_1, u_2) で厳密に確かめる。浮動小数点は使わない。
# u_1 := exp(−2K_1)、u_2 := exp(−2K_2) とおく（0 < u_i < 1）。tanh x = (1 − exp(−2x))/(1 + exp(−2x))、
# sinh 2x = (exp(2x) − exp(−2x))/2 から sinh 2K_i = (1 − u_i^2)/(2u_i)。def_second_dual_coupling_constant の
# K_2^* = −(1/2)log(tanh K_2) は exp(−2K_2^*) = tanh K_2 =: t_2 と同じなので sinh 2K_2^* = (1/t_2 − t_2)/2。
# これらの書き換えは本文の証明には無く、検算の側で使う標準の恒等式である。
# 鎖の左辺 A = s_1 s_2^*（def_critical_sinh_product_A）と略記の展開（def_indexed_hyperbolic_abbreviations）は
# 模型の式を作る段で組み込むので、その 2 行は形の一致だけである。仮定 K_1 = K_2 は exp の単射性から u_1 = u_2 と同じなので、代入で表す。
import sys

ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

F = FractionField(PolynomialRing(QQ, 'u1,u2'))
u1, u2 = F.gens()
def tanh_of(v):            # tanh x を exp(−2x) = v で表した式
    return (1 - v) / (1 + v)
def sinh2_of(v):           # sinh 2x を exp(−2x) = v で表した式
    return (1 / v - v) / 2

t2 = tanh_of(u2)                          # exp(−2K_2^*) = tanh K_2（def_second_dual_coupling_constant）
s1 = sinh2_of(u1)                         # s_1
s2s = sinh2_of(t2)                        # s_2^*
A = s1 * s2s                              # 左辺 A（def_critical_sinh_product_A）
L = [s1 * s2s,                            # 1 行目 s_1 s_2^*
     sinh2_of(u1) * sinh2_of(t2),         # 2 行目 sinh 2K_1 sinh 2K_2^*
     sinh2_of(u2) * sinh2_of(t2),         # 3 行目 sinh 2K_2 sinh 2K_2^*
     F(1)]                                # 4 行目 1
check("左辺→1 行目: A = s_1 s_2^*（def_critical_sinh_product_A。模型に組み込んだ形の一致のみ）", A == L[0])
check("1→2 行目: 略記の展開（def_indexed_hyperbolic_abbreviations。形の一致のみ）", L[0] == L[1])
check("2→3 行目: K_1 = K_2（u_1 = u_2）を代入すると一致", (L[1] - L[2]).subs(u1=u2) == 0)
check("2→3 行目 対照: 仮定を使わないと一致しない", L[1] != L[2])
check("3→4 行目: sinh 2K_2 sinh 2K_2^* = 1 が QQ(u_2) の中で恒等的に成り立つ（second_dual_coupling_relation）", L[2] == L[3])
check("主張: u_1 = u_2 で A = 1", A.subs(u1=u2) == 1)
check("対照: 異方的（u_1 ≠ u_2）なら A − 1 は恒等的には 0 でない", A != 1)
check("対照: K_2^* の符号を誤る（exp(−2K_2^*) = 1/tanh K_2）と sinh 2K_2 sinh 2K_2^* = −1",
      sinh2_of(u2) * sinh2_of(1 / t2) == -1)

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
