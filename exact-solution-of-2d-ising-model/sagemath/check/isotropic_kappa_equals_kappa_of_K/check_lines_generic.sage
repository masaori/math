# 対象ラベル: isotropic_kappa_equals_kappa_of_K
# 準備 K_2^* = K^* と κ = κ(K) の鎖の各行を厳密に確かめる。浮動小数点は使わない。
# (a) 準備: u_2 := exp(−2K_2)、u := exp(−2K) とおき、tanh x = (1 − exp(−2x))/(1 + exp(−2x)) で tanh を QQ(u_2, u) に置く
#     （本文の証明には無い、検算の側の標準の恒等式）。K_2^* = −(1/2)log(tanh K_2)（def_second_dual_coupling_constant）と
#     K^* = −(1/2)log(tanh K)（def_isotropic_dual_coupling）は log の引数で比べる。log は関数なので、引数が等しければ値が等しい。
#     仮定 K_2 = K は exp の単射性から u_2 = u と同じなので、代入で表す。
# (b) κ の鎖: QQ 上の多項式環で、各行の差がその行の引いた関係式 1 本で生成するイデアルに入り、
#     その 1 本を抜いてほかの 3 本を残すと入らないことを確かめる。
import sys

ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

F = FractionField(PolynomialRing(QQ, 'u2,u'))
u2, u = F.gens()
def tanh_of(v):
    return (1 - v) / (1 + v)
P = [tanh_of(u2),     # 左辺 K_2^* を def_second_dual_coupling_constant で展開した 1 行目の log の引数 tanh K_2
     tanh_of(u),      # 2 行目の引数 tanh K
     tanh_of(u)]      # 3 行目 K^* の定義（def_isotropic_dual_coupling）の引数 tanh K
print("NOT CHECKED 準備 左辺→1 行目: K_2^* = −(1/2)log(tanh K_2) は def_second_dual_coupling_constant の書き写しなので、検算の対象が無い")
check("準備 1→2 行目: K_2 = K（u_2 = u）を代入すると log の引数が一致", P[0].subs(u2=u) == P[1])
check("準備 1→2 行目 対照: 仮定を使わないと一致しない", P[0] != P[1])
check("準備 2→3 行目: def_isotropic_dual_coupling の式と一致（形の一致のみ）", P[1] == P[2])

R = PolynomialRing(QQ, 'k,k1,k2s,ks,kap,kapK', order='degrevlex')
k, k1, k2s, ks, kap, kapK = R.gens()
def in_ideal(d, rels):
    d = R(d)
    return d == 0 if not rels else d in R.ideal(rels)
rels = [kap - (2 * k1 - 2 * k2s),   # def_kappa
        k1 - k,                     # 仮定 K_1 = K
        k2s - ks,                   # 準備の K_2^* = K^*
        kapK - (2 * k - 2 * ks)]    # def_isotropic_kappa_of_K
names = ["def_kappa", "K_1 = K", "準備の K_2^* = K^*", "def_isotropic_kappa_of_K"]
L = [kap, 2 * k1 - 2 * k2s, 2 * k - 2 * k2s, 2 * k - 2 * ks, kapK]
lines = ["左辺→1", "1→2", "2→3", "3→4"]
for j in range(4):
    check(f"κ の鎖 {lines[j]} 行目: {names[j]} の 1 本だけで成り立つ", in_ideal(L[j] - L[j + 1], [rels[j]]))
    others = [r for i, r in enumerate(rels) if i != j]
    check(f"κ の鎖 {lines[j]} 行目 対照: {names[j]} を抜くと（ほかの 3 本があっても）成り立たない",
          not in_ideal(L[j] - L[j + 1], others))
check("主張: 4 本の関係式のもとで κ = κ(K)", in_ideal(kap - kapK, rels))

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
