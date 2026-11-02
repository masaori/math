# 対象ラベル: epsilon_projector_properties
# 本文 (2) の (⊆) の二つの鎖。
#   第一の鎖 P y = P(Px) = (PP)x = (P)^2 x = Px = y（6 行）を、x を不定元のベクトルにして厳密に。
#   第二の鎖 ε y = ε(Py) = … = Py = y（13 行）を、y = Px で厳密に。
#   加えて、第二の鎖の第 3 行〜第 12 行（ε((1/2(I+ε))y) から Py まで）は y を任意の不定元のベクトルにしても、
#   ε^2 = I を引く第 8 行→第 9 行を除いて一致し、ε を不定元の行列 E に置けばその一行だけが差 (1/2)(EE - I)y を持つことを見る。
#   最初と最後の行は Py = y（第一の鎖）を使うので、y ∈ im P でだけ成り立つ。任意の y では成り立たないことも見る。
# 帰属: QQ[x_1,…,x_n] 上の n 行 1 列の行列、Mat(2^M, QQ)。
load("_prelude.sage")

h = QQ(1) / 2


def middle_lines(E, y):
    """第二の鎖の第 3 行〜第 12 行（ε((1/2(I+ε))y) … Py）。第 2 行 ε(Py) は P の定義を展開する前の形なので別に置く。"""
    n = E.nrows()
    R = y.base_ring()
    E = E.change_ring(R)
    I = body_identity(R, n)
    IpE = body_sum(I, E)
    halfIpE = body_scalar(h, IpE)
    return [
        body_product(E, body_product(halfIpE, y)),                                # 第 3 行 ε((1/2(I+ε))y)
        body_product(E, body_scalar(h, body_product(IpE, y))),                    # 第 4 行 ε(1/2((I+ε)y))
        body_scalar(h, body_product(E, body_product(IpE, y))),                    # 第 5 行 1/2(ε((I+ε)y))
        body_scalar(h, body_product(body_product(E, IpE), y)),                    # 第 6 行 1/2((ε(I+ε))y)
        body_scalar(h, body_product(body_sum(body_product(E, I), body_product(E, E)), y)),  # 第 7 行
        body_scalar(h, body_product(body_sum(E, body_product(E, E)), y)),         # 第 8 行 1/2((ε+εε)y)
        body_scalar(h, body_product(body_sum(E, I), y)),                          # 第 9 行 1/2((ε+I)y)
        body_scalar(h, body_product(body_sum(I, E), y)),                          # 第 10 行 1/2((I+ε)y)
        body_product(halfIpE, y),                                                 # 第 11 行 (1/2(I+ε))y
        body_product(projector_body(E), y),                                       # 第 12 行 Py
    ]


for M in M_COL_RANGE:
    E, P = projector(M)
    n = 2 ** M
    R, x = generic_vector(n, "x")
    PR = P.change_ring(R)
    ER = E.change_ring(R)
    y = body_product(PR, x)
    # 第一の鎖
    first = [
        body_product(PR, y),                       # P y
        body_product(PR, body_product(PR, x)),     # P(Px)
        body_product(body_product(PR, PR), x),     # (PP)x
        body_product(body_product(PR, PR), x),     # (P)^2 x（X^2 := XX。値は前の行と同じ式になるので表記の行）
        body_product(PR, x),                       # Px（(1) の P^2 = P を使う）
        y,                                         # y
    ]
    check_chain(first, f"M_col={M} 第一の鎖")
    # (1) を使う行が実際に (1) を使っていること: P^2 x と Px の差が (P^2 - P)x であり、P^2 = P だから 0
    assert body_product(PR, PR) == PR
    # 第二の鎖
    second = [body_product(ER, y), body_product(ER, body_product(PR, y))] + middle_lines(E, y) + [y]
    assert len(second) == 13
    check_chain(second, f"M_col={M} 第二の鎖")
    assert ER * y == y   # 比べる側: Sage の `*`
    print(f"  M_col={M}: 不定元の x について y = Px は Py = y と εy = y を満たし、二つの鎖の各行は隣どうし一致")

    # 中ほどの行は任意の y で成り立ち、最初と最後の行は y ∈ im P でだけ成り立つ
    Rg, g = generic_vector(n, "g")
    mid = middle_lines(E, g)
    check_chain(mid, f"M_col={M} 任意の y の中ほどの行")
    assert body_product(P.change_ring(Rg), g) != g
    assert body_product(E.change_ring(Rg), g) != g

for n in [2, 4]:
    RE, G = generic_matrix(n, "E")
    S = PolynomialRing(RE, [f"y{k}" for k in range(1, n + 1)])
    yv = matrix(S, n, 1, S.gens())
    GS = G.change_ring(S)
    mid = middle_lines(GS, yv)
    for k, (a, b) in enumerate(zip(mid, mid[1:]), start=3):
        if k == 8:   # 第 8 行 → 第 9 行（ε^2 = I）
            assert a != b
            assert a - b == h * ((GS * GS - identity_matrix(S, n)) * yv)
        else:
            assert a == b, f"n={n}: 第 {k} 行は ε^2 = I を使わずに一致するはず"
    print(f"  n={n} の不定元の行列 E: ε^2 = I を引く第 8 行→第 9 行だけが差 (1/2)(EE - I)y を持ち、他の行は一致")

print("RESULT: PASS")
