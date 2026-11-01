# 対象ラベル: finite_sum_of_matrices_entrywise
# 証明の帰納法の基底の鎖と帰納の段の鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   基底:  (Σ_{j=1}^{1} X_j)_ik = (X_1)_ik = Σ_{j=1}^{1} (X_j)_ik
#   帰納:  (Σ_{j=1}^{r+1} X_j)_ik = ((Σ_{j=1}^{r} X_j) + X_{r+1})_ik = (Σ_{j=1}^{r} X_j)_ik + (X_{r+1})_ik
#          = (Σ_{j=1}^{r} (X_j)_ik) + (X_{r+1})_ik = Σ_{j=1}^{r+1} (X_j)_ik
# 行列の有限和は本文 def_finite_sum_of_matrices のとおり def_matrix_sum の和で左から順に足して組む（body_finite_sum）。
# 複素数の有限和は本文 def_finite_sum_of_complex_numbers のとおり左から順に足す（complex_finite_sum。Python の sum とは別に書く）。
# 主張そのものは、Sage の行列の和 `sum`（独立な経路）で作った有限和の成分とも比べる。
# 帰属: QQ 上の多項式環（X_j の成分は不定元）。不定元で成り立つ等号は、成分へ任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")


def complex_finite_sum(zs):
    total = zs[0]
    for z in zs[1:]:
        total = total + z
    return total


DIMS = [1, 2, 3]
RMAX = 6
count = 0
for m in DIMS:
    for n in DIMS:
        P, _, Xs = generic_ring([(f"X{j}", m, n) for j in range(1, RMAX + 1)])
        for i in range(m):
            for k in range(n):
                base = [body_finite_sum(Xs[:1])[i, k], Xs[0][i, k], complex_finite_sum([Xs[0][i, k]])]
                assert base[0] == base[1] == base[2], (m, n, i, k)
                for r in range(1, RMAX):
                    chain = [
                        body_finite_sum(Xs[:r + 1])[i, k],
                        body_sum(body_finite_sum(Xs[:r]), Xs[r])[i, k],
                        body_finite_sum(Xs[:r])[i, k] + Xs[r][i, k],
                        complex_finite_sum([X[i, k] for X in Xs[:r]]) + Xs[r][i, k],
                        complex_finite_sum([X[i, k] for X in Xs[:r + 1]]),
                    ]
                    for t in range(len(chain) - 1):
                        assert chain[t] == chain[t + 1], (m, n, i, k, r, t)
                    count += 1
        for r in range(1, RMAX + 1):
            assert body_finite_sum(Xs[:r]) == sum(Xs[:r], matrix(P, m, n, 0)), (m, n, r)
print(f"checked {count} induction chains (r = 1..{RMAX - 1}) and the statement for r = 1..{RMAX} over 9 shapes")

# 対照: 第二項の (i,k) 成分の代わりに (k,i) 成分を足すと、2 行 2 列で主張の右辺と一致しない
P, _, Xs = generic_ring([(f"X{j}", 2, 2) for j in range(1, 3)])
assert body_finite_sum(Xs)[0, 1] != Xs[0][0, 1] + Xs[1][1, 0]
print("対照: 添字を入れ替えた右辺は一致しない")
print("RESULT: PASS")
