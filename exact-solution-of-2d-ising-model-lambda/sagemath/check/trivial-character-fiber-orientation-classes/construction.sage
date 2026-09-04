"""自明文字ファイバーの置換を配向差で類別し、類和の構造を一辺二で検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/trivial-character-fiber-magnitude/construction.sage")

def induced_orientation(phi, single):
    moved = moved_edges(phi)
    orientation = {}
    for base in single:
        forward = (base[0], base[1], base[2], 0) in moved
        backward = (base[0], base[1], base[2], 1) in moved
        assert forward != backward
        orientation[base] = 0 if forward else 1
    return orientation
