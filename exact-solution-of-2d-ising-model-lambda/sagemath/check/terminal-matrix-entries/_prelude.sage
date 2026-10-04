# 帰属: 有限な辺集合、整数、円分体 Q(zeta_8) とその多項式環。
load('sagemath/_shared/defs.sage')

terminal_field = CyclotomicField(8)
terminal_zeta = terminal_field.gen()
terminal_ring = PolynomialRing(terminal_field, 'x')
terminal_x = terminal_ring.gen()

def terminal_reverse(e):
    return (e[0], 1 - e[1])

def terminal_source(L, e):
    return endpoints(L, e[0])[e[1]]

def terminal_target(L, e):
    return endpoints(L, e[0])[1 - e[1]]

def terminal_direction(L, e):
    return (0 if e[0] <= L * L else 1) + 2 * e[1]

def terminal_next(L, e):
    return frozenset(f for f in terminal_oriented[L]
        if terminal_target(L, e) == terminal_source(L, f) and f != terminal_reverse(e))

def terminal_phase(L, e, f):
    delta = (terminal_direction(L, f) - terminal_direction(L, e)) % 4
    return {0: terminal_field(1), 1: terminal_zeta, 3: terminal_zeta^(-1)}.get(delta, terminal_field(0))

def terminal_twist(L, spin, e):
    horizontal = e[0] <= L * L
    k = e[0] - 1 if horizontal else e[0] - L * L - 1
    row, col = divmod(k, L)
    h = ZZ(horizontal and col == L - 1)
    v = ZZ(not horizontal and row == L - 1)
    return ZZ(-1)^(spin[0] * h + spin[1] * v)

terminal_oriented = {L: [(e, direction) for e in range(1, 2 * L * L + 1)
    for direction in (0, 1)] for L in (1, 2, 3, 4)}
terminal_cases = []
for L, oriented in terminal_oriented.items():
    n = len(oriented)
    rev = [oriented.index(terminal_reverse(e)) for e in oriented]
    successor = {e: terminal_next(L, e) for e in oriented}
    J = matrix(ZZ, n, lambda i, j: ZZ(oriented[j] == terminal_reverse(oriented[i])))
    I = identity_matrix(terminal_ring, n)
    for spin in ((0, 0), (1, 0), (0, 1), (1, 1)):
        M = matrix(terminal_field, n, lambda i, j:
            terminal_twist(L, spin, oriented[j]) * terminal_phase(L, oriented[i], oriented[j])
            if oriented[j] in successor[oriented[i]] else 0)
        K = I - terminal_x * M.change_ring(terminal_ring)
        lifted_J = J.change_ring(terminal_ring)
        T = lifted_J * K
        sums = matrix(terminal_ring, n, lambda i, j:
            sum((terminal_ring(terminal_field(J[i, g])) * K[g, j] for g in range(n)), terminal_ring(0)))
        terminal_cases.append((L, spin, oriented, rev, J, I, M, K, T, sums))

def terminal_next_chain(L, e, f):
    return (
        f in terminal_next(L, terminal_reverse(e)),
        terminal_target(L, terminal_reverse(e)) == terminal_source(L, f)
            and f != terminal_reverse(terminal_reverse(e)),
        terminal_source(L, e) == terminal_source(L, f)
            and f != terminal_reverse(terminal_reverse(e)),
        terminal_source(L, e) == terminal_source(L, f) and f != e,
        terminal_source(L, f) == terminal_source(L, e) and f != e,
    )

def terminal_row_chain(case, i, j):
    L, spin, oriented, rev, J, I, M, K, T, sums = case
    r = rev[i]
    return (
        T[i, j],
        sums[i, j],
        terminal_ring(terminal_field(J[i, r])) * K[r, j],
        terminal_ring(terminal_field(ZZ(1))) * K[r, j],
        terminal_ring(terminal_field.one()) * K[r, j],
        terminal_ring.one() * K[r, j],
        K[r, j],
        I[r, j] - terminal_x * terminal_ring(M[r, j]),
    )

def terminal_identity_chain(case, i, j):
    L, spin, oriented, rev, J, I, M, K, T, sums = case
    e, f = oriented[i], oriented[j]
    return (I[rev[i], j],
        terminal_ring(1 if terminal_reverse(e) == f else 0),
        terminal_ring(1 if f == terminal_reverse(e) else 0))

def terminal_coefficient_chain(case, i, j):
    L, spin, oriented, rev, J, I, M, K, T, sums = case
    e, f = oriented[i], oriented[j]
    weight = terminal_twist(L, spin, f) * terminal_phase(L, terminal_reverse(e), f)
    is_next = f in terminal_next(L, terminal_reverse(e))
    same_source = terminal_source(L, f) == terminal_source(L, e) and f != e
    return (
        terminal_ring(M[rev[i], j]),
        terminal_ring(weight if is_next else terminal_field(0)),
        terminal_ring(weight if same_source else terminal_field(0)),
        terminal_ring(weight) if same_source else terminal_ring(terminal_field(0)),
        terminal_ring(weight) if same_source else terminal_ring.zero(),
    )

def terminal_final_chain(case, i, j):
    L, spin, oriented, rev, J, I, M, K, T, sums = case
    e, f = oriented[i], oriented[j]
    identity = terminal_ring(1 if f == terminal_reverse(e) else 0)
    weight = terminal_twist(L, spin, f) * terminal_phase(L, terminal_reverse(e), f)
    correction = terminal_ring(weight) if terminal_source(L, f) == terminal_source(L, e) and f != e else terminal_ring(0)
    return (T[i, j],
        identity - terminal_x * terminal_ring(M[rev[i], j]),
        identity - terminal_x * correction)

def terminal_check_pairs(name, chain, step):
    count = 0
    for case in terminal_cases:
        for i in range(len(case[2])):
            for j in range(len(case[2])):
                values = chain(case, i, j)
                assert values[step] == values[step + 1], (name, case[0], case[1], i, j)
                count += 1
    print('PASS {}: {} components'.format(name, count))
