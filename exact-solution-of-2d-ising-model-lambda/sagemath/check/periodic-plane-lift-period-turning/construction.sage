# 対象ラベル: claim_periodic_plane_lift_period_turning
from itertools import product

def pt_add(a, b):
    return (a[0] + b[0], a[1] + b[1])

def pt_sub(a, b):
    return (a[0] - b[0], a[1] - b[1])

def pt_scale(q, a):
    return (q*a[0], q*a[1])

def pt_project(L, p, u):
    horizontal = u[0] == 0
    reverse = int(u[0] + u[1] < 0)
    base = pt_add(p, u) if reverse else p
    edge = (0 if horizontal else L*L) + L*(base[0] % L) + base[1] % L + 1
    return (edge, reverse)

def pt_displacement(L, edge):
    sign = 1 - 2*edge[1]
    return (0, sign) if edge[0] <= L*L else (sign, 0)

def pt_direction(L, edge):
    return (0 if edge[0] <= L*L else 1) + 2*edge[1]

def pt_endpoints(L, edge):
    k = (edge[0] - 1) % (L*L)
    p = (k // L, k % L)
    step = (0, 1) if edge[0] <= L*L else (1, 0)
    q = tuple(x % L for x in pt_add(p, step))
    return (q, p) if edge[1] else (p, q)

def pt_direction_turn(L, e, f):
    return (0, 1, 0, -1)[(pt_direction(L, f) - pt_direction(L, e)) % 4]

def pt_tau(L, e, f):
    assert pt_endpoints(L, e)[1] == pt_endpoints(L, f)[0]
    assert f != (e[0], 1-e[1])
    return pt_direction_turn(L, e, f)

def pt_winding(L, edges):
    wh, wv = 0, 0
    for edge, reverse in edges:
        base = (edge-1) % (L*L)
        sign = 1-2*reverse
        if edge <= L*L and base % L == L-1:
            wh += sign
        if edge > L*L and base // L == L-1:
            wv += sign
    return wh, wv

def pt_lift(P, B, h):
    q, r = divmod(h, len(P)-1)
    return pt_add(P[r], pt_scale(q, B))

def pt_weight(u, v):
    return u[1]*v[0] - u[0]*v[1]

def pt_cyclic_weight(u):
    return sum(pt_weight(u[j], u[(j+1) % len(u)]) for j in range(len(u)))

def pt_rho(k, j, m):
    return (j+k) % m

def period_turning_cases():
    directions = ((0, 1), (1, 0), (0, -1), (-1, 0))
    for m in range(1, 7):
        for D in product(directions, repeat=m):
            if any(D[(j+1) % m] == pt_scale(-1, D[j]) for j in range(m)):
                continue
            displacement = tuple(sum(u[k] for u in D) for k in range(2))
            for L in range(1, 5):
                if any(x % L for x in displacement):
                    continue
                for base in sorted(set(((0, 0), (L-1, L-1)))):
                    P = [base]
                    for u in D:
                        P.append(pt_add(P[-1], u))
                    edges = tuple(pt_project(L, P[j], D[j]) for j in range(m))
                    wh, wv = pt_winding(L, edges)
                    B = (L*wv, L*wh)
                    table = tuple(tuple(pt_direction_turn(L, e, f) for f in edges) for e in edges)
                    turns = sum(pt_tau(L, edges[j], edges[(j+1) % m]) for j in range(m))
                    internal = sum(pt_direction_turn(L, edges[j], edges[j+1]) for j in range(m-1))
                    for k in sorted(set((-m-1, -1, *range(m), m, m+1))):
                        points = tuple(pt_lift(P, B, k+j) for j in range(m+1))
                        u = tuple(pt_sub(points[j+1], points[j]) for j in range(m))
                        yield dict(m=m, L=L, P=tuple(P), B=B, D=D, edges=edges,
                                   table=table, turns=turns, internal=internal, k=k,
                                   points=points, u=u)
