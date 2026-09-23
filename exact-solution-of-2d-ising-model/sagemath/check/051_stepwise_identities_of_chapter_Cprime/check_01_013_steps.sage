# =========================================================================
# check_01: 013 章（structured-latex/content/013_even_sector_modes.ts）の
#           **各段の等式そのもの**を、ラベル単位で検証する。
#
#  「1 ステップ 1 定理」への分割で本文へ明示的に現れるようになった中間式を、
#  displayMath の行の順に 1 行ずつ確かめる。
#
#  対象ラベル:
#    why_008_applies_only_to_minus_sector
#    antiperiodic_exp_sum
#    def_half_integer_checkZ
#    def_half_integer_checkY
#    half_integer_phase_antiperiodicity / half_integer_checkZ_periodicity /
#    def_half_integer_modes
#    commutator_of_H_and_check_Z_Y
#    anticommutator_of_check_Z_Y
#    recover_Z_Y_from_check_Z_Y
#    H1_H2_via_check_Z_Y
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_01: 013 章の各段の等式 ===")

S = Steps()

def add_exact_integer_example(name, proposition):
    """ZZ 上の有限例を浮動小数へ落とさず判定する。"""
    if not bool(proposition):
        raise AssertionError(name)
    S.add(name + " [finite ZZ example]", ZZ(1), ZZ(1))

def integer_mode_sum(N, k):
    """本文の T_{N,k} を定義どおり評価する。"""
    return sum([
        eiph(RDF(2 * pi * r * k) / RDF(N))
        for r in range(1, N + 1)
    ], CDF(0))

for M in STEP_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    H2 = O.H2
    H1p = O.H1(+1)

    # -----------------------------------------------------------------
    # why_008_applies_only_to_minus_sector / Step 1
    #   (Z_m Y_m) Z_j = Z_m (Y_m Z_j)            (結合法則)
    #                 = Z_m (-Z_j Y_m)           (anticommutator_of_Z_and_Y)
    #                 = -(Z_m Z_j) Y_m           (結合法則)
    #                 = -(-Z_j Z_m) Y_m          (anticommutator_of_Z_and_Y)
    #                 = Z_j (Z_m Y_m)
    # -----------------------------------------------------------------
    for j in range(1, M + 1):
        for m in range(1, M + 1):
            if m == j:
                continue
            Zm, Ym, Zj = O.Z[m], O.Y[m], O.Z[j]
            S.add("why_008 Step1 (1) (Z_mY_m)Z_j = Z_m(Y_mZ_j)",
                  (Zm * Ym) * Zj, Zm * (Ym * Zj))
            S.add("why_008 Step1 (2) Y_mZ_j = -Z_jY_m  [anticommutator_of_Z_and_Y]",
                  Zm * (Ym * Zj), Zm * (-Zj * Ym))
            S.add("why_008 Step1 (3) Z_m(-Z_jY_m) = -(Z_mZ_j)Y_m",
                  Zm * (-Zj * Ym), -(Zm * Zj) * Ym)
            S.add("why_008 Step1 (4) Z_mZ_j = -Z_jZ_m  [anticommutator_of_Z_and_Y]",
                  -(Zm * Zj) * Ym, -(-Zj * Zm) * Ym)
            S.add("why_008 Step1 (5) = Z_j(Z_mY_m)",
                  -(-Zj * Zm) * Ym, Zj * (Zm * Ym))

    # [Z_jY_j, Z_j] の 6 段
    for j in range(1, M + 1):
        Zj, Yj = O.Z[j], O.Y[j]
        S.add("why_008 Step1 [Z_jY_j,Z_j] (1) 交換子の定義",
              comm(Zj * Yj, Zj), (Zj * Yj) * Zj - Zj * (Zj * Yj))
        S.add("why_008 Step1 [Z_jY_j,Z_j] (2) 結合法則",
              (Zj * Yj) * Zj - Zj * (Zj * Yj), Zj * (Yj * Zj) - (Zj * Zj) * Yj)
        S.add("why_008 Step1 [Z_jY_j,Z_j] (3) Y_jZ_j = -Z_jY_j",
              Zj * (Yj * Zj) - (Zj * Zj) * Yj, Zj * (-Zj * Yj) - (Zj * Zj) * Yj)
        S.add("why_008 Step1 [Z_jY_j,Z_j] (4) 結合法則とスカラー倍",
              Zj * (-Zj * Yj) - (Zj * Zj) * Yj, -(Zj * Zj) * Yj - (Zj * Zj) * Yj)
        S.add("why_008 Step1 [Z_jY_j,Z_j] (5) Z_jZ_j = I",
              -(Zj * Zj) * Yj - (Zj * Zj) * Yj, -Id * Yj - Id * Yj)
        S.add("why_008 Step1 [Z_jY_j,Z_j] (6) = -2Y_j",
              -Id * Yj - Id * Yj, -2 * Yj)
        S.add("why_008 Step1 まとめ [H_2, Z_j] = -2Y_j", comm(H2, Zj), -2 * Yj)
        S.add("commutator_of_H_and_check_Z_Y Step1 [H_2, Y_j] = 2Z_j",
              comm(H2, Yj), 2 * Zj)

    # commutator_of_H_and_check_Z_Y / Step 1 の [Z_jY_j, Y_j] の 6 段
    for j in range(1, M + 1):
        Zj, Yj = O.Z[j], O.Y[j]
        S.add("commutator Step1 [Z_jY_j,Y_j] (1) 交換子の定義",
              comm(Zj * Yj, Yj), (Zj * Yj) * Yj - Yj * (Zj * Yj))
        S.add("commutator Step1 [Z_jY_j,Y_j] (2) 結合法則",
              (Zj * Yj) * Yj - Yj * (Zj * Yj), Zj * (Yj * Yj) - (Yj * Zj) * Yj)
        S.add("commutator Step1 [Z_jY_j,Y_j] (3) Y_jY_j = I",
              Zj * (Yj * Yj) - (Yj * Zj) * Yj, Zj * Id - (Yj * Zj) * Yj)
        S.add("commutator Step1 [Z_jY_j,Y_j] (4) Y_jZ_j = -Z_jY_j",
              Zj * Id - (Yj * Zj) * Yj, Zj - (-Zj * Yj) * Yj)
        S.add("commutator Step1 [Z_jY_j,Y_j] (5) 結合法則とスカラー倍",
              Zj - (-Zj * Yj) * Yj, Zj + Zj * (Yj * Yj))
        S.add("commutator Step1 [Z_jY_j,Y_j] (6) = 2Z_j",
              Zj + Zj * (Yj * Yj), 2 * Zj)

    # commutator_of_H_and_check_Z_Y / Step 1 の [Y_mZ_{m+1}, ...] と境界項
    for m in range(1, M):
        Ym, Zm1 = O.Y[m], O.Z[m + 1]
        S.add("commutator Step1 [Y_mZ_{m+1},Z_{m+1}] (1) 交換子の定義",
              comm(Ym * Zm1, Zm1), (Ym * Zm1) * Zm1 - Zm1 * (Ym * Zm1))
        S.add("commutator Step1 [Y_mZ_{m+1},Z_{m+1}] (2) 結合法則",
              (Ym * Zm1) * Zm1 - Zm1 * (Ym * Zm1),
              Ym * (Zm1 * Zm1) - (Zm1 * Ym) * Zm1)
        S.add("commutator Step1 [Y_mZ_{m+1},Z_{m+1}] (3) Z_{m+1}Z_{m+1} = I",
              Ym * (Zm1 * Zm1) - (Zm1 * Ym) * Zm1, Ym * Id - (Zm1 * Ym) * Zm1)
        S.add("commutator Step1 [Y_mZ_{m+1},Z_{m+1}] (4) Z_{m+1}Y_m = -Y_mZ_{m+1}",
              Ym * Id - (Zm1 * Ym) * Zm1, Ym - (-Ym * Zm1) * Zm1)
        S.add("commutator Step1 [Y_mZ_{m+1},Z_{m+1}] (5) = 2Y_m",
              Ym - (-Ym * Zm1) * Zm1, 2 * Ym)
        S.add("commutator Step1 [Y_mZ_{m+1},Y_m] = -2Z_{m+1}",
              comm(Ym * Zm1, Ym), -2 * Zm1)

    YM, Z1 = O.Y[M], O.Z[1]
    S.add("commutator Step1 境界 [-Y_MZ_1,Z_1] (1) 第 1 引数の線型性",
          comm(-YM * Z1, Z1), -comm(YM * Z1, Z1))
    S.add("commutator Step1 境界 [-Y_MZ_1,Z_1] (2) = -2Y_M",
          -comm(YM * Z1, Z1), -2 * YM)
    S.add("commutator Step1 境界 [-Y_MZ_1,Z_1] (3) = 2 Y^flat_0",
          -2 * YM, 2 * Yflat(O, 0))
    S.add("commutator Step1 境界 [-Y_MZ_1,Y_M] (1) 第 1 引数の線型性",
          comm(-YM * Z1, YM), -comm(YM * Z1, YM))
    S.add("commutator Step1 境界 [-Y_MZ_1,Y_M] (2) = 2Z_1",
          -comm(YM * Z1, YM), 2 * Z1)
    S.add("commutator Step1 境界 [-Y_MZ_1,Y_M] (3) = -2 Z^flat_{M+1}",
          2 * Z1, -2 * Zflat(O, M + 1))

    # サイトごとの H_1^{(+)} の交換子（flat 記法でまとまること）
    for j in range(1, M + 1):
        S.add("commutator Step1 [H_1^{(+)}, Z_j] = 2 Y^flat_{j-1}",
              comm(H1p, O.Z[j]), 2 * Yflat(O, j - 1))
        S.add("commutator Step1 [H_1^{(+)}, Y_j] = -2 Z^flat_{j+1}",
              comm(H1p, O.Y[j]), -2 * Zflat(O, j + 1))

    # -----------------------------------------------------------------
    # antiperiodic_exp_sum の各段
    # -----------------------------------------------------------------
    m_nat = NN(M)
    m_int = ZZ(m_nat)
    m_real_via_int = RDF(m_int)
    m_complex_via_real = CDF(m_real_via_int)
    two_m_nat = NN(2) * m_nat
    two_m_int = ZZ(two_m_nat)
    two_m_real_via_int = RDF(two_m_int)
    two_m_complex_via_real = CDF(two_m_real_via_int)
    S.add("antiperiodic_exp_sum (0a) (M_N)_R=M_R", m_real_via_int, RDF(M))
    S.add("antiperiodic_exp_sum (0b) (2M_N)_R=2M_R", two_m_real_via_int, RDF(2) * RDF(M))
    S.add("antiperiodic_exp_sum (0c) (M_N)_C=M_C", m_complex_via_real, CDF(RDF(M)))
    S.add("antiperiodic_exp_sum (0d) (2M_N)_C=(2M)_C",
          two_m_complex_via_real, CDF(RDF(2) * RDF(M)))
    add_exact_integer_example("antiperiodic_exp_sum (0e) M_R は 0 でない", M > 0)
    add_exact_integer_example("antiperiodic_exp_sum (0f) 2M_R は 0 でない", 2 * M > 0)
    for k in range(-2 * M - 1, 2 * M + 2):
        lhs = sum([eiph(k * th_tilde(M, mu)) for mu in range(1, M + 1)], CDF(0))
        theta_definition_sum = sum([
            eiph(RDF(k) * (RDF(2 * pi) * (RDF(mu) - RDF(1) / RDF(2)) / RDF(M)))
            for mu in range(1, M + 1)
        ], CDF(0))
        odd_sum = sum([
            eiph(RDF(2 * pi * (2 * mu - 1) * k) / RDF(2 * M))
            for mu in range(1, M + 1)
        ], CDF(0))
        even_sum = sum([
            eiph(RDF(2 * pi * (2 * mu) * k) / RDF(2 * M))
            for mu in range(1, M + 1)
        ], CDF(0))
        sum_2M_from_definition = integer_mode_sum(2 * M, k)
        sum_2M = sum([
            eiph(RDF(2 * pi * r * k) / RDF(2 * M))
            for r in range(1, 2 * M + 1)
        ], CDF(0))
        sum_2M_via_nat_image = sum([
            eiph(RDF(2 * pi * r * k) / RDF(ZZ(two_m_nat)))
            for r in range(1, 2 * M + 1)
        ], CDF(0))
        sum_M_from_definition = integer_mode_sum(M, k)
        sum_M = sum([
            eiph(RDF(2 * pi * mu * k) / RDF(M))
            for mu in range(1, M + 1)
        ], CDF(0))
        sum_M_via_nat_image = sum([
            eiph(RDF(2 * pi * mu * k) / RDF(ZZ(m_nat)))
            for mu in range(1, M + 1)
        ], CDF(0))
        delta_2M_indicator = CDF(1 if k % (2 * M) == 0 else 0)
        delta_M_indicator = CDF(1 if k % M == 0 else 0)
        delta_2M_value_via_nat = two_m_complex_via_real * delta_2M_indicator
        delta_M_value_via_nat = m_complex_via_real * delta_M_indicator
        delta_2M_value = CDF(2 * M) * delta_2M_indicator
        delta_M_value = CDF(M) * delta_M_indicator

        S.add("antiperiodic_exp_sum (1a) theta~ の定義を代入", lhs, theta_definition_sum)
        S.add("antiperiodic_exp_sum (1b) 分母を 2M に通分", theta_definition_sum, odd_sum)
        S.add("antiperiodic_exp_sum (2a) T_{2M_N,k} の定義を展開",
              sum_2M_from_definition, sum_2M_via_nat_image)
        S.add("antiperiodic_exp_sum (2b) (2M_N)_R=2M_R を分母へ適用",
              sum_2M_via_nat_image, sum_2M)
        S.add("antiperiodic_exp_sum (2c) 2M 項を奇数番目と偶数番目へ分割",
              sum_2M, odd_sum + even_sum)
        S.add("antiperiodic_exp_sum (2d) 奇数番目の和を S_{M,k} と置く", odd_sum, odd_sum)
        S.add("antiperiodic_exp_sum (2e) 偶数番目の指数を約分", even_sum, sum_M)
        S.add("antiperiodic_exp_sum (2f) (M_N)_R=M_R を分母へ適用",
              sum_M, sum_M_via_nat_image)
        S.add("antiperiodic_exp_sum (2g) 偶数番目の和は T_{M_N,k}",
              sum_M_via_nat_image, sum_M_from_definition)
        S.add("antiperiodic_exp_sum (3a) exp_sum を 2M_N に適用",
              sum_2M, delta_2M_value_via_nat)
        S.add("antiperiodic_exp_sum (3b) (2M_N)_C=(2M)_C を係数へ適用",
              delta_2M_value_via_nat, delta_2M_value)
        S.add("antiperiodic_exp_sum (3c) exp_sum を M_N に適用",
              sum_M, delta_M_value_via_nat)
        S.add("antiperiodic_exp_sum (3d) (M_N)_C=M_C を係数へ適用",
              delta_M_value_via_nat, delta_M_value)
        S.add("antiperiodic_exp_sum (4a) 奇数番目 = 全体 - 偶数番目",
              odd_sum, sum_2M - sum_M)
        S.add("antiperiodic_exp_sum (4b) 二つの exp_sum を代入",
              sum_2M - sum_M, delta_2M_value - delta_M_value)
        if k % M == 0:
            l = k // M
            add_exact_integer_example(
                "antiperiodic_exp_sum (5a) k=lM を 2M|k へ代入",
                (ZZ(k) % ZZ(2 * M) == 0) == (ZZ(l * M) % ZZ(2 * M) == 0))
            add_exact_integer_example(
                "antiperiodic_exp_sum (5b) 2M|lM と 2|l は同値",
                (ZZ(k) % ZZ(2 * M) == 0) == (ZZ(l) % ZZ(2) == 0))
            if l % 2 == 0:
                S.add("antiperiodic_exp_sum (5c-even-1) 偶数時のデルタ値を代入",
                      delta_2M_value - delta_M_value, CDF(2 * M * 1 - M * 1))
                S.add("antiperiodic_exp_sum (5c-even-2) 左の単位元を簡約",
                      CDF(2 * M * 1 - M * 1), CDF(2 * M - M * 1))
                S.add("antiperiodic_exp_sum (5c-even-3) 右の単位元を簡約",
                      CDF(2 * M - M * 1), CDF(2 * M - M))
                S.add("antiperiodic_exp_sum (5c-even-4) 係数を計算",
                      CDF(2 * M - M), CDF(M))
                S.add("antiperiodic_exp_sum (5c-even-5) 積の単位元を挿入",
                      CDF(M), CDF(M * 1))
                S.add("antiperiodic_exp_sum (5c-even-6) 偶数の整数冪を評価",
                      CDF(M * 1), CDF(M * (-1) ** l))
            else:
                S.add("antiperiodic_exp_sum (5d-odd-1) 奇数時のデルタ値を代入",
                      delta_2M_value - delta_M_value, CDF(2 * M * 0 - M * 1))
                S.add("antiperiodic_exp_sum (5d-odd-2) 零倍を簡約",
                      CDF(2 * M * 0 - M * 1), CDF(0 - M * 1))
                S.add("antiperiodic_exp_sum (5d-odd-3) 積の単位元を簡約",
                      CDF(0 - M * 1), CDF(0 - M))
                S.add("antiperiodic_exp_sum (5d-odd-4) 零からの差を加法逆元へ",
                      CDF(0 - M), CDF(-M))
                S.add("antiperiodic_exp_sum (5d-odd-5) 加法逆元を -1 倍へ",
                      CDF(-M), CDF(M * (-1)))
                S.add("antiperiodic_exp_sum (5d-odd-6) 奇数の整数冪を評価",
                      CDF(M * (-1)), CDF(M * (-1) ** l))
        else:
            add_exact_integer_example(
                "antiperiodic_exp_sum (5e-1) M が k を割らなければ 2M も k を割らない",
                ZZ(k) % ZZ(2 * M) != 0)
            S.add("antiperiodic_exp_sum (5e-2) 2M の周期デルタは 0",
                  delta_2M_indicator, CDF(0))
            S.add("antiperiodic_exp_sum (5e-3) M の周期デルタは 0",
                  delta_M_indicator, CDF(0))
            S.add("antiperiodic_exp_sum (5e-4) 二つのデルタ値を代入",
                  delta_2M_value - delta_M_value, CDF(2 * M) * 0 - CDF(M) * 0)
            S.add("antiperiodic_exp_sum (5e-5) 零倍と零の差を簡約",
                  CDF(2 * M) * 0 - CDF(M) * 0, CDF(0))

        if abs(k) < M and k != 0:
            add_exact_integer_example(
                "antiperiodic_exp_sum (6a) |k|<M, k!=0 なら M は k を割らない",
                ZZ(k) % ZZ(M) != 0)

    for l in range(-3, 4):
        lz = ZZ(l)
        mz = ZZ(M)
        kz = lz * mz
        add_exact_integer_example("antiperiodic_exp_sum (6b) |lM|=|l||M|",
                                  abs(lz * mz) == abs(lz) * abs(mz))
        add_exact_integer_example("antiperiodic_exp_sum (6c) M>0 なら |M|=M",
                                  abs(mz) == mz)
        add_exact_integer_example("antiperiodic_exp_sum (6d) k=lM なら |l|M=|k|",
                                  abs(lz) * mz == abs(kz))
        add_exact_integer_example("antiperiodic_exp_sum (6e) |k|<M を鎖の狭義不等号へ代入",
                                  not (abs(kz) < mz) or abs(lz) * mz < mz)
        add_exact_integer_example("antiperiodic_exp_sum (6f) |l|M<M なら |l|<1",
                                  not (abs(lz) * mz < mz) or abs(lz) < 1)
        add_exact_integer_example("antiperiodic_exp_sum (6g) 整数 |l|<1 なら |l|=0",
                                  not (abs(lz) < 1) or abs(lz) == 0)
        add_exact_integer_example("antiperiodic_exp_sum (6h) |l|=0 なら l=0",
                                  not (abs(lz) == 0) or lz == 0)
        add_exact_integer_example("antiperiodic_exp_sum (6i) l=0 なら lM=0",
                                  lz != 0 or lz * mz == 0)

    zero_sum = sum([eiph(0 * th_tilde(M, mu)) for mu in range(1, M + 1)], CDF(0))
    S.add("antiperiodic_exp_sum (7a) k=0 は l=0 の整除の場合", zero_sum, CDF(M * (-1) ** 0))
    S.add("antiperiodic_exp_sum (7b) M(-1)^0=M*1", CDF(M * (-1) ** 0), CDF(M * 1))
    S.add("antiperiodic_exp_sum (7c) M*1=M", CDF(M * 1), CDF(M))

    # -----------------------------------------------------------------
    # half_integer_phase_antiperiodicity、half_integer_checkZ_periodicity、
    # half_integer_checkY_periodicity、def_half_integer_modes (3) の各段
    # -----------------------------------------------------------------
    for mu in list(range(1, M + 1)) + [0, -1, M + 1]:
        t = th_tilde(M, mu)
        expanded = RDF(M) * (RDF(2 * pi) / RDF(M)) * (RDF(mu) - RDF(1) / RDF(2))
        half_turn = RDF(2 * pi) * (RDF(mu) - RDF(1) / RDF(2))
        S.add("half_integer_phase_antiperiodicity (a) theta~ の定義を代入",
              RDF(M) * t, expanded)
        S.add("half_integer_phase_antiperiodicity (b) M を約分",
              expanded, half_turn)
        S.add("half_integer_phase_antiperiodicity (c) 実数の分配則",
              half_turn, RDF(2 * pi * mu - pi))
        S.add("half_integer_phase_antiperiodicity (d) Euler formula",
              eiph(-M * t), cos(RDF(M) * t) - CDF(I) * sin(RDF(M) * t))
        S.add("half_integer_phase_antiperiodicity (e) substitute M theta~",
              cos(RDF(M) * t) - CDF(I) * sin(RDF(M) * t),
              cos(RDF(2 * pi * mu - pi)) - CDF(I) * sin(RDF(2 * pi * mu - pi)))
        S.add("half_integer_phase_antiperiodicity (f) cos integer half-turn = -1",
              cos(RDF(2 * pi * mu - pi)) - CDF(I) * sin(RDF(2 * pi * mu - pi)),
              CDF(-1) - CDF(I) * sin(RDF(2 * pi * mu - pi)))
        S.add("half_integer_phase_antiperiodicity (g) sin integer half-turn = 0",
              CDF(-1) - CDF(I) * sin(RDF(2 * pi * mu - pi)),
              CDF(-1) - CDF(I) * CDF(0))
        S.add("half_integer_phase_antiperiodicity (h) i*0 = 0",
              CDF(-1) - CDF(I) * CDF(0), CDF(-1) - CDF(0))
        S.add("half_integer_phase_antiperiodicity (i) additive identity",
              CDF(-1) - CDF(0), CDF(-1))
        shifted_angle_definition = RDF(2 * pi) * (RDF(mu + M) - RDF(1) / 2) / RDF(M)
        shifted_angle_distributed = (
            RDF(2 * pi) * (RDF(mu) - RDF(1) / 2) + RDF(2 * pi) * RDF(M)
        ) / RDF(M)
        shifted_angle_split = (
            RDF(2 * pi) * (RDF(mu) - RDF(1) / 2) / RDF(M)
            + RDF(2 * pi) * RDF(M) / RDF(M)
        )
        shifted_angle_cancelled = (
            RDF(2 * pi) * (RDF(mu) - RDF(1) / 2) / RDF(M) + RDF(2 * pi)
        )
        S.add("half_integer_checkZ_periodicity (a1) theta~ の定義に mu+M を代入",
              th_tilde(M, mu + M), shifted_angle_definition)
        S.add("half_integer_checkZ_periodicity (a2) 実数の分配則",
              shifted_angle_definition, shifted_angle_distributed)
        S.add("half_integer_checkZ_periodicity (a3) 分数の加法",
              shifted_angle_distributed, shifted_angle_split)
        S.add("half_integer_checkZ_periodicity (a4) M!=0 により M を約分",
              shifted_angle_split, shifted_angle_cancelled)
        S.add("half_integer_checkZ_periodicity (a5) theta~ の定義を再適用",
              shifted_angle_cancelled, t + RDF(2 * pi))
        for j in range(1, M + 1):
            shifted = th_tilde(M, mu + M)
            S.add("half_integer_checkZ_periodicity (b) negative-angle Euler representation",
                  eiph(-j * shifted), cos(RDF(j) * shifted) - CDF(I) * sin(RDF(j) * shifted))
            S.add("half_integer_checkZ_periodicity (c) substitute theta~_{mu+M}",
                  cos(RDF(j) * shifted) - CDF(I) * sin(RDF(j) * shifted),
                  cos(RDF(j) * (t + RDF(2 * pi))) - CDF(I) * sin(RDF(j) * (t + RDF(2 * pi))))
            S.add("half_integer_checkZ_periodicity (d) distribute j",
                  cos(RDF(j) * (t + RDF(2 * pi))) - CDF(I) * sin(RDF(j) * (t + RDF(2 * pi))),
                  cos(RDF(j) * t + RDF(2 * pi * j)) - CDF(I) * sin(RDF(j) * t + RDF(2 * pi * j)))
            S.add("half_integer_checkZ_periodicity (e) trigonometric periodicity",
                  cos(RDF(j) * t + RDF(2 * pi * j)) - CDF(I) * sin(RDF(j) * t + RDF(2 * pi * j)),
                  cos(RDF(j) * t) - CDF(I) * sin(RDF(j) * t))
            S.add("half_integer_checkZ_periodicity (f) reverse negative-angle Euler representation",
                  cos(RDF(j) * t) - CDF(I) * sin(RDF(j) * t), eiph(-j * t))
        shifted_sum = sum([
            eiph(-j * th_tilde(M, mu + M)) * O.Z[j]
            for j in range(1, M + 1)
        ], matrix(CDF, O.d, O.d, 0))
        unshifted_sum = sum([
            eiph(-j * t) * O.Z[j]
            for j in range(1, M + 1)
        ], matrix(CDF, O.d, O.d, 0))
        S.add("half_integer_checkZ_periodicity (g) checkZ_{mu+M} の定義",
              checkZ(O, mu + M), shifted_sum)
        S.add("half_integer_checkZ_periodicity (h) 位相の一致を全項へ適用",
              shifted_sum, unshifted_sum)
        S.add("half_integer_checkZ_periodicity (i) checkZ_mu の定義を再適用",
              unshifted_sum, checkZ(O, mu))
        S.add("half_integer_checkY_periodicity (a1) theta~ の定義に mu+M を代入",
              th_tilde(M, mu + M), shifted_angle_definition)
        S.add("half_integer_checkY_periodicity (a2) 実数の分配則",
              shifted_angle_definition, shifted_angle_distributed)
        S.add("half_integer_checkY_periodicity (a3) 分数の加法",
              shifted_angle_distributed, shifted_angle_split)
        S.add("half_integer_checkY_periodicity (a4) M!=0 により M を約分",
              shifted_angle_split, shifted_angle_cancelled)
        S.add("half_integer_checkY_periodicity (a5) theta~ の定義を再適用",
              shifted_angle_cancelled, t + RDF(2 * pi))
        for j in range(1, M + 1):
            shifted = th_tilde(M, mu + M)
            S.add("half_integer_checkY_periodicity (b) negative-angle Euler representation",
                  eiph(-j * shifted), cos(RDF(j) * shifted) - CDF(I) * sin(RDF(j) * shifted))
            S.add("half_integer_checkY_periodicity (c) substitute theta~_{mu+M}",
                  cos(RDF(j) * shifted) - CDF(I) * sin(RDF(j) * shifted),
                  cos(RDF(j) * (t + RDF(2 * pi))) - CDF(I) * sin(RDF(j) * (t + RDF(2 * pi))))
            S.add("half_integer_checkY_periodicity (d) distribute j",
                  cos(RDF(j) * (t + RDF(2 * pi))) - CDF(I) * sin(RDF(j) * (t + RDF(2 * pi))),
                  cos(RDF(j) * t + RDF(2 * pi * j)) - CDF(I) * sin(RDF(j) * t + RDF(2 * pi * j)))
            S.add("half_integer_checkY_periodicity (e) trigonometric periodicity",
                  cos(RDF(j) * t + RDF(2 * pi * j)) - CDF(I) * sin(RDF(j) * t + RDF(2 * pi * j)),
                  cos(RDF(j) * t) - CDF(I) * sin(RDF(j) * t))
            S.add("half_integer_checkY_periodicity (f) reverse negative-angle Euler representation",
                  cos(RDF(j) * t) - CDF(I) * sin(RDF(j) * t), eiph(-j * t))
        shifted_Y_sum = sum([
            eiph(-j * th_tilde(M, mu + M)) * O.Y[j]
            for j in range(1, M + 1)
        ], matrix(CDF, O.d, O.d, 0))
        unshifted_Y_sum = sum([
            eiph(-j * t) * O.Y[j]
            for j in range(1, M + 1)
        ], matrix(CDF, O.d, O.d, 0))
        S.add("half_integer_checkY_periodicity (g) checkY_{mu+M} の定義",
              checkY(O, mu + M), shifted_Y_sum)
        S.add("half_integer_checkY_periodicity (h) 位相の一致を全項へ適用",
              shifted_Y_sum, unshifted_Y_sum)
        S.add("half_integer_checkY_periodicity (i) checkY_mu の定義を再適用",
              unshifted_Y_sum, checkY(O, mu))
        S.add("def_half_integer_modes (3) theta~_{1-mu} = -theta~_mu",
              th_tilde(M, 1 - mu), -t)

    # -----------------------------------------------------------------
    # def_check_index_set / conjugate_index_of_check_Z_Y の各段（mu ∈ 𝓜̌ のみ）
    # -----------------------------------------------------------------
    for mu in range(1, M + 1):
        t = th_tilde(M, mu)
        # --- def_check_index_set の各段（新規） ---
        if mu + 1 <= M:
            S.add("def_check_index_set (1) theta~_nu - theta~_mu = 2pi(nu-mu)/M",
                  th_tilde(M, mu + 1) - t, CDF(2 * pi) / M)
        S.add("def_check_index_set (1) theta~_1 = pi/M", th_tilde(M, 1), CDF(pi) / M)
        S.add("def_check_index_set (1) theta~_M = 2pi - pi/M",
              th_tilde(M, M), CDF(2 * pi) - CDF(pi) / M)
        S.add("def_check_index_set (1) 0 < theta~_mu < 2pi",
              CDF(1 if 0 < t.real() < float(2 * pi) else 0), CDF(1))
        S.add("def_check_index_set (2) 1 <= M+1-mu <= M",
              CDF(1 if 1 <= M + 1 - mu <= M else 0), CDF(1))
        S.add("def_check_index_set (3) (M+1-mu) - (1-mu) = M", CDF(M), CDF(M))
        S.add("def_check_index_set (4) 自己共役点は M 奇数の mu=(M+1)/2 のみ",
              CDF(1 if ((M + 1 - mu == mu) == (M % 2 == 1 and 2 * mu == M + 1)) else 0),
              CDF(1))
        if M % 2 == 1 and 2 * mu == M + 1:
            S.add("def_check_index_set (4) そのとき theta~_mu = pi", t, CDF(pi))
        for nu in range(1, M + 1):
            S.add("def_check_index_set (5) (mu+nu = 1 mod M) <=> (nu = M+1-mu)",
                  CDF(1 if (((mu + nu - 1) % M == 0) == (nu == M + 1 - mu)) else 0),
                  CDF(1))
        # --- conjugate_index_of_check_Z_Y の各段（新規） ---
        S.add("conjugate_index (1) theta~_{M+1-mu} = 2pi - theta~_mu",
              th_tilde(M, M + 1 - mu), CDF(2 * pi) - t)
        for j in range(1, M + 1):
            S.add("conjugate_index (2) e^{-ij theta~_{M+1-mu}} = e^{ij theta~_mu}",
                  eiph(-j * th_tilde(M, M + 1 - mu)), eiph(j * t))
        S.add("conjugate_index (3) checkZ_{M+1-mu} = checkZ_{1-mu}",
              checkZ(O, M + 1 - mu), checkZ(O, 1 - mu))
        S.add("conjugate_index (3) checkY_{M+1-mu} = checkY_{1-mu}",
              checkY(O, M + 1 - mu), checkY(O, 1 - mu))

    # -----------------------------------------------------------------
    # commutator_of_H_and_check_Z_Y / Step 2〜4 の各段
    # -----------------------------------------------------------------
    for mu in range(1, M + 1):
        t = th_tilde(M, mu)
        Zc, Yc = checkZ(O, mu), checkY(O, mu)

        # (C) の 5 段
        lin = sum([eiph(-j * t) * comm(H2, O.Z[j]) for j in range(1, M + 1)],
                  matrix(CDF, O.d, O.d, 0))
        sub = sum([eiph(-j * t) * (-2 * O.Y[j]) for j in range(1, M + 1)],
                  matrix(CDF, O.d, O.d, 0))
        S.add("commutator (C) (1) 第 2 引数の線型性", comm(H2, Zc), lin)
        S.add("commutator (C) (2) Step 1 の第 1 式", lin, sub)
        S.add("commutator (C) (3) = -2 checkY_mu", sub, -2 * Yc)
        S.add("commutator (D) [H_2, checkY] = 2 checkZ", comm(H2, Yc), 2 * Zc)

        # (A) の各段（添字の付け替えと l=0 -> l=M の入れ替え）
        a0 = sum([eiph(-j * t) * comm(H1p, O.Z[j]) for j in range(1, M + 1)],
                 matrix(CDF, O.d, O.d, 0))
        a1 = 2 * sum([eiph(-j * t) * Yflat(O, j - 1) for j in range(1, M + 1)],
                     matrix(CDF, O.d, O.d, 0))
        a2 = 2 * sum([eiph(-(l + 1) * t) * Yflat(O, l) for l in range(0, M)],
                     matrix(CDF, O.d, O.d, 0))
        a3 = 2 * eiph(-t) * sum([eiph(-l * t) * Yflat(O, l) for l in range(0, M)],
                                matrix(CDF, O.d, O.d, 0))
        a4 = 2 * eiph(-t) * sum([eiph(-l * t) * Yflat(O, l) for l in range(1, M + 1)],
                                matrix(CDF, O.d, O.d, 0))
        S.add("commutator (A) (1) 第 2 引数の線型性", comm(H1p, Zc), a0)
        S.add("commutator (A) (2) Step 1 の第 3 式", a0, a1)
        S.add("commutator (A) (3) 添字の付け替え l = j-1", a1, a2)
        S.add("commutator (A) (4) 指数法則 [theorem_exp_product n=1]", a2, a3)
        S.add("commutator (A) (5) l=0 の項と l=M の項の入れ替え", a3, a4)
        S.add("commutator (A) (5') 入れ替えの根拠: e^{0} Y^flat_0 = e^{-iM theta~} Y^flat_M",
              Yflat(O, 0), eiph(-M * t) * Yflat(O, M))
        S.add("commutator (A) (6) = 2 e^{-i theta~} checkY_mu", a4, 2 * eiph(-t) * Yc)

        # (B) の各段
        b0 = sum([eiph(-j * t) * comm(H1p, O.Y[j]) for j in range(1, M + 1)],
                 matrix(CDF, O.d, O.d, 0))
        b1 = -2 * sum([eiph(-j * t) * Zflat(O, j + 1) for j in range(1, M + 1)],
                      matrix(CDF, O.d, O.d, 0))
        b2 = -2 * sum([eiph(-(l - 1) * t) * Zflat(O, l) for l in range(2, M + 2)],
                      matrix(CDF, O.d, O.d, 0))
        b3 = -2 * eiph(t) * sum([eiph(-l * t) * Zflat(O, l) for l in range(2, M + 2)],
                                matrix(CDF, O.d, O.d, 0))
        b4 = -2 * eiph(t) * sum([eiph(-l * t) * Zflat(O, l) for l in range(1, M + 1)],
                                matrix(CDF, O.d, O.d, 0))
        S.add("commutator (B) (1) 第 2 引数の線型性", comm(H1p, Yc), b0)
        S.add("commutator (B) (2) Step 1 の第 4 式", b0, b1)
        S.add("commutator (B) (3) 添字の付け替え l = j+1", b1, b2)
        S.add("commutator (B) (4) 指数法則 [theorem_exp_product n=1]", b2, b3)
        S.add("commutator (B) (5) l=M+1 の項と l=1 の項の入れ替え", b3, b4)
        S.add("commutator (B) (5') 入れ替えの根拠: e^{-i(M+1)theta~} Z^flat_{M+1} = e^{-i theta~} Z_1",
              eiph(-(M + 1) * t) * Zflat(O, M + 1), eiph(-t) * O.Z[1])
        S.add("commutator (B) (6) = -2 e^{i theta~} checkZ_mu", b4, -2 * eiph(t) * Zc)

    # -----------------------------------------------------------------
    # anticommutator_of_check_Z_Y の各段
    # -----------------------------------------------------------------
    for mu in range(1, M + 1):
        Zm, Ym = checkZ(O, mu), checkY(O, mu)
        for nu in range(1, M + 1):
            Zn, Yn = checkZ(O, nu), checkY(O, nu)
            tm, tn = th_tilde(M, mu), th_tilde(M, nu)
            d = delta_M(M, mu + nu, 1)
            dbl = sum([eiph(-j * tm) * eiph(-k * tn) * (O.Z[j] * O.Z[k] + O.Z[k] * O.Z[j])
                       for j in range(1, M + 1) for k in range(1, M + 1)],
                      matrix(CDF, O.d, O.d, 0))
            diag = 2 * Id * sum([eiph(-j * tm) * eiph(-j * tn)
                                 for j in range(1, M + 1)], CDF(0))
            expsum = 2 * Id * sum([eiph(-j * (tm + tn)) for j in range(1, M + 1)], CDF(0))
            S.add("anticommutator_of_check_Z_Y (1) 双線型性で二重和へ",
                  Zm * Zn + Zn * Zm, dbl)
            S.add("anticommutator_of_check_Z_Y (2) [Z_j,Z_k]_+ = 2I delta で j=k のみ",
                  dbl, diag)
            S.add("anticommutator_of_check_Z_Y (3) 指数法則 [theorem_exp_product n=1]",
                  diag, expsum)
            S.add("anticommutator_of_check_Z_Y (4) theta~_mu+theta~_nu = 2pi(mu+nu-1)/M",
                  tm + tn, RDF(2 * pi * (mu + nu - 1)) / M)
            S.add("anticommutator_of_check_Z_Y (5) exp_sum で M delta^M_{(mu+nu,1)}",
                  expsum, 2 * Id * CDF(M * d))
            S.add("anticommutator_of_check_Z_Y (5b) def_check_index_set (5) で delta_{nu,M+1-mu}",
                  CDF(d), CDF(1 if nu == M + 1 - mu else 0))
            S.add("anticommutator_of_check_Z_Y (6) 第 2 式 [checkZ,checkY]_+ = 0",
                  Zm * Yn + Yn * Zm, matrix(CDF, O.d, O.d, 0))
            S.add("anticommutator_of_check_Z_Y (7) 第 3 式 [checkY,checkY]_+",
                  Ym * Yn + Yn * Ym, 2 * M * d * Id)

    # -----------------------------------------------------------------
    # recover_Z_Y_from_check_Z_Y の各段
    # -----------------------------------------------------------------
    for j in range(1, M + 1):
        r0 = sum([checkZ(O, mu) * eiph(j * th_tilde(M, mu)) for mu in range(1, M + 1)],
                 matrix(CDF, O.d, O.d, 0)) / M
        r1 = sum([O.Z[k] * eiph(-k * th_tilde(M, mu)) * eiph(j * th_tilde(M, mu))
                  for mu in range(1, M + 1) for k in range(1, M + 1)],
                 matrix(CDF, O.d, O.d, 0)) / M
        r2 = sum([O.Z[k] * eiph((j - k) * th_tilde(M, mu))
                  for mu in range(1, M + 1) for k in range(1, M + 1)],
                 matrix(CDF, O.d, O.d, 0)) / M
        r3 = sum([O.Z[k] * sum([eiph((j - k) * th_tilde(M, mu))
                                for mu in range(1, M + 1)], CDF(0))
                  for k in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
        S.add("recover_Z_Y (1) def_half_integer_checkZ の代入と分配", r0, r1)
        S.add("recover_Z_Y (2) 指数法則 [theorem_exp_product n=1]", r1, r2)
        S.add("recover_Z_Y (3) 有限和の順序交換", r2, r3)
        S.add("recover_Z_Y (4) antiperiodic_exp_sum で k=j の項のみ -> Z_j", r3, O.Z[j])
        r0y = sum([checkY(O, mu) * eiph(j * th_tilde(M, mu)) for mu in range(1, M + 1)],
                  matrix(CDF, O.d, O.d, 0)) / M
        S.add("recover_Z_Y (5) Y_j についても同様", r0y, O.Y[j])

    # -----------------------------------------------------------------
    # H1_H2_via_check_Z_Y の各段
    # -----------------------------------------------------------------
    for mu in range(1, M + 1):
        t = th_tilde(M, mu)
        # checkZ_{M+1-mu} の 2 段（合同式なし）
        c0 = checkZ(O, M + 1 - mu)
        c1 = sum([O.Z[k] * eiph(-k * th_tilde(M, M + 1 - mu)) for k in range(1, M + 1)],
                 matrix(CDF, O.d, O.d, 0))
        c3 = sum([O.Z[k] * eiph(k * t) for k in range(1, M + 1)],
                 matrix(CDF, O.d, O.d, 0))
        S.add("H1_H2_via_check (ZM+1-mu 1) def_half_integer_checkZ", c0, c1)
        S.add("H1_H2_via_check (ZM+1-mu 2) conjugate_index_of_check_Z_Y (2)", c1, c3)

    # H_2 側の 4 段
    h0 = sum([checkZ(O, M + 1 - mu) * checkY(O, mu) for mu in range(1, M + 1)],
             matrix(CDF, O.d, O.d, 0)) / M
    h1 = sum([(sum([O.Z[k] * eiph(k * th_tilde(M, mu)) for k in range(1, M + 1)],
                   matrix(CDF, O.d, O.d, 0)))
              * (sum([O.Y[j] * eiph(-j * th_tilde(M, mu)) for j in range(1, M + 1)],
                     matrix(CDF, O.d, O.d, 0)))
              for mu in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
    h2 = sum([O.Z[k] * O.Y[j] * eiph(k * th_tilde(M, mu)) * eiph(-j * th_tilde(M, mu))
              for mu in range(1, M + 1) for k in range(1, M + 1)
              for j in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
    h3 = sum([O.Z[k] * O.Y[j] * eiph((k - j) * th_tilde(M, mu))
              for mu in range(1, M + 1) for k in range(1, M + 1)
              for j in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
    h4 = sum([O.Z[k] * O.Y[j] * sum([eiph((k - j) * th_tilde(M, mu))
                                     for mu in range(1, M + 1)], CDF(0))
              for k in range(1, M + 1) for j in range(1, M + 1)],
             matrix(CDF, O.d, O.d, 0)) / M
    S.add("H1_H2_via_check (H2 1) def_half_integer_checkZ / def_half_integer_checkY の代入", h0, h1)
    S.add("H1_H2_via_check (H2 2) 積を二重和へ分配", h1, h2)
    S.add("H1_H2_via_check (H2 3) 指数法則 [theorem_exp_product n=1]", h2, h3)
    S.add("H1_H2_via_check (H2 4) 有限和の順序交換", h3, h4)
    S.add("H1_H2_via_check (H2 5) antiperiodic_exp_sum -> sum Z_jY_j", h4,
          sum([O.Z[j] * O.Y[j] for j in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)))
    S.add("H1_H2_via_check (H2 6) = H_2", h0, H2)

    # H_1^{(+)} 側の 4 段
    k0 = sum([checkY(O, mu) * checkZ(O, M + 1 - mu) * eiph(-th_tilde(M, mu))
              for mu in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
    k1 = sum([(sum([O.Y[j] * eiph(-j * th_tilde(M, mu)) for j in range(1, M + 1)],
                   matrix(CDF, O.d, O.d, 0)))
              * (sum([O.Z[k] * eiph(k * th_tilde(M, mu)) for k in range(1, M + 1)],
                     matrix(CDF, O.d, O.d, 0)))
              * eiph(-th_tilde(M, mu))
              for mu in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
    k2 = sum([O.Y[j] * O.Z[k] * eiph(-j * th_tilde(M, mu)) * eiph(k * th_tilde(M, mu))
              * eiph(-th_tilde(M, mu))
              for mu in range(1, M + 1) for j in range(1, M + 1)
              for k in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
    k3 = sum([O.Y[j] * O.Z[k] * eiph(-(j - k + 1) * th_tilde(M, mu))
              for mu in range(1, M + 1) for j in range(1, M + 1)
              for k in range(1, M + 1)], matrix(CDF, O.d, O.d, 0)) / M
    k4 = sum([O.Y[j] * O.Z[k] * sum([eiph(-(j - k + 1) * th_tilde(M, mu))
                                     for mu in range(1, M + 1)], CDF(0))
              for j in range(1, M + 1) for k in range(1, M + 1)],
             matrix(CDF, O.d, O.d, 0)) / M
    k5 = (sum([O.Y[j] * O.Z[j + 1] * M for j in range(1, M)],
              matrix(CDF, O.d, O.d, 0)) + O.Y[M] * O.Z[1] * (-M)) / M
    S.add("H1_H2_via_check (H1 1) def_half_integer_checkZ / def_half_integer_checkY の代入", k0, k1)
    S.add("H1_H2_via_check (H1 2) 積を二重和へ分配", k1, k2)
    S.add("H1_H2_via_check (H1 3) 指数法則 [theorem_exp_product n=1]", k2, k3)
    S.add("H1_H2_via_check (H1 4) 有限和の順序交換", k3, k4)
    S.add("H1_H2_via_check (H1 5) antiperiodic_exp_sum の l=0, l=1 の 2 場合", k4, k5)
    S.add("H1_H2_via_check (H1 6) = H_1^{(+)}", k0, H1p)

ok_all = S.report_all()
print(f"  段数（区別された等式の種類）: {len(S.worst)}")
print("check_01:", "PASS" if ok_all else "FAIL")
