# <exp_converges>: Step 4 の行列単位による展開 Y = Σ_k Σ_l y_kl E^{(k,l)} の (i,j) 成分で、
# (k,l) ≠ (i,j) の項 y_kl·0 が 0 になる段（K = ℝ は real_times_zero_is_zero、K = ℂ は complex_times_zero_is_zero）を確かめる。
# K = ℝ は QQ[y_kl] の不定元、K = ℂ は definition_of_cc どおり実数の対 (u_kl, v_kl) を QQ[u, v] の不定元で持つ。
# 不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型）。
load("../../_shared/operators.sage")
load("../../_shared/complex_as_real_pairs.sage")
rep = CheckReport("exp_converges: Step 4 の行列単位による展開の 0 の項")

for n in range(1, 4):
    # K = ℝ
    R = PolynomialRing(QQ, ['y_%d_%d' % (k, l) for k in range(1, n + 1) for l in range(1, n + 1)])
    y = {(k, l): R.gen((k - 1) * n + (l - 1)) for k in range(1, n + 1) for l in range(1, n + 1)}
    for i in range(1, n + 1):
        for j in range(1, n + 1):
            terms = []
            for k in range(1, n + 1):
                for l in range(1, n + 1):
                    e = R(1) if (k, l) == (i, j) else R(0)
                    t = y[(k, l)] * e
                    if (k, l) != (i, j):
                        rep.truth(t == R(0), "R n=%d (i,j)=(%d,%d) (k,l)=(%d,%d): y_kl·0 = 0" % (n, i, j, k, l))
                    else:
                        rep.truth(t == y[(i, j)], "R n=%d (i,j)=(%d,%d): y_ij·1 = y_ij" % (n, i, j))
                    terms.append(t)
            rep.truth(sum(terms) == y[(i, j)], "R n=%d (i,j)=(%d,%d): 和 = y_ij" % (n, i, j))
    # K = ℂ（実数の対）
    names = []
    for k in range(1, n + 1):
        for l in range(1, n + 1):
            names += ['u_%d_%d' % (k, l), 'v_%d_%d' % (k, l)]
    S = PolynomialRing(QQ, names)
    yc = {(k, l): (S.gen(2 * ((k - 1) * n + (l - 1))), S.gen(2 * ((k - 1) * n + (l - 1)) + 1))
          for k in range(1, n + 1) for l in range(1, n + 1)}
    zero_c = iota(0, S)
    one_c = iota(1, S)
    for i in range(1, n + 1):
        for j in range(1, n + 1):
            acc = zero_c
            for k in range(1, n + 1):
                for l in range(1, n + 1):
                    e = one_c if (k, l) == (i, j) else zero_c
                    t = cc_mul(yc[(k, l)], e)
                    if (k, l) != (i, j):
                        rep.truth(t == zero_c, "C n=%d (i,j)=(%d,%d) (k,l)=(%d,%d): y_kl 0_C = 0_C" % (n, i, j, k, l))
                    else:
                        rep.truth(t == yc[(i, j)], "C n=%d (i,j)=(%d,%d): y_ij 1_C = y_ij" % (n, i, j))
                    acc = cc_add(acc, t)
            rep.truth(acc == yc[(i, j)], "C n=%d (i,j)=(%d,%d): 和 = y_ij" % (n, i, j))

# 否定の対照: 0 の代わりに 1 を置くと y_kl·1 は 0 にならない
R1 = PolynomialRing(QQ, 'y')
rep.truth(R1.gen() * R1(1) != R1(0), "否定の対照: y·1 ≠ 0")
rep.finish()
