# ---------------------------------------------------------
# 共通: W P^(+) = V^(+) P^(+) の一行ずつの数値検査
#   B := V_1^{1/2}, C := (V_1^{(+)})^{1/2}, P := P^{(+)}（本文の略記）
# 対象ラベル: symmetrized_transfer_matrix_on_sectors
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

SECTOR_REPRESENTATION_TOL = 1e-9


def sector_representation_data(M, K1v, K2v):
    O = SpinOps(M)
    P = projector_plus(O)
    B = V1_half(O, K1v)
    C = V1_plus_half(O, K1v)
    V2 = V2_pauli(O, K2v)
    return {
        'B': B,
        'C': C,
        'P': P,
        'V2': V2,
        'W': W_matrix(O, K1v, K2v),
        'Vplus': V_plus(O, K1v, K2v),
    }


def relative_residual(lhs, rhs):
    return opnorm(lhs - rhs) / max(opnorm(lhs), opnorm(rhs), 1)


def check_sector_representation_identity(identity_name, side_builder):
    print(f"=== {identity_name} ===")
    all_ok = True
    worst = RDF(0)
    for (M, K1v, K2v) in MAXEIG_CASES:
        data = sector_representation_data(M, K1v, K2v)
        lhs, rhs = side_builder(data)
        residual = relative_residual(lhs, rhs)
        worst = max(worst, residual)
        ok = residual <= SECTOR_REPRESENTATION_TOL
        print(
            f"  M={M}, K1={K1v}, K2={K2v}, sector=+1: "
            f"relative residual={residual:.3e} -> {'PASS' if ok else 'FAIL'}"
        )
        all_ok = ok and all_ok
    print(f"WORST RELATIVE RESIDUAL: {worst:.3e}")
    print("RESULT: PASS" if all_ok else "RESULT: FAIL")
    if not all_ok:
        raise AssertionError(f"{identity_name} numerical check failed")
