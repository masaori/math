# 帰属: 整数、円分体 Q(zeta_8)、その一変数多項式環。浮動小数点は使わない。
from itertools import permutations
load('sagemath/check/terminal-matrix-entries/_prelude.sage')

def terminal_integer_constant(n):
    return terminal_ring(terminal_field(ZZ(n)))

def terminal_row_sign(p):
    return ZZ(-1)^sum(ZZ(p[i] > p[j]) for i in range(len(p)) for j in range(i + 1, len(p)))

# 全置換展開は一辺一の反転行列と、負・零・非単位の成分を含む対照行列で調べる。
terminal_lift_matrices = [terminal_cases[0][4], matrix(ZZ, 0, 0), matrix(ZZ, [[-3]]),
    matrix(ZZ, [[2, -1], [3, 4]]), matrix(ZZ, [[0, -2, 1], [3, 0, 4], [-1, 2, 0]])]
terminal_lift_chains = []
for A in terminal_lift_matrices:
    n = A.nrows()
    perms = list(permutations(range(n)))
    lifted = A.change_ring(terminal_ring)
    c = terminal_integer_constant
    terminal_lift_chains.append((
        lifted.det(),
        sum((c(terminal_row_sign(p)) * prod((lifted[i, p[i]] for i in range(n)), terminal_ring.one()) for p in perms), terminal_ring.zero()),
        sum((c(terminal_row_sign(p)) * prod((c(A[i, p[i]]) for i in range(n)), terminal_ring.one()) for p in perms), terminal_ring.zero()),
        sum((c(terminal_row_sign(p)) * c(prod((A[i, p[i]] for i in range(n)), ZZ.one())) for p in perms), terminal_ring.zero()),
        sum((c(terminal_row_sign(p) * prod((A[i, p[i]] for i in range(n)), ZZ.one())) for p in perms), terminal_ring.zero()),
        c(sum((terminal_row_sign(p) * prod((A[i, p[i]] for i in range(n)), ZZ.one()) for p in perms), ZZ.zero())),
        c(A.det()),
    ))
terminal_unit_chains = []
for L in (1, 2, 3, 4, 5):
    n = 4 * L * L
    J = matrix(ZZ, n, lambda i, j: ZZ(i // 2 == j // 2 and i % 2 != j % 2))
    terminal_unit_chains.append((terminal_integer_constant(J.det()),
        terminal_integer_constant(1), terminal_ring.one()))

terminal_determinant_chains = []
for case in terminal_cases:
    L, spin, oriented, rev, J, I, M, K, T, sums = case
    if L > 3:
        continue
    n = len(oriented)
    # 行列積を使わず、端末行列の成分の式から独立に組み立てる。
    direct = matrix(terminal_ring, n, lambda i, j:
        terminal_ring(ZZ(oriented[j] == terminal_reverse(oriented[i]))) - terminal_x *
        (terminal_ring(terminal_twist(L, spin, oriented[j]) *
            terminal_phase(L, terminal_reverse(oriented[i]), oriented[j]))
        if terminal_source(L, oriented[j]) == terminal_source(L, oriented[i])
            and oriented[j] != oriented[i] else terminal_ring.zero()))
    assert direct == T == sums, (L, spin, 'independent terminal entries')
    lifted = J.change_ring(terminal_ring)
    det_terminal = direct.det()
    det_product = (lifted * K).det()
    det_lift = lifted.det()
    det_kac_ward = K.det()
    D = (identity_matrix(terminal_ring, n) - terminal_x * M.change_ring(terminal_ring)).det()
    assert det_terminal[0] == 1 and det_kac_ward[0] == 1, (L, spin, 'constant term')
    terminal_determinant_chains.append((det_terminal, det_product,
        det_lift * det_kac_ward, terminal_ring.one() * det_kac_ward, det_kac_ward, D))
    print('exact determinant case ready: L={}, spin={}, degree={}'.format(L, spin, D.degree()))

def terminal_det_check(name, chains, step):
    for values in chains:
        assert values[step] == values[step + 1], (name, values[step], values[step + 1])
    print('PASS {}: {} exact equalities'.format(name, len(chains)))
