# <exp_converges>: Step 4 の ‖E^{(k,l)}‖ = 1 の鎖を一行ずつ厳密に確かめる。
# K = ℝ は QQ、K = ℂ は QQbar（ι_{ℝ→ℂ}(x) = (x, 0) は実部 x・虚部 0 の元）で計算し、
# 絶対値の二乗・和・平方根はすべて厳密（AA）に比べる。
# 鎖: |0_K|・|1_K| の準備（K = ℂ の |0_C| は 1 行、|1_C| は 3 行）→ (i,j) ≠ (k,l) の |E_ij|^2 の 4 行 → (k,l) の 3 行
# → i ≠ k の行ごとの和の 2 行 → i = k の行の和の 3 行 → ノルムの 5 行。
# 和は def_finite_sum_of_real_numbers のとおり左から順に足す。
load("../../_shared/operators.sage")
rep = CheckReport("exp_converges: Step 4 の行列単位のノルムの鎖")


def left_sum(terms):
    acc = None
    for t in terms:
        acc = t if acc is None else acc + t
    return acc


def real_abs(q):
    # def_real_absolute_value の場合分け
    return q if q >= 0 else -q


# |0_K| と |1_K|
rep.truth(real_abs(QQ(0)) == 0 and real_abs(QQ(1)) == 1, "K = ℝ: |0| = 0、|1| = 1（def_real_absolute_value）")
# K = ℂ: |0_C| = 0 は abs_basic_properties (3)（z = 0_C ⇒ |z| = 0）
rep.truth(AA(abs(QQbar(0))) == 0, "|0_C| = 0（abs_basic_properties (3)）")
# |1_C| = |ι(1_R)| = |1_R| = 1。ι(x) = (x, 0) は実部 x・虚部 0 の対から作る
def iota(x):
    return QQbar(QQ(x)) + QQbar(QQ(0)) * QQbar(I)
one_C = QQbar(1)
rep.truth(iota(1).real() == 1 and iota(1).imag() == 0, "ι(1_R) = (1, 0)")
rep.truth(one_C * QQbar(2 + 3*I) == QQbar(2 + 3*I) and one_C == iota(1), "1_C（積の単位元）= ι(1_R)")
rep.truth(AA(abs(iota(1))) == AA(real_abs(QQ(1))), "|ι(1_R)| = |1_R|（abs_basic_properties (6)）")
rep.truth(real_abs(QQ(1)) == 1, "|1_R| = 1（def_real_absolute_value）")

lines = 0
for Kname, K in (("R", QQ), ("C", QQbar)):
    def absK(z):
        return AA(abs(z)) if K is QQbar else AA(real_abs(QQ(z)))
    for n in range(1, 6):
        for k in range(1, n + 1):
            for l in range(1, n + 1):
                E = matrix(K, n, n, lambda i, j: K(1) if (i + 1, j + 1) == (k, l) else K(0))
                sq = {}
                for i in range(1, n + 1):
                    for j in range(1, n + 1):
                        e = E[i - 1, j - 1]
                        v = absK(e) ** 2
                        sq[(i, j)] = v
                        if (i, j) != (k, l):
                            ok = (e == K(0) and v == absK(K(0)) ** 2 and absK(K(0)) ** 2 == AA(0) ** 2
                                  and AA(0) ** 2 == AA(0) * AA(0) and AA(0) * AA(0) == 0)
                            rep.truth(ok, "%s n=%d (k,l)=(%d,%d) (i,j)=(%d,%d): |E_ij|^2 = |0_K|^2 = 0^2 = 0·0 = 0" % (Kname, n, k, l, i, j))
                            lines += 4
                        else:
                            ok = (e == K(1) and v == absK(K(1)) ** 2 and absK(K(1)) ** 2 == AA(1) ** 2 and AA(1) ** 2 == 1)
                            rep.truth(ok, "%s n=%d (k,l)=(%d,%d): |E_kl|^2 = |1_K|^2 = 1^2 = 1" % (Kname, n, k, l))
                            lines += 3
                # 行ごとの和
                rows = {}
                for i in range(1, n + 1):
                    r = left_sum([sq[(i, j)] for j in range(1, n + 1)])
                    rows[i] = r
                    if i != k:
                        zeros = left_sum([AA(0)] * n)
                        ok = (r == zeros and zeros == 0)
                        rep.truth(ok, "%s n=%d (k,l)=(%d,%d) i=%d: 行の和 = 0+…+0 = 0" % (Kname, n, k, l, i))
                        lines += 2
                    else:
                        mid = left_sum([AA(0)] * (l - 1) + [sq[(k, l)]] + [AA(0)] * (n - l))
                        ok = (r == mid and mid == sq[(k, l)] and sq[(k, l)] == 1)
                        rep.truth(ok, "%s n=%d (k,l)=(%d,%d): 行 k の和 = 0+…+|E_kl|^2+…+0 = |E_kl|^2 = 1" % (Kname, n, k, l))
                        lines += 3
                # ノルム
                total = left_sum([rows[i] for i in range(1, n + 1)])
                norm_def = AA(sum(absK(E[i, j]) ** 2 for i in range(n) for j in range(n))).sqrt()
                mid = left_sum([AA(0)] * (k - 1) + [rows[k]] + [AA(0)] * (n - k))
                y = AA(1).sqrt()
                ok = (norm_def == total.sqrt() and total == mid and mid == rows[k]
                      and rows[k].sqrt() == AA(1).sqrt() and y >= 0 and y ** 2 == 1 and y == 1 and norm_def == 1)
                rep.truth(ok, "%s n=%d (k,l)=(%d,%d): ‖E‖ = √(ΣΣ) = √(0+…+行k+…+0) = √(行k) = √1 = 1" % (Kname, n, k, l))
                lines += 5
# 否定の対照: (k,l) 成分を 2 にした行列ではノルムは 1 にならない
bad = matrix(QQ, 2, 2, [0, 2, 0, 0])
rep.truth(AA(sum(AA(x) ** 2 for x in bad.list())).sqrt() != 1, "否定の対照: 成分 2 の行列のノルムは 1 でない")
print("  確かめた鎖の行: %d" % lines)
rep.finish()
