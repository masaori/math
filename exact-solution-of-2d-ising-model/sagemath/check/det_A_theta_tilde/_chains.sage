# 対象ラベル: det_A_theta_tilde の証明の鎖を、本文の式どおりに一行ずつ有理関数として持つ（一般の点の検算と具体値の検算が共有する）。
# 各行は本文の式から別々に書き下し、前の行から写さない。各行に添えた関係の名前は、その行の (∵) が引く関係である
# （空なら ℂ の環の公理と ℝ の四則だけで前の行に等しい）。
Rg = PolynomialRing(QQ, 'I,EP,EM,C1,S1,C2,C2S,S2S,U,V,A0,G1,G2,G2M,A21,RR_,LP,LM,XX,YY')
I, EP, EM, C1, S1, C2, C2S, S2S, U, V, A0, G1, G2, G2M, A21, RR_, LP, LM, XX, YY = Rg.gens()
Fg = Rg.fraction_field()

# 行の (∵) が引く関係（多項式 = 0 の形）
REL = {
    'ii':        [I**2 + 1],                                   # 上の ii = -1_C
    'ee':        [EP * EM - 1],                                # 上の e_+e_- = 1_C
    'euler':     [2 * U - (EP + EM), 2 * I * V - (EP - EM)],   # euler_formula_cos_sin
    'uv':        [U**2 + V**2 - 1],                            # 上の u^2 + v^2 = 1_C
    'eminus':    [EM - (U - I * V)],                           # exp_of_negative_i_real_as_cos_minus_i_sin
    'upiv':      [U + I * V - EP],                             # 上の u + iv = e_+
    'a0':        [A0 - (C1 * U - S1 * C2)],                    # a_0 の定義
    'g1def':     [G1 - (C1 * C2S - S1 * S2S * U)],             # def_gamma1_gamma2_of_theta の γ_1
    'g2def':     [G2 - I * EP * S2S * (C1 * U - I * V - S1 * C2)],   # def_gamma1_gamma2_of_theta の γ_2
    'A21gamma':  [A21 + G2M],                                  # def_gamma1_gamma2_of_theta の (2,1) 成分 -γ_2(-θ)
    'A21def':    [A21 + I * EM * S2S * (C1 * U + I * V - S1 * C2)],  # def_A_theta の (2,1) 成分
    'g2form':    [G2 - I * EP * S2S * (A0 - I * V), G2M - I * EM * S2S * (A0 + I * V)],  # 上の γ_2(±θ) の表示
    'g2form_p':  [G2 - I * EP * S2S * (A0 - I * V)],           # 上の γ_2(θ) の表示
    'g2form_m':  [G2M - I * EM * S2S * (A0 + I * V)],          # 上の γ_2(-θ) の表示
    'g2prod':    [G2 * G2M + S2S**2 * (A0**2 + V**2)],         # 上の γ_2(θ)γ_2(-θ) の鎖
    'hyp_i':     [C1**2 - S1**2 - 1],                          # 上の c_1^2 - s_1^2 = 1
    'hyp_ii':    [C2S**2 - S2S**2 - 1],                        # 上の (c_2^*)^2 - (s_2^*)^2 = 1
    'hyp_iii':   [C2 * S2S - C2S],                             # 上の c_2 s_2^* = c_2^*
    'rel2':      [G2 * G2M + RR_**2],                          # relation_of_gamma_2_theta_tilde (2)
    'lam':       [LP - (G1 + RR_), LM - (G1 - RR_)],           # eigenvector_of_A_theta_tilde
    'second':    [G1**2 + G2 * G2M - 1],                       # 上の第 2 の等式の鎖
}

def L(e, *rels):
    return (Fg(e), list(rels))

# ---- 準備の第一: (x - iy)(x + iy)（13 個の等号）・(x - y)^2（15 個）・u + iv = e_+（19 個）・u^2 + v^2 = 1_C（5 個） ----
m1 = Fg(-1)   # -1_C
CH_conj = [
    L((XX - I * YY) * (XX + I * YY)),
    L((XX + (-(I * YY))) * (XX + I * YY)),
    L((XX + m1 * (I * YY)) * (XX + I * YY)),
    L(XX * XX + XX * (I * YY) + (m1 * (I * YY)) * XX + (m1 * (I * YY)) * (I * YY)),
    L(XX * XX + (I * YY) * XX + m1 * ((I * YY) * XX) + m1 * ((I * YY) * (I * YY))),
    L(XX * XX + ((I * YY) * XX + m1 * ((I * YY) * XX)) + m1 * ((I * YY) * (I * YY))),
    L(XX * XX + ((I * YY) * XX + (-((I * YY) * XX))) + m1 * ((I * YY) * (I * YY))),
    L(XX * XX + 0 + m1 * ((I * YY) * (I * YY))),
    L(XX * XX + m1 * ((I * YY) * (I * YY))),
    L(XX * XX + m1 * ((I * I) * (YY * YY))),
    L(XX * XX + m1 * (m1 * (YY * YY)), 'ii'),
    L(XX * XX + (-(-(YY * YY)))),
    L(XX * XX + YY * YY),
    L(XX**2 + YY**2),
]
CH_sq = [
    L((XX - YY)**2),
    L((XX - YY) * (XX - YY)),
    L((XX + (-YY)) * (XX + (-YY))),
    L((XX + m1 * YY) * (XX + m1 * YY)),
    L(XX * XX + XX * (m1 * YY) + (m1 * YY) * XX + (m1 * YY) * (m1 * YY)),
    L(XX * XX + m1 * (XX * YY) + m1 * (XX * YY) + (m1 * m1) * (YY * YY)),
    L(XX * XX + (m1 + m1) * (XX * YY) + (m1 * m1) * (YY * YY)),
    L(XX * XX + QQ((-1) + (-1)) * (XX * YY) + (m1 * m1) * (YY * YY)),
    L(XX * XX + QQ((-1) + (-1)) * (XX * YY) + QQ((-1) * (-1)) * (YY * YY)),
    L(XX * XX + QQ((-1) * 2) * (XX * YY) + 1 * (YY * YY)),
    L(XX * XX + (m1 * 2) * (XX * YY) + 1 * (YY * YY)),
    L(XX * XX + m1 * (2 * (XX * YY)) + 1 * (YY * YY)),
    L(XX * XX + m1 * (2 * (XX * YY)) + YY * YY),
    L(XX * XX + (-(2 * (XX * YY))) + YY * YY),
    L(XX * XX - 2 * (XX * YY) + YY * YY),
    L(XX**2 - 2 * (XX * YY) + YY**2),
]
h = Fg(1) / 2
CH_upiv = [
    L(U + I * V),
    L((EP + EM) / 2 + I * ((EP - EM) / (2 * I)), 'euler'),
    L((EP + EM) * h + I * ((EP - EM) * (1 / (2 * I)))),
    L((EP + EM) * h + (EP - EM) * (I * (1 / (2 * I)))),
    L((EP + EM) * h + (EP - EM) * (I * (h * (1 / I)))),
    L((EP + EM) * h + (EP - EM) * (h * (I * (1 / I)))),
    L((EP + EM) * h + (EP - EM) * (h * 1)),
    L((EP + EM) * h + (EP - EM) * h),
    L(((EP + EM) + (EP - EM)) * h),
    L(((EP + EM) + (EP + (-EM))) * h),
    L((EP + EP + (EM + (-EM))) * h),
    L((EP + EP + 0) * h),
    L((EP + EP) * h),
    L((1 * EP + 1 * EP) * h),
    L(((1 + 1) * EP) * h),
    L((QQ(1 + 1) * EP) * h),
    L((2 * EP) * h),
    L(EP * (2 * h)),
    L(EP * 1),
    L(EP),
]
CH_uv = [
    L(U**2 + V**2),
    L((U - I * V) * (U + I * V), 'ii'),        # 上の (x - iy)(x + iy) の鎖（ii を使う）を x = u, y = v で
    L(EM * (U + I * V), 'eminus'),
    L(EM * EP, 'upiv'),
    L(EP * EM),
    L(1, 'ee'),
]

# ---- 準備の第二: γ_2(θ)（3 個の等号）・γ_2(-θ)（9 個）・積（10 個） ----
CH_g2 = [
    L(G2),
    L(I * EP * S2S * (C1 * U - I * V - S1 * C2), 'g2def'),
    L(I * EP * S2S * ((C1 * U - S1 * C2) - I * V)),
    L(I * EP * S2S * (A0 - I * V), 'a0'),
]
CH_g2m = [
    L(G2M),
    L(-(-G2M)),
    L(-A21, 'A21gamma'),
    L(-((((-I) * EM) * S2S) * (C1 * U + I * V - S1 * C2)), 'A21def'),
    L(-(((-(I * EM)) * S2S) * (C1 * U + I * V - S1 * C2))),
    L(-((-((I * EM) * S2S)) * (C1 * U + I * V - S1 * C2))),
    L(-(-(((I * EM) * S2S) * (C1 * U + I * V - S1 * C2)))),
    L(I * EM * S2S * (C1 * U + I * V - S1 * C2)),
    L(I * EM * S2S * ((C1 * U - S1 * C2) + I * V)),
    L(I * EM * S2S * (A0 + I * V), 'a0'),
]
CH_prod = [
    L(G2 * G2M),
    L((I * EP * S2S * (A0 - I * V)) * G2M, 'g2form_p'),
    L((I * EP * S2S * (A0 - I * V)) * (I * EM * S2S * (A0 + I * V)), 'g2form_m'),
    L((I * I) * (EP * EM) * (S2S * S2S) * ((A0 - I * V) * (A0 + I * V))),
    L((-1) * (EP * EM) * (S2S * S2S) * ((A0 - I * V) * (A0 + I * V)), 'ii'),
    L((-1) * 1 * (S2S * S2S) * ((A0 - I * V) * (A0 + I * V)), 'ee'),
    L((-1) * (S2S * S2S) * ((A0 - I * V) * (A0 + I * V))),
    L((-1) * (S2S * S2S) * (A0**2 + V**2), 'ii'),           # 上の (x - iy)(x + iy) の鎖（ii を使う）を x = a_0, y = v で
    L((-1) * ((S2S * S2S) * (A0**2 + V**2))),
    L((-1) * (S2S**2 * (A0**2 + V**2))),
    L(-(S2S**2 * (A0**2 + V**2))),
]

# ---- 第 2 の等式 ----
T_ = C1 * C2S * S1 * S2S * U
P1 = C1**2 * C2S**2 - 2 * C1 * C2S * S1 * S2S * U + S1**2 * S2S**2 * U**2
CH_second = [
    L(G1**2 + G2 * G2M),
    L((C1 * C2S - S1 * S2S * U)**2 + G2 * G2M, 'g1def'),
    L((C1 * C2S - S1 * S2S * U)**2 + (-(S2S**2 * (A0**2 + V**2))), 'g2prod'),
    L((C1 * C2S - S1 * S2S * U)**2 - S2S**2 * (A0**2 + V**2)),
    L((C1 * C2S - S1 * S2S * U)**2 - S2S**2 * (A0**2 + (1 - U**2)), 'uv'),
    L((C1 * C2S - S1 * S2S * U)**2 - S2S**2 * (A0**2 + (1 + (-U**2)))),
    L((C1 * C2S - S1 * S2S * U)**2 - S2S**2 * ((A0**2 + 1) + (-U**2))),
    L((C1 * C2S - S1 * S2S * U)**2 - S2S**2 * (A0**2 + 1 - U**2)),
    L((C1 * C2S - S1 * S2S * U)**2 - S2S**2 * ((C1 * U - S1 * C2)**2 + 1 - U**2), 'a0'),
    L((C1 * C2S)**2 - 2 * ((C1 * C2S) * (S1 * S2S * U)) + (S1 * S2S * U)**2
      - S2S**2 * ((C1 * U)**2 - 2 * ((C1 * U) * (S1 * C2)) + (S1 * C2)**2 + 1 - U**2)),
    L((C1 * C2S) * (C1 * C2S) - 2 * ((C1 * C2S) * (S1 * S2S * U)) + (S1 * S2S * U) * (S1 * S2S * U)
      - (S2S * S2S) * ((C1 * U) * (C1 * U) - 2 * ((C1 * U) * (S1 * C2)) + (S1 * C2) * (S1 * C2) + 1 - U * U)),
    L((C1 * C1) * (C2S * C2S) - 2 * C1 * C2S * S1 * S2S * U + (S1 * S1) * (S2S * S2S) * (U * U)
      - (S2S * S2S) * ((C1 * C1) * (U * U) - 2 * C1 * S1 * C2 * U + (S1 * S1) * (C2 * C2) + 1 - U * U)),
    L(P1 - S2S**2 * (C1**2 * U**2 - 2 * C1 * S1 * C2 * U + S1**2 * C2**2 + 1 - U**2)),
    L(P1 + (-(S2S**2 * (C1**2 * U**2 - 2 * C1 * S1 * C2 * U + S1**2 * C2**2 + 1 - U**2)))),
    L(P1 + (-(S2S**2 * (C1**2 * U**2 + (-(2 * C1 * S1 * C2 * U)) + S1**2 * C2**2 + 1 + (-U**2))))),
    L(P1 + m1 * (S2S**2 * (C1**2 * U**2 + m1 * (2 * C1 * S1 * C2 * U) + S1**2 * C2**2 + 1 + m1 * U**2))),
    L(P1 + (m1 * (S2S**2 * (C1**2 * U**2)) + m1 * (S2S**2 * (m1 * (2 * C1 * S1 * C2 * U)))
      + m1 * (S2S**2 * (S1**2 * C2**2)) + m1 * (S2S**2 * 1) + m1 * (S2S**2 * (m1 * U**2)))),
    L(P1 + m1 * (S2S**2 * (C1**2 * U**2)) + m1 * (S2S**2 * (m1 * (2 * C1 * S1 * C2 * U)))
      + m1 * (S2S**2 * (S1**2 * C2**2)) + m1 * (S2S**2 * 1) + m1 * (S2S**2 * (m1 * U**2))),
    L(P1 + m1 * (C1**2 * S2S**2 * U**2) + (m1 * m1) * (2 * C1 * S1 * C2 * S2S**2 * U)
      + m1 * (S1**2 * C2**2 * S2S**2) + m1 * (S2S**2 * 1) + (m1 * m1) * (S2S**2 * U**2)),
    L(P1 + m1 * (C1**2 * S2S**2 * U**2) + (m1 * m1) * (2 * C1 * S1 * C2 * S2S**2 * U)
      + m1 * (S1**2 * C2**2 * S2S**2) + m1 * S2S**2 + (m1 * m1) * (S2S**2 * U**2)),
    L(P1 + m1 * (C1**2 * S2S**2 * U**2) + QQ((-1) * (-1)) * (2 * C1 * S1 * C2 * S2S**2 * U)
      + m1 * (S1**2 * C2**2 * S2S**2) + m1 * S2S**2 + QQ((-1) * (-1)) * (S2S**2 * U**2)),
    L(P1 + m1 * (C1**2 * S2S**2 * U**2) + 1 * (2 * C1 * S1 * C2 * S2S**2 * U)
      + m1 * (S1**2 * C2**2 * S2S**2) + m1 * S2S**2 + 1 * (S2S**2 * U**2)),
    L(P1 + m1 * (C1**2 * S2S**2 * U**2) + 2 * C1 * S1 * C2 * S2S**2 * U
      + m1 * (S1**2 * C2**2 * S2S**2) + m1 * S2S**2 + S2S**2 * U**2),
    L(P1 + (-(C1**2 * S2S**2 * U**2)) + 2 * C1 * S1 * C2 * S2S**2 * U + (-(S1**2 * C2**2 * S2S**2)) + (-S2S**2) + S2S**2 * U**2),
    L(P1 - C1**2 * S2S**2 * U**2 + 2 * C1 * S1 * C2 * S2S**2 * U - S1**2 * C2**2 * S2S**2 - S2S**2 + S2S**2 * U**2),
    L(P1 - C1**2 * S2S**2 * U**2 + 2 * C1 * S1 * C2 * (S2S * S2S) * U - S1**2 * (C2 * C2) * (S2S * S2S) - S2S**2 + S2S**2 * U**2),
    L(P1 - C1**2 * S2S**2 * U**2 + 2 * C1 * S1 * (C2 * S2S) * S2S * U - S1**2 * ((C2 * S2S) * (C2 * S2S)) - S2S**2 + S2S**2 * U**2),
    L(P1 - C1**2 * S2S**2 * U**2 + 2 * C1 * S1 * (C2 * S2S) * S2S * U - S1**2 * (C2 * S2S)**2 - S2S**2 + S2S**2 * U**2),
    L(P1 - C1**2 * S2S**2 * U**2 + 2 * C1 * S1 * C2S * S2S * U - S1**2 * C2S**2 - S2S**2 + S2S**2 * U**2, 'hyp_iii'),
    L(P1 - C1**2 * S2S**2 * U**2 + 2 * C1 * C2S * S1 * S2S * U - S1**2 * C2S**2 - S2S**2 + S2S**2 * U**2),
    # 以下、T := c_1c_2^*s_1s_2^*u、W := (s_2^*)^2u^2 の形のまま本文の行を写す
    L(C1**2 * C2S**2 + (-(2 * T_)) + S1**2 * S2S**2 * U**2 + (-(C1**2 * S2S**2 * U**2)) + 2 * T_
      + (-(S1**2 * C2S**2)) + (-S2S**2) + S2S**2 * U**2),
    L(C1**2 * C2S**2 + m1 * (2 * T_) + S1**2 * S2S**2 * U**2 + m1 * (C1**2 * S2S**2 * U**2) + 2 * T_
      + m1 * (S1**2 * C2S**2) + m1 * S2S**2 + S2S**2 * U**2),
    L(C1**2 * C2S**2 + (m1 * (2 * T_) + 2 * T_) + S1**2 * S2S**2 * U**2 + m1 * (C1**2 * S2S**2 * U**2)
      + m1 * (S1**2 * C2S**2) + m1 * S2S**2 + S2S**2 * U**2),
    L(C1**2 * C2S**2 + (-(2 * T_) + 2 * T_) + S1**2 * S2S**2 * U**2 + m1 * (C1**2 * S2S**2 * U**2)
      + m1 * (S1**2 * C2S**2) + m1 * S2S**2 + S2S**2 * U**2),
    L(C1**2 * C2S**2 + 0 + S1**2 * S2S**2 * U**2 + m1 * (C1**2 * S2S**2 * U**2)
      + m1 * (S1**2 * C2S**2) + m1 * S2S**2 + S2S**2 * U**2),
    L(C1**2 * C2S**2 + S1**2 * S2S**2 * U**2 + m1 * (C1**2 * S2S**2 * U**2)
      + m1 * (S1**2 * C2S**2) + m1 * S2S**2 + S2S**2 * U**2),
    L(C1**2 * C2S**2 + m1 * (S1**2 * C2S**2) + m1 * S2S**2
      + S1**2 * S2S**2 * U**2 + m1 * (C1**2 * S2S**2 * U**2) + S2S**2 * U**2),
    L(C1**2 * C2S**2 + m1 * (S1**2 * C2S**2) + m1 * S2S**2
      + S1**2 * S2S**2 * U**2 + m1 * (C1**2 * S2S**2 * U**2) + 1 * (S2S**2 * U**2)),
    L(C1**2 * C2S**2 + (m1 * S1**2) * C2S**2 + m1 * S2S**2
      + S1**2 * (S2S**2 * U**2) + (m1 * C1**2) * (S2S**2 * U**2) + 1 * (S2S**2 * U**2)),
    L(C1**2 * C2S**2 + (m1 * S1**2) * C2S**2 + m1 * S2S**2
      + (S1**2 * (S2S**2 * U**2) + (m1 * C1**2) * (S2S**2 * U**2) + 1 * (S2S**2 * U**2))),
    L((C1**2 + m1 * S1**2) * C2S**2 + m1 * S2S**2 + (S1**2 + m1 * C1**2 + 1) * (S2S**2 * U**2)),
    L((C1**2 + m1 * S1**2) * C2S**2 + m1 * S2S**2 + (m1 * C1**2 + S1**2 + 1) * (S2S**2 * U**2)),
    L((C1**2 + m1 * S1**2) * C2S**2 + m1 * S2S**2 + (m1 * C1**2 + 1 * S1**2 + 1) * (S2S**2 * U**2)),
    L((C1**2 + m1 * S1**2) * C2S**2 + m1 * S2S**2 + (m1 * C1**2 + QQ((-1) * (-1)) * S1**2 + 1) * (S2S**2 * U**2)),
    L((C1**2 + m1 * S1**2) * C2S**2 + m1 * S2S**2 + (m1 * C1**2 + (m1 * m1) * S1**2 + 1) * (S2S**2 * U**2)),
    L((C1**2 + m1 * S1**2) * C2S**2 + m1 * S2S**2 + (m1 * C1**2 + m1 * (m1 * S1**2) + 1) * (S2S**2 * U**2)),
    L((C1**2 + m1 * S1**2) * C2S**2 + m1 * S2S**2 + (m1 * (C1**2 + m1 * S1**2) + 1) * (S2S**2 * U**2)),
    L((C1**2 + (-S1**2)) * C2S**2 + m1 * S2S**2 + (m1 * (C1**2 + (-S1**2)) + 1) * (S2S**2 * U**2)),
    L((C1**2 - S1**2) * C2S**2 + m1 * S2S**2 + (m1 * (C1**2 - S1**2) + 1) * (S2S**2 * U**2)),
    L(1 * C2S**2 + m1 * S2S**2 + (m1 * 1 + 1) * (S2S**2 * U**2), 'hyp_i'),
    L(C2S**2 + m1 * S2S**2 + (m1 + 1) * (S2S**2 * U**2)),
    L(C2S**2 + m1 * S2S**2 + QQ((-1) + 1) * (S2S**2 * U**2)),
    L(C2S**2 + m1 * S2S**2 + 0 * (S2S**2 * U**2)),
    L(C2S**2 + m1 * S2S**2 + 0),
    L(C2S**2 + m1 * S2S**2),
    L(C2S**2 + (-S2S**2)),
    L(C2S**2 - S2S**2),
    L(1, 'hyp_ii'),
]

# ---- 第 1 の等式。第 1 行の行列は def_gamma1_gamma2_of_theta の A(θ) の形 ----
Agam = matrix(Fg, [[G1, G2], [-G2M, G1]])
def det_by_definition(B):
    """def_det_two_by_two の det B := B_11 B_22 - B_12 B_21。"""
    return B[0, 0] * B[1, 1] - B[0, 1] * B[1, 0]
Atheta = matrix(Fg, [[G1, G2], [A21, G1]])   # A(θ)。(2,1) 成分だけを別の記号に置く（(1,1)・(2,2)・(1,2) は γ の定義そのもの）
CH_det = [
    L(det_by_definition(Atheta)),
    L(det_by_definition(Agam), 'A21gamma'),
    L(G1 * G1 - G2 * (-G2M)),
    L(G1 * G1 + (-(G2 * (-G2M)))),
    L(G1 * G1 + (-1) * (G2 * ((-1) * G2M))),
    L(G1 * G1 + ((-1) * (-1)) * (G2 * G2M)),
    L(G1 * G1 + QQ((-1) * (-1)) * (G2 * G2M)),
    L(G1 * G1 + 1 * (G2 * G2M)),
    L(G1 * G1 + G2 * G2M),
    L(G1**2 + G2 * G2M),
    L(1, 'second'),
]

# ---- 第 3 の等式（ℂ の中） ----
CH_lam = [
    L(LP * LM),
    L(LP * LM),
    L((G1 + RR_) * (G1 - RR_), 'lam'),
    L((G1 + RR_) * (G1 - RR_)),
    L(G1 * G1 - G1 * RR_ + RR_ * G1 - RR_ * RR_),
    L(G1 * G1 - RR_ * G1 + RR_ * G1 - RR_ * RR_),
    L(G1 * G1 - RR_ * RR_),
    L(G1**2 - RR_**2),
    L(G1**2 + (-RR_**2)),
    L(G1**2 + G2 * G2M, 'rel2'),
    L(1, 'second'),
]

# ---- 最後の等式（ℂ の中） ----
CH_last = [
    L(G1**2),
    L(G1 * G1),
    L(G1 * G1),
    L(G1**2),
    L(G1**2 + 0),
    L(G1**2 + (-RR_**2 + RR_**2)),
    L(G1**2 + (G2 * G2M + RR_**2), 'rel2'),
    L((G1**2 + G2 * G2M) + RR_**2),
    L(1 + RR_**2, 'second'),
    L(1 + RR_ * RR_),
    L(1 + RR_ * RR_),
    L(1 + RR_ * RR_),
    L(1 + RR_**2),
]

CHAINS = [
    ("(x - iy)(x + iy) の鎖", CH_conj),
    ("(x - y)^2 の鎖", CH_sq),
    ("u + iv = e_+ の鎖", CH_upiv),
    ("u^2 + v^2 = 1_C の鎖", CH_uv),
    ("γ_2(θ) の表示の鎖", CH_g2),
    ("γ_2(-θ) の表示の鎖", CH_g2m),
    ("γ_2(θ)γ_2(-θ) の鎖", CH_prod),
    ("第 2 の等式の鎖", CH_second),
    ("第 1 の等式（det）の鎖", CH_det),
    ("第 3 の等式（λ_+λ_-）の ℂ の中の鎖", CH_lam),
    ("最後の等式の ℂ の中の鎖", CH_last),
]
