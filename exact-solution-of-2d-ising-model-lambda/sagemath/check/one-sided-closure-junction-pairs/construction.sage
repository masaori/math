# 対象ラベル: claim_one_sided_closure_junction_pairs
from itertools import product


def path_from_steps(start, steps):
    points = [start]
    for step in steps:
        points.append(points[-1] + step)
    return points


def adjacent_steps(points):
    return [points[i+1] - points[i] for i in range(len(points)-1)]


def junction_pairs(a, v, r, x):
    return ((a[-1], v[0]), (v[-1], r[0]), (r[-1], x[0]), (x[-1], a[0]))


junction_rows = []
zero = vector(ZZ, (0, 0))
for wh, wv in product(range(-1, 2), repeat=2):
    if wh == 0 and wv == 0:
        continue
    Csteps = ([vector(ZZ, (sign(wh), 0))] * abs(wh)
              + [vector(ZZ, (0, -sign(wv)))] * abs(wv))
    C = path_from_steps(zero, Csteps)
    transverse = vector(ZZ, (wh, -wv))
    for L in range(1, 4):
        horizontal = [vector(ZZ, (0, sign(wh)))] * (L*abs(wh))
        vertical = [vector(ZZ, (sign(wv), 0))] * (L*abs(wv))
        Gsteps = horizontal + vertical if wh*wv > 0 else vertical + horizontal
        G = path_from_steps(zero, Gsteps)
        n = len(Gsteps)
        B = vector(ZZ, (L*wv, L*wh))
        assert G[-1] == B
        for detour in ([], [vector(ZZ, (1, 0)), vector(ZZ, (-1, 0))]):
            word = detour + Gsteps
            m = len(word)
            for base in (zero, vector(ZZ, (-3, 5))):
                period = path_from_steps(base, word)
                def P(k):
                    return period[k % m] + (k // m)*B
                for k0 in (-m-1, -1, 0, m+1):
                    S = P(k0)
                    u = [P(k0+j+1)-P(k0+j) for j in range(m)]
                    r = [-step for step in Gsteps]
                    for t in range(1, 3):
                        b = t*len(Csteps)
                        def D(i):
                            return (i // len(Csteps))*transverse + C[i % len(Csteps)]
                        v = [D(i+1)-D(i) for i in range(b)]
                        x = [D(b-i-1)-D(b-i) for i in range(b)]
                        for c in range(1, 5):
                            Apoints = [P(k0+j) for j in range(c*m+1)]
                            Vpoints = [S+c*B+D(i) for i in range(b+1)]
                            Rpoints = [S+t*transverse+(c-s//n)*B-G[s % n]
                                       for s in range(c*n+1)]
                            Xpoints = [S+D(b-i) for i in range(b+1)]
                            assert Apoints[-1] == Vpoints[0]
                            assert Vpoints[-1] == Rpoints[0]
                            assert Rpoints[-1] == Xpoints[0]
                            assert Xpoints[-1] == Apoints[0]
                            A,V,R,X = map(adjacent_steps, (Apoints,Vpoints,Rpoints,Xpoints))
                            points = Apoints + Vpoints[1:] + Rpoints[1:] + Xpoints[1:]
                            # 剰余による点の定義から独立に、単位歩を順に加える。
                            rotated = word[k0 % m:] + word[:k0 % m]
                            independent_steps = (rotated*c + Csteps*t
                                                 + [-step for step in Gsteps]*c
                                                 + [-step for step in reversed(Csteps*t)])
                            independent = path_from_steps(S, independent_steps)
                            junction_rows.append((m,n,b,c,u,v,r,x,A,V,R,X,points,independent))
