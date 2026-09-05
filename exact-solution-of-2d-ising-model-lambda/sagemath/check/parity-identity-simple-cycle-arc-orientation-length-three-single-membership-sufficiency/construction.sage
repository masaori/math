"""語長三の純二次式の非切断項を単一辺所属同士だけへ制限する。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-quadratic-kind-removal/construction.sage")


def single_membership_quadratic_pairs(names):
    """切断旗を含む積と、単一辺所属の相異なる二ビットの積を残す。"""
    pairs = tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names)))
    return tuple(pair for pair in pairs
                 if pair_membership_kind(names, pair) in (None, ("e", "e")))
