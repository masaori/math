"""標準対平滑化が位相反転部分集合の上で符号反転対合であることを厳密検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/contact-smoothing-phase-reversal/construction.sage")

def standard_pair_delta(phi, pair):
    edge, other = pair
    return (
        step_turning(edge, phi[edge]) + step_turning(other, phi[other])
        - step_turning(edge, phi[other]) - step_turning(other, phi[edge])
    )


def in_B(phi):
    """B_L の所属判定: 接触対を持ち、標準対が切り替え可能かつ位相反転であること。"""
    if not contact_pairs(phi):
        return False
    pair = tuple(ct_min(phi))
    if not is_switchable_contact_pair(phi, pair[0], pair[1]):
        return False
    return standard_pair_delta(phi, pair) == 0
