"""標準形の並べ替え反転を作る辺対が局所的かを調べる。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-standard-form-statistics/construction.sage")

def pair_contribution(side, left, right):
    row = ZZ(
        (endpoints(side, left)[1], left)
        > (endpoints(side, right)[1], right)
    )
    column = ZZ(
        (endpoints(side, left)[0], left)
        > (endpoints(side, right)[0], right)
    )
    return (row + column) % 2
