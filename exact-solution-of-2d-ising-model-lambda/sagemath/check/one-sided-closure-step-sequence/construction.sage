# 対象ラベル: claim_one_sided_closure_step_sequence
from itertools import product

def paths():
    directions = [vector(ZZ, t) for t in [(1, 0), (0, 1), (-1, 0), (0, -1), (2, -3), (0, 0), (-4, 2)]]
    def extend(start, steps):
        result = [start]
        for step in steps:
            result.append(result[-1] + step)
        return result
    for a, b, c in product(range(1, 6), repeat=3):
        for seed in range(8):
            def steps(length, phase):
                return [directions[(seed * (i + 1) + phase + i * i) % len(directions)]
                        for i in range(length)]
            P = extend(vector(ZZ, (seed - 3, 2 * seed)), steps(a, 0))
            Q = extend(P[-1], steps(b, 1))
            R = extend(Q[-1], steps(c, 2))
            ssteps = steps(b, 3)
            S = extend(R[-1] - sum(ssteps, vector(ZZ, (0, 0))), ssteps)
            assert P[a] == Q[0] and Q[b] == R[0] and R[c] == S[b]
            yield a, b, c, P, Q, R, S

def rows(part):
    for a, b, c, P, Q, R, S in paths():
        N = a + 2 * b + c
        def F(j):
            assert 0 <= j <= N
            if j < a:
                return P[j]
            if j < a + b:
                return Q[j - a]
            if j < a + b + c:
                return R[j - a - b]
            return S[N - j]
        u = [P[i + 1] - P[i] for i in range(a)]
        v = [Q[i + 1] - Q[i] for i in range(b)]
        w = [R[i + 1] - R[i] for i in range(c)]
        x = [S[b - (i + 1)] - S[b - i] for i in range(b)]
        z = u + v + w + x
        cases = {
            'first_inside': [(j, j) for j in range(a - 1)],
            'first_seam': [(a - 1, a - 1)],
            'second_inside': [(a + k, k) for k in range(b - 1)],
            'second_seam': [(a + b - 1, b - 1)],
            'third_inside': [(a + b + k, k) for k in range(c - 1)],
            'third_seam': [(a + b + c - 1, c - 1)],
            'fourth': [(a + b + c + k, k) for k in range(b)],
        }
        covered = [j for case in cases.values() for j, k in case]
        assert sorted(covered) == list(range(N))
        for j, k in cases[part]:
            yield a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k
