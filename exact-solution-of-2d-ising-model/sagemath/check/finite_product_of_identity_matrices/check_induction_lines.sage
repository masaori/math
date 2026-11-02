# 対象ラベル: finite_product_of_identity_matrices（∏_{j=1}^{r} I = I）
# 証明の帰納法の各行:
#   r = 1:  ∏_{j=1}^{1} I = I                                   (def_finite_product_of_matrices)
#   r → r+1: ∏_{j=1}^{r+1} I = (∏_{j=1}^{r} I) I                (def_finite_product_of_matrices)
#                            = I I                              (帰納法の仮定)
#                            = I                                (identity_matrix_is_right_unit_of_mat_mult)
# 有限積は def_finite_product_of_matrices の帰納法どおり左から掛ける（空の積を使わず A_1 から始める）。
# 行列の積と単位行列は本文の成分の式（_shared の body_product・body_identity）で組む。
# 帰属: QQ（単位行列の成分は 0 と 1）。n = 1,…,4、r = 1,…,8。
load("../../_shared/matrix_operations_by_definition.sage")


def left_to_right_product(mats):
    acc = mats[0]                                   # ∏_{j=1}^{1} A_j := A_1
    for A in mats[1:]:
        acc = body_product(acc, A)                  # ∏_{j=1}^{r+1} A_j := (∏_{j=1}^{r} A_j) A_{r+1}
    return acc


count = 0
for n in range(1, 5):
    Id = body_identity(QQ, n)
    assert Id == identity_matrix(QQ, n)
    assert left_to_right_product([Id]) == Id                         # r = 1 の行
    count += 1
    for r in range(1, 8):
        line1 = left_to_right_product([Id] * (r + 1))
        line2 = body_product(left_to_right_product([Id] * r), Id)    # 定義の行
        assert left_to_right_product([Id] * r) == Id                 # 帰納法の仮定
        line3 = body_product(Id, Id)                                 # 帰納法の仮定を代入
        line4 = Id                                                   # identity_matrix_is_right_unit_of_mat_mult
        assert line1 == line2 == line3 == line4
        count += 1
# 対照: 単位行列でない因子が一つあれば単位行列にならない
Jm = matrix(QQ, [[1, 1], [0, 1]])
I2 = body_identity(QQ, 2)
assert left_to_right_product([I2, Jm, I2]) != I2
print(f"checked {count} cases")
print("RESULT: PASS")
