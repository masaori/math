# <exp_converges>: Step 4 の行列単位による展開 Y = Σ_k Σ_l y_kl E^{(k,l)} の (i,j) 成分の鎖を一行ずつ確かめる。
# 準備: t_kl := y_kl (E^{(k,l)})_ij、(k,l) ≠ (i,j) で t_kl = y_kl·0 = 0、t_ij = y_ij·1 = y_ij、
#       s_k := Σ_l t_kl、k ≠ i で s_k = Σ_l 0 = 0、s_i = t_ij = y_ij。
# 主の鎖: (Σ_k Σ_l y_kl E^{(k,l)})_ij = Σ_k (Σ_l y_kl E^{(k,l)})_ij = Σ_k Σ_l (y_kl E^{(k,l)})_ij
#         = Σ_k Σ_l y_kl (E^{(k,l)})_ij = Σ_k Σ_l t_kl = Σ_k s_k = s_i = y_ij = Y_ij（8 個の等号）。
# 行列は成分の辞書で持ち、行列の和・スカラー倍は成分ごと（K = ℂ は def_matrix_sum・def_matrix_scalar_multiple）、
# 有限和は左から順に足す（def_finite_sum_of_matrices・def_finite_sum_of_complex_numbers）。
# K = ℝ は QQ[y_kl] の不定元、K = ℂ は definition_of_cc どおり実数の対 (u_kl, v_kl) を QQ[u, v] の不定元で持つ。
# 不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型）。
load("../../_shared/operators.sage")
load("../../_shared/complex_as_real_pairs.sage")
rep = CheckReport("exp_converges: Step 4 の行列単位による展開の (i,j) 成分の鎖")


def run(n, zero, one, add, mul, y, label):
    idx = [(a, b) for a in range(1, n + 1) for b in range(1, n + 1)]

    def E(k, l):
        return {(a, b): (one if (a, b) == (k, l) else zero) for (a, b) in idx}

    def mat_add(A, B):
        return {p: add(A[p], B[p]) for p in idx}

    def mat_smul(c, A):
        return {p: mul(c, A[p]) for p in idx}

    def mat_sum(Ms):
        acc = Ms[0]
        for M in Ms[1:]:
            acc = mat_add(acc, M)
        return acc

    def sc_sum(xs):
        acc = xs[0]
        for x in xs[1:]:
            acc = add(acc, x)
        return acc

    rng = range(1, n + 1)
    # Y = (y_kl) の書き方: Y の (k,l) 成分は y_kl
    Ymat = {(a, b): y[(a, b)] for (a, b) in idx}
    inner = {k: mat_sum([mat_smul(y[(k, l)], E(k, l)) for l in rng]) for k in rng}
    whole = mat_sum([inner[k] for k in rng])
    for i in rng:
        for j in rng:
            tag = "%s n=%d (i,j)=(%d,%d)" % (label, n, i, j)
            t = {(k, l): mul(y[(k, l)], E(k, l)[(i, j)]) for k in rng for l in rng}
            # 準備の鎖
            for k in rng:
                for l in rng:
                    if (k, l) != (i, j):
                        rep.truth(t[(k, l)] == mul(y[(k, l)], zero), tag + " t_%d%d = y·0" % (k, l))
                        rep.truth(mul(y[(k, l)], zero) == zero, tag + " y_%d%d·0 = 0" % (k, l))
            rep.truth(t[(i, j)] == mul(y[(i, j)], E(i, j)[(i, j)]), tag + " t_ij = y_ij (E^(i,j))_ij")
            rep.truth(mul(y[(i, j)], E(i, j)[(i, j)]) == mul(y[(i, j)], one), tag + " y_ij (E^(i,j))_ij = y_ij·1")
            rep.truth(mul(y[(i, j)], one) == y[(i, j)], tag + " y_ij·1 = y_ij")
            s = {k: sc_sum([t[(k, l)] for l in rng]) for k in rng}
            for k in rng:
                if k != i:
                    rep.truth(s[k] == sc_sum([zero for l in rng]), tag + " s_%d = Σ0" % k)
                    rep.truth(sc_sum([zero for l in rng]) == zero, tag + " Σ0 = 0 (k=%d)" % k)
            rep.truth(s[i] == sc_sum([t[(i, l)] for l in rng]), tag + " s_i = Σ_l t_il")
            rep.truth(sc_sum([t[(i, l)] for l in rng]) == t[(i, j)], tag + " Σ_l t_il = t_ij")
            rep.truth(t[(i, j)] == y[(i, j)], tag + " t_ij = y_ij")
            # 主の鎖
            r0 = whole[(i, j)]
            r1 = sc_sum([inner[k][(i, j)] for k in rng])
            r2 = sc_sum([sc_sum([mat_smul(y[(k, l)], E(k, l))[(i, j)] for l in rng]) for k in rng])
            r3 = sc_sum([sc_sum([mul(y[(k, l)], E(k, l)[(i, j)]) for l in rng]) for k in rng])
            r4 = sc_sum([sc_sum([t[(k, l)] for l in rng]) for k in rng])
            r5 = sc_sum([s[k] for k in rng])
            r6 = s[i]
            r7 = y[(i, j)]
            r8 = Ymat[(i, j)]
            chain = [r0, r1, r2, r3, r4, r5, r6, r7, r8]
            for a in range(len(chain) - 1):
                rep.truth(chain[a] == chain[a + 1], tag + " 主の鎖の %d 行目" % (a + 1))
    # 否定の対照: (i,j) 成分に (k,l) ≠ (i,j) の y_kl が混ざらない
    if n >= 2:
        rep.truth(whole[(1, 1)] != y[(1, 2)], "%s n=%d 否定の対照: (1,1) 成分 ≠ y_12" % (label, n))


for n in range(1, 4):
    R = PolynomialRing(QQ, ['y_%d_%d' % (k, l) for k in range(1, n + 1) for l in range(1, n + 1)])
    y = {(k, l): R.gen((k - 1) * n + (l - 1)) for k in range(1, n + 1) for l in range(1, n + 1)}
    run(n, R(0), R(1), lambda a, b: a + b, lambda a, b: a * b, y, "R")
    names = []
    for k in range(1, n + 1):
        for l in range(1, n + 1):
            names += ['u_%d_%d' % (k, l), 'v_%d_%d' % (k, l)]
    S = PolynomialRing(QQ, names)
    yc = {(k, l): (S.gen(2 * ((k - 1) * n + (l - 1))), S.gen(2 * ((k - 1) * n + (l - 1)) + 1))
          for k in range(1, n + 1) for l in range(1, n + 1)}
    run(n, iota(0, S), iota(1, S), cc_add, cc_mul, yc, "C")

rep.finish()
