# 対象ラベル: isotropic_gamma_in_kappa
# γ(θ) の鎖の行を、根号の中身の等号として QQ 上の多項式環で厳密に確かめる。浮動小数点は使わない。
# √·^(R≥0)・arcsinh・sinh^2(·/2) は関数なので、引数が等しければ値が等しい。そこで各行を、根号の中身
# X + A·Y（X := sinh^2(κ/2)、Y := sin^2(θ/2)）と、最後の行の sinh^2 の引数 κ と κ(K) の等号で表す。
# 1 行目（gamma_kappa_identity の第 3 式）はその主張の書き写しで、内容は sagemath/check/gamma_kappa_identity/ が確かめる。
import sys

ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

P = PolynomialRing(QQ, 'X,Y,a,kap,kapK')
X, Y, a, kap, kapK = P.gens()
G = [X + a * Y, X + 1 * Y, X + Y]
check("1→2 行目: isotropic_A_equals_one（A = 1）の 1 本だけで根号の中身が一致", (G[0] - G[1]) in P.ideal([a - 1]))
check("1→2 行目 対照: A = 1 を抜くと一致しない", G[0] - G[1] != 0)
check("2→3 行目: 1·Y = Y（多項式の等号）", G[1] == G[2])
check("3→4 行目: isotropic_kappa_equals_kappa_of_K（κ = κ(K)）の 1 本だけで sinh^2 の引数 κ/2 と κ(K)/2 が一致",
      (kap / 2 - kapK / 2) in P.ideal([kap - kapK]))
check("3→4 行目 対照: κ = κ(K) を抜くと一致しない", kap / 2 - kapK / 2 != 0)

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
