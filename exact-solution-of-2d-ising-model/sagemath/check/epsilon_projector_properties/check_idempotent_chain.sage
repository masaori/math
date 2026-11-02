# 対象ラベル: epsilon_projector_properties
# 本文 (1) の鎖 (P^{(+)})^2 = P^{(+)}P^{(+)} = … = P^{(+)} の 17 行。
#   各行を本文の定め方の積・和・スカラー倍で組み、隣の行と等しいことを M_col = 1,…,5 で厳密に確かめる。
#   加えて ε を不定元の行列 E（ε の性質を何も持たない）に置き換え、ε^2 = I を引く第 11 行→第 12 行だけが
#   一致せず、その差がちょうど (1/4)(EE - I) であること、それ以外の行は E のままで一致することを確かめる。
# 帰属: Mat(2^M, QQ) と Mat(n, QQ[E_ij])。
load("_prelude.sage")

h = QQ(1) / 2
q = QQ(1) / 4


def lines_of_idempotent_chain(E):
    n = E.nrows()
    R = E.base_ring()
    I = body_identity(R, n)
    IpE = body_sum(I, E)
    P = projector_body(E)
    halfIpE = body_scalar(h, IpE)
    return [
        body_product(P, P),                                                       # 第 1 行 (P)^2（X^2 := XX により値は PP）
        body_product(P, P),                                                       # 第 2 行 PP
        body_product(halfIpE, halfIpE),                                           # (1/2(I+ε))(1/2(I+ε))
        body_scalar(h, body_product(IpE, halfIpE)),                               # 1/2((I+ε)(1/2(I+ε)))
        body_scalar(h, body_scalar(h, body_product(IpE, IpE))),                   # 1/2(1/2((I+ε)(I+ε)))
        body_scalar(h * h, body_product(IpE, IpE)),                               # (1/2·1/2)((I+ε)(I+ε))
        body_scalar(q, body_product(IpE, IpE)),                                   # 1/4((I+ε)(I+ε))
        body_scalar(q, body_sum(body_product(I, IpE), body_product(E, IpE))),     # 1/4(I(I+ε) + ε(I+ε))
        body_scalar(q, body_sum(body_sum(body_product(I, I), body_product(I, E)),
                                body_sum(body_product(E, I), body_product(E, E)))),  # 1/4((II+Iε)+(εI+εε))
        body_scalar(q, body_sum(body_sum(I, E),
                                body_sum(body_product(E, I), body_product(E, E)))),  # 1/4((I+ε)+(εI+εε))
        body_scalar(q, body_sum(body_sum(I, E), body_sum(E, body_product(E, E)))),   # 1/4((I+ε)+(ε+εε))
        body_scalar(q, body_sum(body_sum(I, E), body_sum(E, I))),                 # 1/4((I+ε)+(ε+I))
        body_scalar(q, body_sum(IpE, IpE)),                                       # 1/4((I+ε)+(I+ε))
        body_scalar(q, body_scalar(2, IpE)),                                      # 1/4(2(I+ε))
        body_scalar(q * 2, IpE),                                                  # (1/4·2)(I+ε)
        body_scalar(h, IpE),                                                      # 1/2(I+ε)
        P,                                                                        # P
    ]


# ε^2 = I を使う行の番号（第 11 行 → 第 12 行）
EPS_SQUARE_STEP = 11

for M in M_COL_RANGE:
    E, P = projector(M)
    n = 2 ** M
    # 引く事実: ε^2 = I（epsilon_square_and_eigenvalues）。ここでは定義から作った ε で直接確かめる。
    assert body_product(E, E) == body_identity(QQ, n)
    lines = lines_of_idempotent_chain(E)
    assert len(lines) == 17
    check_chain(lines, f"M_col={M}")
    assert lines[0] == P * P == P   # 比べる側: Sage の `*`
    print(f"  M_col={M}: (1) の鎖の 17 行は隣どうし一致し、P^2 = P")

for n in [2, 4]:
    R, G = generic_matrix(n, "E")
    I = body_identity(R, n)
    lines = lines_of_idempotent_chain(G)
    for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
        if k == EPS_SQUARE_STEP:
            assert a != b
            assert a - b == q * (G * G - I)
        else:
            assert a == b, f"n={n}: 第 {k} 行は ε^2 = I を使わずに一致するはず"
    print(f"  n={n} の不定元の行列 E: ε^2 = I を引く第 11 行→第 12 行だけが差 (1/4)(EE - I) を持ち、他の行は一致")

print("RESULT: PASS")
