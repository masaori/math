"""選択項の符号の閉じた式と、共通性が文字の自明性と同値であることを検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/curved-free-class-sum-selection-sign/construction.sage")


def intersection_pairing(side, left, right):
    left_h, left_v = subset_parities(side, left)
    right_h, right_v = subset_parities(side, right)
    return (left_h * right_v + left_v * right_h) % 2
