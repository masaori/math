"""語長 2 の二次式解の切断旗局在の存在判定。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-quadratic-solution/construction.sage")


def non_wrap_pair_indices(names):
    """相異なる二成分の積のうち、どちらの成分も切断旗でない積の番号列。

    番号は degree_two_features の積の並び（first < second の辞書順）に一致する。
    """
    count = len(names)
    indices = []
    pair_index = 0
    for first in range(count):
        for second in range(first + 1, count):
            if "wrap" not in names[first] and "wrap" not in names[second]:
                indices.append(pair_index)
            pair_index += 1
    return tuple(indices)


def stack_zero_coefficient_constraints(system_matrix, rhs, columns):
    """指定した未知数の座標を 0 に固定する行を積んだ系を返す。

    各拘束は、その座標にだけ 1 を持つ行（右辺 0）である。
    戻り値は (拡大した係数行列, 拡大した右辺ベクトル)。
    """
    one = GF(2)(1)
    constraint_entries = {(row, column): one
                          for row, column in enumerate(columns)}
    constraint_matrix = matrix(
        GF(2), len(columns), system_matrix.ncols(), constraint_entries)
    stacked_rhs = vector(GF(2), list(rhs) + [0] * len(columns))
    return system_matrix.stack(constraint_matrix), stacked_rhs
