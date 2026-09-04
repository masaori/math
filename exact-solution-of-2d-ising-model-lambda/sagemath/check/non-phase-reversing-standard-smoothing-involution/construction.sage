"""標準対の回転差が正負四である部分集合上の位相保存対合を厳密検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/phase-reversing-standard-smoothing-involution/construction.sage")

def standard_delta(phi):
    pair = tuple(ct_min(phi))
    return standard_pair_delta(phi, pair)
fiber_members = {delta: {} for delta in (ZZ(-4), ZZ(4))}
all_fibers = set(fiber_members[-4]).union(fiber_members[4])
