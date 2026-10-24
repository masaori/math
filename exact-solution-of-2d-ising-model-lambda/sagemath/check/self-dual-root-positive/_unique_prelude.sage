# 対象ラベル: claim_self_dual_positive_root_unique
# 順序は QQ の係数で判定し、QQbar の大小を使わない。
load('sagemath/check/self-dual-root-positive/_plus_mem_prelude.sage')

def unique_positive(value, s):
    a, b = reconstruct_in_quadratic_field(value, s)
    return ((a >= 0 and b >= 0 and (a, b) != (0, 0)) or
            (a > 0 and b < 0 and 2*b*b < a*a) or
            (a < 0 and b > 0 and a*a < 2*b*b))

def unique_cases():
    for s in plus_mem_roots:
        roots = (z_plus_mem**2 + 2*z_plus_mem - 1).roots(QQbar, multiplicities=False)
        assert len(roots) == 2
        for xi in roots:
            yield s, xi
