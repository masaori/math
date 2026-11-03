# 対象ラベル: trace_of_scalar_multiple（tr(αA) = α tr(A)）
# 証明の各行:
#   tr(αA) = tr(αA + O)                     (matrix_plus_zero_matrix を右辺から左辺へ)
#          = tr(αA + 0_C A)                 (zero_scalar_multiple_is_zero_matrix を右辺から左辺へ)
#          = α tr(A) + 0_C tr(A)            (trace_basic_properties (1)、β → 0_C、B → A)
#          = α tr(A) + 0_C                  (complex_zero_times_is_zero)
#          = α tr(A)                        (0_C は加法の単位元)
# 行列の和は body_sum、スカラー倍は body_scalar、零行列は成分が 0 の行列、トレースは def_trace の対角成分の和で組む。
# 帰属: QQ 上の多項式環（α と A の成分は不定元）。浮動小数点はない。
load("../../_shared/matrix_operations_by_definition.sage")


def tr(A):
    """def_trace: 対角成分を k = 1, …, n の順に足す。"""
    total = A[0, 0]
    for k in range(1, A.nrows()):
        total = total + A[k, k]
    return total


count = 0
for n in range(1, 6):
    P, (al,), (A,) = generic_ring([("A", n, n)], scalars=("al",))
    O = matrix(P, n, n, 0)
    zero = P(0)
    lines = [
        tr(body_scalar(al, A)),
        tr(body_sum(body_scalar(al, A), O)),
        tr(body_sum(body_scalar(al, A), body_scalar(zero, A))),
        al * tr(A) + zero * tr(A),
        al * tr(A) + zero,
        al * tr(A),
    ]
    for a, b in zip(lines, lines[1:]):
        assert a == b, n
        count += 1
    assert lines[0] == (al * A).trace()   # 独立な経路: Sage のスカラー倍とトレース
    # 対照: α を掛けずにトレースを取ると一致しない
    assert lines[0] != tr(A)
print(f"checked {count} lines")
print("RESULT: PASS")
