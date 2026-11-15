# <inverse_of_sqrt_cc>: 準備の第三の 0_C·0_C = 0_C（complex_zero_times_is_zero の z → 0_C）と、
# 準備の第四の 0 − 2·0·π = 0 の鎖、および 0 ≤ 0 − 2·0·π < 2π から整数が 0 に定まることを確かめる。
#   0_C·0_C: (0,0)(0,0) = (0·0 − 0·0, 0·0 + 0·0) = (0 − 0, 0 + 0) = (0, 0)（QQ の対で厳密）
#   偏角:    0 − 2·0·π = 0 − 0·π（real_times_zero_is_zero、x → 2）= 0 − 0（real_zero_times_is_zero、x → π）= 0（a − 0 = a）
#            π は QQ[pi_] の不定元で表す。整数の同定だけ RIF の π（区間演算）で厳密に比べる。
load("../../_shared/operators.sage")
rep = CheckReport("inverse_of_sqrt_cc: 準備の第三の 0_C·0_C と第四の偏角 0 の整数")
q0 = QQ(0)
def cmul(u, v):
    return (u[0]*v[0] - u[1]*v[1], u[0]*v[1] + u[1]*v[0])
zero_c = (q0, q0)
rows = [cmul(zero_c, zero_c), (q0*q0 - q0*q0, q0*q0 + q0*q0), (q0 - q0, q0 + q0), (q0, q0)]
for r, s in zip(rows, rows[1:]):
    rep.truth(r == s, f"0_C·0_C の鎖: {r} = {s}")
rep.truth(cmul(zero_c, (QQ(3), QQ(-5))) == zero_c, "complex_zero_times_is_zero の z → (3,−5) でも 0_C")
R.<pi_> = PolynomialRing(QQ)
z, two = R(0), R(2)
chain = [z - (two * z) * pi_, z - z * pi_, z - z, z]
for r, s in zip(chain, chain[1:]):
    rep.truth(r == s, f"偏角の鎖: {r} = {s}")
PI = RIF(pi)
rep.truth(bool(PI > 0), "0 < π（pi_is_positive）")
sols = [k for k in range(-5, 6) if (0 - 2 * k * PI >= 0) and (0 - 2 * k * PI < 2 * PI)]
rep.truth(sols == [0], "0 ≤ 0 − 2kπ < 2π を満たす整数 k は 0 だけ")
# 否定の対照: 整数を 1 に取り違えると 0 にならない。0_C でない因子どうしの積は 0_C にならない
rep.truth(z - two * pi_ != 0, "否定の対照: 0 − 2·1·π ≠ 0")
rep.truth(cmul((QQ(1), q0), (QQ(1), q0)) != zero_c, "否定の対照: 1_C·1_C ≠ 0_C")
rep.finish()
