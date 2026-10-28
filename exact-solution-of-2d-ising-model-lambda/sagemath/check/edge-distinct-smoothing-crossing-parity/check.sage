"""辺が相異なる閉歩道の一回の平滑化と交差形式を有限トーラスで検算する。"""
from itertools import product


def edges(L):
    return [(a, i, j, d) for a, i, j, d in product((0, 1), range(L), range(L), (0, 1))]


def ends(L, e):
    a, i, j, d = e
    p = (i, j)
    q = ((i, (j + 1) % L) if a == 0 else ((i + 1) % L, j))
    return (p, q) if d == 0 else (q, p)


def reverse(e):
    a, i, j, d = e
    return (a, i, j, 1-d)


def successor(L, e, f):
    return ends(L, e)[1] == ends(L, f)[0] and f != reverse(e)


def axis(e):
    return e[0]


def straight(e, f):
    return e[0] == f[0] and e[3] == f[3]


def crossings(L, A, B=None):
    if B is None:
        return sum(ZZ(ends(L, A[r])[1] == ends(L, A[s])[1]
                      and straight(A[r], A[(r+1) % len(A)])
                      and straight(A[s], A[(s+1) % len(A)])
                      and axis(A[r]) != axis(A[s]))
                   for r in range(len(A)) for s in range(r+1, len(A)))
    return sum(ZZ(ends(L, A[r])[1] == ends(L, B[s])[1]
                  and straight(A[r], A[(r+1) % len(A)])
                  and straight(B[s], B[(s+1) % len(B)])
                  and axis(A[r]) != axis(B[s]))
               for r in range(len(A)) for s in range(len(B)))


def intersection(L, A, B):
    def H(w, i, j):
        return ZZ(any(e[:3] == (0, i % L, j % L) for e in w))
    def V(w, i, j):
        return ZZ(any(e[:3] == (1, i % L, j % L) for e in w))
    return sum(H(A, i, j)*V(B, i-1, j+1) + V(A, i, j)*H(B, i, j)
               for i in range(L) for j in range(L)) % 2


checked = 0
for L in (1, 2, 3):
    oriented = edges(L)
    frontier = [(e,) for e in oriented]
    for _ in range(min(8, 2*L*L)):
        next_frontier = []
        for walk in frontier:
            if successor(L, walk[-1], walk[0]):
                for k in range(len(walk)):
                    for l in range(k+1, len(walk)):
                        if not (ends(L, walk[k])[1] == ends(L, walk[l])[1]
                                and straight(walk[k], walk[(k+1) % len(walk)])
                                and straight(walk[l], walk[(l+1) % len(walk)])
                                and axis(walk[k]) != axis(walk[l])):
                            continue
                        A = walk[k+1:l+1]
                        B = walk[l+1:] + walk[:k+1]
                        assert successor(L, A[-1], A[0]) and successor(L, B[-1], B[0])
                        assert crossings(L, walk) == crossings(L, A) + crossings(L, B) + crossings(L, A, B) + 1
                        assert crossings(L, A, B) % 2 == intersection(L, A, B)
                        checked += 1
            if len(walk) < min(8, 2*L*L):
                for e in oriented:
                    if e[:3] not in {f[:3] for f in walk} and successor(L, walk[-1], e):
                        next_frontier.append(walk + (e,))
        frontier = next_frontier
assert checked > 0
print(f'PASS: {checked} distinct-edge smoothing cases')
