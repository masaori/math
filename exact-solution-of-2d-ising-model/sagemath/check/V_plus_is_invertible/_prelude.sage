# 対象ラベル: V_plus_is_invertible
# 共通の準備。Z_m・Y_m・H_1^(+)・H_2・V_2 の成分の定義・exp の厳密な作り方とボールは共有の準備から読み込む（複製しない）。
load("../../_shared/transfer_matrix_factor_inverses.sage")

KQ = QQbar


def to_QQbar(A):
    return matrix(KQ, A.nrows(), A.ncols(), [KQ(z) for z in A.list()])


def iota_exact(r):
    """inclusion_rr_to_cc の r_C = (r, 0)。ℝ の元は AA、ℂ の元は QQbar で持ち、実部・虚部を確かめる。"""
    z = KQ(r)
    assert z.real() == r and z.imag() == 0
    return z
