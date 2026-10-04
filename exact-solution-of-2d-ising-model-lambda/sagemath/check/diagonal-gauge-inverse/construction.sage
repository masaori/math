# 定義のみ。代数的数の計算は円分体 Q(zeta_8) 内で行う。
from itertools import product

_dg_field = CyclotomicField(8)
_dg_primitive_root = _dg_field.gen()

def diagonal_gauge_case(L, a, b, root_power):
    z = _dg_primitive_root ** root_power
    edges = tuple(product(range(1, 2 * L * L + 1), (0, 1)))
    directions, parities, ps, qs, us, vs = [], [], [], [], [], []
    for edge, reverse in edges:
        horizontal = edge <= L * L
        index = edge - 1 if horizontal else edge - L * L - 1
        row, column = divmod(index, L)
        direction = ZZ((0 if horizontal else 1) + 2 * reverse)
        seam_h = ZZ(horizontal and column == L - 1)
        seam_v = ZZ(not horizontal and row == L - 1)
        parity = (ZZ(a) * seam_h + ZZ(b) * seam_v) % 2
        directions.append(direction)
        parities.append(parity)
        ps.append(-direction)
        qs.append(-2 * parity)
        us.append(z ** (-direction) * z ** (-2 * parity))
        vs.append(z ** (2 * parity) * z ** direction)
    U = diagonal_matrix(_dg_field, us)
    V = diagonal_matrix(_dg_field, vs)
    return dict(L=L, a=a, b=b, root_power=root_power, z=z, edges=edges,
                directions=directions, parities=parities, ps=ps, qs=qs,
                us=us, vs=vs, U=U, V=V)
