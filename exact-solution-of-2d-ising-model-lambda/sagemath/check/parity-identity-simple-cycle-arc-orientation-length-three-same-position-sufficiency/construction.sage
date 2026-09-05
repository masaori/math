"""語長三の非切断項を、同じ署名位置の単一辺所属の積へ制限する。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-single-membership-sufficiency/construction.sage")


def same_position_quadratic_pairs(names):
    """語の三位置と両端点の五ブロックを区別し、各ブロック内の積を許す。"""
    return tuple((i, j) for i, j in single_membership_quadratic_pairs(names)
                 if pair_membership_kind(names, (i, j)) is None
                 or names[i].split("_")[0] == names[j].split("_")[0])
