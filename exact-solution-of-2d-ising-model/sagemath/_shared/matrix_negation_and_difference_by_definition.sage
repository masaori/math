# 本文の定め方どおりに成分から組む行列の符号反転と差。
# 符号反転は def_matrix_negation の (-A)_{ik} = -A_{ik} と multiply_by_minus_one の -z := (-1)·z、
# 差は def_matrix_difference の (A-B)_{ik} = A_{ik} - B_{ik} と def_complex_difference の z - w := z + (-w)。
# Sage の `-A`・`A - B` は、これらとは独立な経路として比べる側にだけ使う。


def body_neg_scalar(z):
    """multiply_by_minus_one の -z := (-1)·z。"""
    return z.parent()(-1) * z


def body_negation(A):
    """def_matrix_negation の符号反転を成分から組む。"""
    R = A.base_ring()
    return matrix(R, A.nrows(), A.ncols(), lambda i, k: body_neg_scalar(A[i, k]))


def body_difference(A, B):
    """def_matrix_difference の差を、def_complex_difference の z + (-w) で成分から組む。"""
    assert A.nrows() == B.nrows() and A.ncols() == B.ncols()
    R = A.base_ring()
    return matrix(R, A.nrows(), A.ncols(), lambda i, k: A[i, k] + body_neg_scalar(B[i, k]))
