# 帰属: 辺番号・向き・行列成分は ZZ、向き付き辺は整数の対。
def reverse_edge(edge):
    number, direction = edge
    return (number, ZZ(1) - direction)


def reversal_entry(edge, target):
    return ZZ(target == reverse_edge(edge))


matrix_cases = []
for L in range(1, 6):
    oriented = [(ZZ(number), ZZ(direction))
                for number in range(1, 2 * L^2 + 1) for direction in (0, 1)]
    J = matrix(ZZ, len(oriented), len(oriented),
               lambda i, j: reversal_entry(oriented[i], oriented[j]))
    I = identity_matrix(ZZ, len(oriented))
    matrix_cases.append((ZZ(L), oriented, J, I, J * J))
