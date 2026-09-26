# =========================================================================
# check_02: why_008_applies_only_to_minus_sector の proof Step 1 の各段
#   （参照用ノート structured-latex/notes/integer_momentum_route_not_adopted.ts の
#     note_evensector_004_claim_commutator_H_check_Z_Y_integer_route_evensector_001_claim_why_minus_only
#     に退避された本文当時の証明）
#
#   もとは check/051_stepwise_identities_of_chapter_Cprime/check_01_013_steps.sage に
#   含まれていた段。本文の Step 1 は commutator_of_H_and_check_Z_Y へ移り、そちらは
#   051 の check_01 が検証する。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_02: why_008 Step 1 の各段の等式 ===")

worst = {}


def add(name, lhs, rhs):
    worst[name] = max(worst.get(name, RDF(0)), opnorm(matrix(CDF, lhs) - matrix(CDF, rhs)))


for M in EVEN_CASES_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    H2 = O.H2

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
            add("why_008 Step1 (1) (Z_mY_m)Z_j = Z_m(Y_mZ_j)",
                  (Zm * Ym) * Zj, Zm * (Ym * Zj))
            add("why_008 Step1 (2) Y_mZ_j = -Z_jY_m  [anticommutator_of_Z_and_Y]",
                  Zm * (Ym * Zj), Zm * (-Zj * Ym))
            add("why_008 Step1 (3) Z_m(-Z_jY_m) = -(Z_mZ_j)Y_m",
                  Zm * (-Zj * Ym), -(Zm * Zj) * Ym)
            add("why_008 Step1 (4) Z_mZ_j = -Z_jZ_m  [anticommutator_of_Z_and_Y]",
                  -(Zm * Zj) * Ym, -(-Zj * Zm) * Ym)
            add("why_008 Step1 (5) = Z_j(Z_mY_m)",
                  -(-Zj * Zm) * Ym, Zj * (Zm * Ym))

    # [Z_jY_j, Z_j] の 6 段
    for j in range(1, M + 1):
        Zj, Yj = O.Z[j], O.Y[j]
        add("why_008 Step1 [Z_jY_j,Z_j] (1) 交換子の定義",
              comm(Zj * Yj, Zj), (Zj * Yj) * Zj - Zj * (Zj * Yj))
        add("why_008 Step1 [Z_jY_j,Z_j] (2) 結合法則",
              (Zj * Yj) * Zj - Zj * (Zj * Yj), Zj * (Yj * Zj) - (Zj * Zj) * Yj)
        add("why_008 Step1 [Z_jY_j,Z_j] (3) Y_jZ_j = -Z_jY_j",
              Zj * (Yj * Zj) - (Zj * Zj) * Yj, Zj * (-Zj * Yj) - (Zj * Zj) * Yj)
        add("why_008 Step1 [Z_jY_j,Z_j] (4) 結合法則とスカラー倍",
              Zj * (-Zj * Yj) - (Zj * Zj) * Yj, -(Zj * Zj) * Yj - (Zj * Zj) * Yj)
        add("why_008 Step1 [Z_jY_j,Z_j] (5) Z_jZ_j = I",
              -(Zj * Zj) * Yj - (Zj * Zj) * Yj, -Id * Yj - Id * Yj)
        add("why_008 Step1 [Z_jY_j,Z_j] (6) = -2Y_j",
              -Id * Yj - Id * Yj, -2 * Yj)
        add("why_008 Step1 まとめ [H_2, Z_j] = -2Y_j", comm(H2, Zj), -2 * Yj)

ok_all = True
for name in worst:
    ok_all &= report(name, worst[name], TOL)
print(f"  段数（区別された等式の種類）: {len(worst)}")
print("RESULT: PASS" if ok_all else "RESULT: FAIL")
