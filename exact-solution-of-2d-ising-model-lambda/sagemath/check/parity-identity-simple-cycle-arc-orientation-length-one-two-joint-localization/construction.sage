"""語長 1 と語長 2 の切断旗局在の拘束を同時に課した解の存在判定。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-wrap-localization/construction.sage")


def augmented_two_block_low_degree_system(entries, row_count, column_count, rhs,
                                          blocks):
    """複数の語長のブロックを同時に持つ合同 F_2 線型系を作る。

    未知数は、弧型ごとの値 x（column_count 個）に、ブロックごとの
    「定数項 1 個＋特徴ごとの係数」を順に続けて並べる。行は、もとの合同系
    （x だけに係る）に、各ブロックの各弧型 t について
    「x_t + c_0 + Σ_i c_i f_i(t) = 0」を 1 行ずつ加える。

    blocks は (対象弧型の列番号の列, 特徴ビット列の列) の組の列。
    戻り値は (係数行列, 右辺ベクトル, ブロックごとの係数先頭列の組)。
    """
    combined = dict(entries)
    one = GF(2)(1)
    block_starts = []
    next_column = column_count
    next_row = row_count
    for columns, feature_rows in blocks:
        block_starts.append(next_column)
        feature_count = len(feature_rows[0])
        for column, features in zip(columns, feature_rows):
            combined[(next_row, column)] = one
            combined[(next_row, next_column)] = one
            for feature_index, bit in enumerate(features):
                if bit % 2 == 1:
                    combined[(next_row, next_column + 1 + feature_index)] = one
            next_row += 1
        next_column += 1 + feature_count
    combined_matrix = matrix(GF(2), next_row, next_column, combined)
    combined_rhs = vector(GF(2), list(rhs) + [0] * (next_row - row_count))
    return combined_matrix, combined_rhs, tuple(block_starts)
