# 共通の準備（linearity_of_T_on_check_Z_Y・linearity_of_T_V2 の検算が使う）。
# Ž_μ・Y̌_μ は本文の定め方（half_integer_check_operators.sage の Setting。Z_m・Y_m は成分の式、位相は 1 の冪根）で
# 円分体 L := QQ(ζ_{4M}) に作る。主張の a, b ∈ ℂ は L 上の多項式環 Q := L[a, b] の不定元に置く。
# 主張の両辺の成分は a, b について L 係数の一次式なので、Q の中での一致は、L を ℂ へ埋め込んで a, b に
# 任意の複素数を入れた一致を含む（全ての a, b ∈ ℂ を一度に表す）。
# 共役に使う g と g^{-1} は呼び出し側が QQ の行列として渡す。積・スカラー倍・和は本文の成分の式
# （matrix_operations_by_definition.sage）で組み、Sage の `*`・`+`・inverse は比べる側にだけ使う。
load("../../_shared/half_integer_check_operators.sage")


def check_operators_over_L(M):
    """Ž_μ・Y̌_μ（μ = 1..M）を L の行列として返す。"""
    S0 = Setting(M)
    to_L = lambda A: matrix(S0.L, A.nrows(), A.ncols(), lambda r, c: S0.L(A[r, c].constant_coefficient()))
    Zc = {mu: to_L(S0.checkZ(mu)) for mu in range(1, M + 1)}
    Yc = {mu: to_L(S0.checkY(mu)) for mu in range(1, M + 1)}
    return S0.L, Zc, Yc


def T_body(g, h, ginv):
    """def_T_g の T_g(h) := (gh)g^{-1}（積は mat_mult の成分の式）。"""
    return body_product(body_product(g, h), ginv)


def check_linearity_for(M, g_qq, ginv_qq, tag, gname):
    """g ∈ R^× の検査と、linearity_of_T の鎖の当てはめ・主張の一行を Q の中で確かめる。"""
    n = 2**M
    L, Zc, Yc = check_operators_over_L(M)
    Q = PolynomialRing(L, ['a', 'b'])
    a, b = Q.gens()
    g = matrix(Q, g_qq)
    ginv = matrix(Q, ginv_qq)
    Id = body_identity(Q, n)
    # g, g^{-1} ∈ R（2^M 次の正方行列）と、g が R^× の元であること（左右の逆元）
    report(g.nrows() == g.ncols() == n and ginv.nrows() == ginv.ncols() == n, f"{tag}: {gname}, {gname}^{{-1}} は 2^M 次の正方行列")
    report(body_product(g, ginv) == Id and body_product(ginv, g) == Id, f"{tag}: {gname}{gname}^{{-1}} = {gname}^{{-1}}{gname} = I（{gname} ∈ R^×）")
    report(matrix(QQ, g_qq).inverse() == matrix(QQ, ginv_qq), f"{tag}: 渡した {gname}^{{-1}} は Sage の inverse と一致")
    for mu in range(1, M + 1):
        Z = matrix(Q, Zc[mu])
        Y = matrix(Q, Yc[mu])
        lab = f"{tag} mu={mu}"
        report(Z.nrows() == Z.ncols() == n and Y.nrows() == Y.ncols() == n, f"{lab}: Ž_μ, Y̌_μ ∈ R")
        aZ, bY = body_scalar(a, Z), body_scalar(b, Y)
        gZ, gY = body_product(g, Z), body_product(g, Y)
        # linearity_of_T の鎖を X := Ž_μ、W := Y̌_μ に当てた各行
        chain = [
            ("T_g(aŽ+bY̌) = (g(aŽ+bY̌))g^{-1}", body_product(body_product(g, body_sum(aZ, bY)), ginv)),
            ("(g(aŽ)+g(bY̌))g^{-1}", body_product(body_sum(body_product(g, aZ), body_product(g, bY)), ginv)),
            ("(g(aŽ))g^{-1}+(g(bY̌))g^{-1}", body_sum(body_product(body_product(g, aZ), ginv), body_product(body_product(g, bY), ginv))),
            ("(a(gŽ))g^{-1}+(b(gY̌))g^{-1}", body_sum(body_product(body_scalar(a, gZ), ginv), body_product(body_scalar(b, gY), ginv))),
            ("a((gŽ)g^{-1})+b((gY̌)g^{-1})", body_sum(body_scalar(a, body_product(gZ, ginv)), body_scalar(b, body_product(gY, ginv)))),
            ("aT_g(Ž)+bT_g(Y̌)", body_sum(body_scalar(a, T_body(g, Z, ginv)), body_scalar(b, T_body(g, Y, ginv)))),
        ]
        for (n0, v0), (n1, v1) in zip(chain, chain[1:]):
            report(v0 == v1, f"{lab}: linearity_of_T の行「{n0}」=「{n1}」")
        lhs = T_body(g, body_sum(aZ, bY), ginv)
        rhs = body_sum(body_scalar(a, T_body(g, Z, ginv)), body_scalar(b, T_body(g, Y, ginv)))
        report(lhs == rhs, f"{lab}: 主張の一行 T_{gname}(aŽ_μ+bY̌_μ) = aT_{gname}(Ž_μ)+bT_{gname}(Y̌_μ)")
        # 独立の経路: Sage の `*`・`+`・inverse で組んだ両辺
        gi = matrix(Q, matrix(QQ, g_qq).inverse())
        report(g * (a * Z + b * Y) * gi == a * (g * Z * gi) + b * (g * Y * gi) == lhs, f"{lab}: Sage の積と inverse で組んだ両辺も一致し、本文の成分の式の値に等しい")
        # 対照: 係数を入れ替えた右辺とは一致しない。共役は Ž_μ・Y̌_μ を動かす（検算が恒等写像を見ているのではない）
        report(lhs != body_sum(body_scalar(b, T_body(g, Z, ginv)), body_scalar(a, T_body(g, Y, ginv))), f"{lab}: 対照 a と b を入れ替えた右辺とは一致しない")
        report(T_body(g, Z, ginv) != Z and T_body(g, Y, ginv) != Y, f"{lab}: 対照 T_{gname}(Ž_μ) ≠ Ž_μ、T_{gname}(Y̌_μ) ≠ Y̌_μ")
