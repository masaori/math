"""偶奇恒等式を標準形配向での評価へ帰着できることを検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-component-reversal-cancellation/construction.sage")


def standard_orientation(side, single, orientations):
    """各成分の最小辺の向きが 0 の配向（標準形）を一意に取り出す。"""
    components = single_edge_components(side, single)
    found = [
        orientation for orientation in orientations
        if all(orientation[min(component)] == 0 for component in components)
    ]
    assert len(found) == 1
    return found[0], components
