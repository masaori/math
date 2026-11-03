# 対象ラベル: commutation_V_plus_check_psi
# 証明の準備 1（組と 2×2 行列の積の成分、5 式）と準備 2（結合律、10 式の鎖と組の 3 式）を一行ずつ確かめる。
# 一般の点: X_1, X_2 ∈ Mat(4,ℂ)（R の M_col = 2 の大きさ）の成分と G, H の成分を QQ 上の独立な不定元に取り、
#   各行を本文の定め方（matrix_operations_by_definition.sage の成分の式、有限和は左から順に足す）で別々に組んで、隣り合う行が
#   多項式として等しいことを見る。成分の式は不定元に依らないので、R の他の大きさでも同じ行の組み方になる。
# 独立な経路: 準備 1 の終点を Sage の `*`・`+` で作った g_{1l}X_1 + g_{2l}X_2 と、準備 2 の終点を Sage の行列積 GH で作った値と比べる。
# 対照: 組を行で読んだ (g_{l1}X_1 + g_{l2}X_2)、積の順序を入れ替えた (X_1, X_2)(HG) とは一致しない。
load("_prelude.sage")

rep = Report("commutation_V_plus_check_psi: 準備 1・準備 2（一般の不定元）")

d = 4
P, sc, (X1, X2) = generic_ring([('X', d, d), ('W', d, d)], scalars=['g11', 'g12', 'g21', 'g22', 'h11', 'h12', 'h21', 'h22'])
g11, g12, g21, g22, h11, h12, h21, h22 = sc
G = matrix(P, 2, 2, [g11, g12, g21, g22])
H = matrix(P, 2, 2, [h11, h12, h21, h22])
Xs = [X1, X2]
pair = (X1, X2)


def chain(rows, label):
    for k in range(len(rows) - 1):
        rep.check(rows[k] == rows[k + 1], f"{label} 第 {k+1} 式 = 第 {k+2} 式")


def prep1_rows(pair, G, l):
    Y1, Y2 = pair
    return [
        pr(l, pair_times_two_by_two(pair, G)),
        pr(l, (pair_times_column(Y1, Y2, G[0, 0], G[1, 0]), pair_times_column(Y1, Y2, G[0, 1], G[1, 1]))),
        pair_times_column(Y1, Y2, G[0, l - 1], G[1, l - 1]),
        body_sum(body_scalar(G[0, l - 1], Y1), body_scalar(G[1, l - 1], Y2)),
        body_sum(body_finite_sum([body_scalar(G[0, l - 1], Y1)]), body_scalar(G[1, l - 1], Y2)),
        body_finite_sum([body_scalar(G[i, l - 1], [Y1, Y2][i]) for i in range(2)]),
    ]


def complex_finite_sum(terms):
    """def_finite_sum_of_complex_numbers（左から順に足す）。"""
    total = terms[0]
    for t in terms[1:]:
        total = total + t
    return total


for l in (1, 2):
    rows = prep1_rows(pair, G, l)
    chain(rows, f"準備 1（l = {l}）")
    rep.check(rows[-1] == G[0, l - 1] * X1 + G[1, l - 1] * X2, f"準備 1（l = {l}）の終点 = Sage の g_{{1l}}X_1 + g_{{2l}}X_2")
    rep.check(rows[-1] != G[l - 1, 0] * X1 + G[l - 1, 1] * X2, f"対照 準備 1（l = {l}）: 行で読んだ g_{{l1}}X_1 + g_{{l2}}X_2 とは異なる")

GH = body_product(G, H)
pG = pair_times_two_by_two(pair, G)
for l in (1, 2):
    L = l - 1
    rows = [
        pr(l, pair_times_two_by_two(pG, H)),
        body_finite_sum([body_scalar(H[k, L], pr(k + 1, pG)) for k in range(2)]),
        body_finite_sum([body_scalar(H[k, L], body_finite_sum([body_scalar(G[i, k], Xs[i]) for i in range(2)])) for k in range(2)]),
        body_finite_sum([body_finite_sum([body_scalar(H[k, L], body_scalar(G[i, k], Xs[i])) for i in range(2)]) for k in range(2)]),
        body_finite_sum([body_finite_sum([body_scalar(H[k, L] * G[i, k], Xs[i]) for i in range(2)]) for k in range(2)]),
        body_finite_sum([body_finite_sum([body_scalar(H[k, L] * G[i, k], Xs[i]) for k in range(2)]) for i in range(2)]),
        body_finite_sum([body_scalar(complex_finite_sum([H[k, L] * G[i, k] for k in range(2)]), Xs[i]) for i in range(2)]),
        body_finite_sum([body_scalar(complex_finite_sum([G[i, k] * H[k, L] for k in range(2)]), Xs[i]) for i in range(2)]),
        body_finite_sum([body_scalar(GH[i, L], Xs[i]) for i in range(2)]),
        pr(l, pair_times_two_by_two(pair, GH)),
    ]
    chain(rows, f"準備 2（l = {l}）")
    rep.check(rows[-1] == (G * H)[0, L] * X1 + (G * H)[1, L] * X2, f"準備 2（l = {l}）の終点 = Sage の (GH)_{{1l}}X_1 + (GH)_{{2l}}X_2")
    rep.check(rows[0] != pr(l, pair_times_two_by_two(pair, body_product(H, G))), f"対照 準備 2（l = {l}）: (X_1, X_2)(HG) とは異なる")

lhs = pair_times_two_by_two(pG, H)
prows = [lhs, (pr(1, lhs), pr(2, lhs)),
         (pr(1, pair_times_two_by_two(pair, GH)), pr(2, pair_times_two_by_two(pair, GH))),
         pair_times_two_by_two(pair, GH)]
for k in range(len(prows) - 1):
    rep.check(pair_eq(prows[k], prows[k + 1]), f"準備 2 の組の鎖 第 {k+1} 式 = 第 {k+2} 式")

rep.finish()
