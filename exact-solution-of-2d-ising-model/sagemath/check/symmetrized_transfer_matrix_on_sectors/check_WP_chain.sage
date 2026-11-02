# 対象ラベル: symmetrized_transfer_matrix_on_sectors
# 証明の最後の鎖 WP = ((BV_2)B)P = ⋯ = ((CV_2)C)P = V^{(+)}P の 16 等号を、各行をその括弧の形どおりに mat_mult の成分の式で組んで
# 隣の行と厳密に比べる。仮定は BP = CP・PC = CP・PV_2 = V_2P の三つで、これを満たす一般の組として
#   C := Y + εYε、V_2 := U + εUε（ε と可換、したがって P = (1/2)(I+ε) と可換）、B := C + Z(I - P)（BP = CP）
# を取る。M_col = 2 は Y・U・Z の成分を独立な不定元に、M_col = 3, 4 は成分を QQ(i) の乱数（種を固定）にする。
# W は def_symmetrized_transfer_matrix の (BV_2)B、V^{(+)} は def_V_plus の (CV_2)C として組む。
# 対照（仮定を一つずつ外す）: B を独立にすると第 2→3・8→9 行（BP = CP）だけ、C を ε と可換でなくすると第 3→4・13→14 行だけ、
# V_2 を ε と可換でなくすると第 6→7・10→11 行だけが崩れる。
load("_prelude.sage")


def chain(B, C, V, P):
    m = body_product
    W = m(m(B, V), B)
    Vp = m(m(C, V), C)
    return [
        m(W, P),                          # 0: WP
        m(m(m(B, V), B), P),              # 1: ((BV_2)B)P
        m(m(B, V), m(B, P)),              # 2: (BV_2)(BP)
        m(m(B, V), m(C, P)),              # 3: (BV_2)(CP)
        m(m(B, V), m(P, C)),              # 4: (BV_2)(PC)
        m(m(m(B, V), P), C),              # 5: ((BV_2)P)C
        m(m(B, m(V, P)), C),              # 6: (B(V_2P))C
        m(m(B, m(P, V)), C),              # 7: (B(PV_2))C
        m(m(m(B, P), V), C),              # 8: ((BP)V_2)C
        m(m(m(C, P), V), C),              # 9: ((CP)V_2)C
        m(m(C, m(P, V)), C),              # 10: (C(PV_2))C
        m(m(C, m(V, P)), C),              # 11: (C(V_2P))C
        m(m(m(C, V), P), C),              # 12: ((CV_2)P)C
        m(m(C, V), m(P, C)),              # 13: (CV_2)(PC)
        m(m(C, V), m(C, P)),              # 14: (CV_2)(CP)
        m(m(m(C, V), C), P),              # 15: ((CV_2)C)P
        m(Vp, P),                         # 16: V^(+)P
    ]


def broken(ln):
    return [k for k in range(1, len(ln)) if ln[k - 1] != ln[k]]


set_random_seed(20261102)
for M in [2, 3, 4]:
    n = 2 ** M
    if M == 2:
        names = [f"{a}_{r}_{s}" for a in "yuzbcv" for r in range(n) for s in range(n)]
        R = PolynomialRing(KG, names)
        g = R.gens()
        Y, U, Z, Bf, Cf, Vf = [matrix(R, n, n, g[k * n * n:(k + 1) * n * n]) for k in range(6)]
    else:
        R = KG
        rnd = lambda: matrix(KG, n, n, lambda r, s: KG(QQ.random_element(9, 9)) + i_K * QQ.random_element(9, 9))
        Y, U, Z, Bf, Cf, Vf = [rnd() for _ in range(6)]
    E = epsilon(M).change_ring(R)
    P = projector_plus(M).change_ring(R)
    I = body_identity(R, n)
    C = body_sum(Y, body_product(body_product(E, Y), E))
    V = body_sum(U, body_product(body_product(E, U), E))
    B = body_sum(C, body_product(Z, body_difference(I, P)))
    assert body_product(B, P) == body_product(C, P)
    assert body_product(P, C) == body_product(C, P)
    assert body_product(P, V) == body_product(V, P)
    check_chain(chain(B, C, V, P), f"M_col={M}")
    # 対照
    assert broken(chain(Bf, C, V, P)) == [3, 9], broken(chain(Bf, C, V, P))
    Bc = body_sum(Cf, body_product(Z, body_difference(I, P)))      # BP = CP は保ち、C だけ ε と可換でない
    assert broken(chain(Bc, Cf, V, P)) == [4, 14], broken(chain(Bc, Cf, V, P))
    assert broken(chain(B, C, Vf, P)) == [7, 11], broken(chain(B, C, Vf, P))
    print(f"  M_col={M}: 16 等号が成り立つ。仮定を一つずつ外すと、その仮定を引く行だけが崩れる")
print("RESULT: PASS")
