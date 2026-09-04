"""各連結成分の標準代表として直線ループの合併を試し、代表値を直接評価する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-plaquette-deformation/construction.sage")


def row_loop(side, row):
    return frozenset(("h", row, column) for column in range(side))


def column_loop(side, column):
    return frozenset(("v", row, column) for row in range(side))


def straight_union_table(side):
    table = {}
    for rows in Subsets(range(side)):
        for columns in Subsets(range(side)):
            union = frozenset().union(
                *[row_loop(side, row) for row in rows],
                *[column_loop(side, column) for column in columns])
            table[union] = (ZZ(len(rows)), ZZ(len(columns)))
    return table
