"""語長 1 の制限が低次式になる解の存在判定。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-rule/construction.sage")


def augmented_low_degree_system(entries, row_count, column_count, rhs,
                                length_one_columns, feature_rows):
    """弧型ごとの値と式の係数を同時に未知数とする合同 F_2 線型系を作る。

    未知数は、弧型ごとの値 x（column_count 個）に、定数項 1 個と
    特徴ごとの係数（len(feature_rows[0]) 個）を続けて並べる。行は、
    もとの合同系（x だけに係る）に、語長 1 の各弧型 t について
    「x_t + c_0 + Σ_i c_i f_i(t) = 0」を 1 行ずつ加える。

    戻り値は (係数行列, 右辺ベクトル)。
    """
    feature_count = len(feature_rows[0])
    total_columns = column_count + 1 + feature_count
    combined = dict(entries)
    one = GF(2)(1)
    for offset, (column, features) in enumerate(
            zip(length_one_columns, feature_rows)):
        row = row_count + offset
        combined[(row, column)] = one
        combined[(row, column_count)] = one
        for feature_index, bit in enumerate(features):
            if bit % 2 == 1:
                combined[(row, column_count + 1 + feature_index)] = one
    total_rows = row_count + len(length_one_columns)
    combined_matrix = matrix(GF(2), total_rows, total_columns, combined)
    combined_rhs = vector(
        GF(2), list(rhs) + [0] * len(length_one_columns))
    return combined_matrix, combined_rhs
