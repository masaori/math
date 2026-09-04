"""偶奇恒等式の二つの並べ替え符号を辺対と切断線の寄与へ分解する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-doubled-edge-crossing/construction.sage")


def pair_and_seam_decomposition(side, doubled, single, orientation):
    moved = sorted(frozenset(
        [base + (d,) for base in doubled for d in (0, 1)]
        + [base + (orientation[base],) for base in single]
    ))

    interior_row = ZZ(0)
    interior_column = ZZ(0)
    seam_row = ZZ(0)
    seam_column = ZZ(0)
    for left_index in range(len(moved)):
        for right_index in range(left_index + 1, len(moved)):
            left = moved[left_index]
            right = moved[right_index]
            touches_seam = any(base_seam_parities(side, edge[:3]) != (0, 0)
                               for edge in (left, right))
            row_inversion = ZZ(
                (endpoints(side, left)[1], left)
                > (endpoints(side, right)[1], right)
            )
            column_inversion = ZZ(
                (endpoints(side, left)[0], left)
                > (endpoints(side, right)[0], right)
            )
            if touches_seam:
                seam_row += row_inversion
                seam_column += column_inversion
            else:
                interior_row += row_inversion
                interior_column += column_inversion

    original = untwisted_sign_exponent(side, doubled, single, orientation)
    local_phase = (original - ZZ(len(moved)) - interior_row - interior_column
                   - seam_row - seam_column) % 2

    pieces = (
        ZZ(len(moved)) % 2,
        (interior_row + interior_column) % 2,
        (seam_row + seam_column) % 2,
        local_phase,
    )
    decomposed = sum(pieces) % 2
    assert decomposed == original
    return pieces, decomposed
