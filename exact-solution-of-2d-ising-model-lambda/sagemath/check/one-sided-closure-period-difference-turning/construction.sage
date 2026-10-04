# 対象ラベル: claim_one_sided_closure_period_difference_turning
load(str(_difference_dir / '../periodic-plane-lift-period-turning/construction.sage'))

def difference_path(start, steps):
    result = [start]
    for step in steps:
        result.append(pt_add(result[-1], step))
    return result

def period_difference_cases():
    for row in period_turning_cases():
        L, m, k, P, B = (row[key] for key in ('L', 'm', 'k', 'P', 'B'))
        wv, wh = B[0] // L, B[1] // L
        if wh == 0 and wv == 0:
            continue
        transverse = (wh, -wv)
        transverse_steps = ([(sign(wh), 0)] * abs(wh)
                            + [(0, -sign(wv))] * abs(wv))
        C = difference_path((0, 0), transverse_steps)
        horizontal = [(0, sign(wh))] * (L * abs(wh))
        vertical = [(sign(wv), 0)] * (L * abs(wv))
        parallel_steps = horizontal + vertical if wh*wv > 0 else vertical + horizontal
        G = difference_path((0, 0), parallel_steps)
        n, transverse_length = len(parallel_steps), len(transverse_steps)
        t, c = 1 + k % 2, 1 + m % 3
        b = t * transverse_length
        S = pt_lift(P, B, k)
        def D(i):
            q, s = divmod(i, transverse_length)
            return pt_add(pt_scale(q, transverse), C[s])
        u = row['u']
        v = tuple(pt_sub(D(i+1), D(i)) for i in range(b))
        r = tuple(pt_scale(-1, step) for step in parallel_steps)
        x = tuple(pt_sub(D(b-i-1), D(b-i)) for i in range(b))
        kappa = lambda point: wh*point[0] - wv*point[1]
        maximum = max(kappa(point) for point in P[:-1])
        at_maximum = kappa(S) == maximum
        projection_nonbacktracking = []
        projected_sums, step_sums, repeated_sums = [], [], []
        for q in (c, c+1):
            lift = [pt_lift(P, B, k+j) for j in range(q*m+1)]
            upper = [pt_add(pt_add(S, pt_scale(q, B)), D(i)) for i in range(b+1)]
            returning = [pt_sub(pt_add(pt_add(S, pt_scale(t, transverse)),
                                      pt_scale(q-i//n, B)), G[i % n]) for i in range(q*n+1)]
            lower = [pt_add(S, D(b-i)) for i in range(b+1)]
            assert lift[-1] == upper[0] and upper[-1] == returning[0]
            assert returning[-1] == lower[0] and lower[-1] == lift[0]
            points = lift + upper[1:] + returning[1:] + lower[1:]
            steps = tuple(pt_sub(points[j+1], points[j]) for j in range(len(points)-1))
            edges = tuple(pt_project(L, points[j], step) for j, step in enumerate(steps))
            projection_nonbacktracking.append(
                all(pt_endpoints(L, edges[j])[1] == pt_endpoints(L, edges[(j+1) % len(edges)])[0]
                    and edges[(j+1) % len(edges)] != (edges[j][0], 1-edges[j][1])
                    for j in range(len(edges))))
            repeated = u*q + v + r*q + x
            assert len(steps) == q*m + b + q*n + b
            # 点列の整数除法による構成と、四つの固定歩列の反復を独立に比較する。
            assert steps == repeated
            assert points == difference_path(S, repeated)
            projected_sums.append(sum(pt_direction_turn(L, edges[j], edges[(j+1) % len(edges)])
                                      for j in range(len(edges))))
            step_sums.append(pt_cyclic_weight(steps))
            repeated_sums.append(pt_cyclic_weight(repeated))
        negated_points = tuple(pt_scale(-1, p) for p in G)
        negated_edges = tuple(pt_project(L, negated_points[j], r[j]) for j in range(n))
        return_turn = sum(pt_tau(L, negated_edges[j], negated_edges[(j+1) % n]) for j in range(n))
        period_sum, return_sum, original = pt_cyclic_weight(u), pt_cyclic_weight(r), row['turns']
        stages = (projected_sums[1] - projected_sums[0],
                  step_sums[1] - projected_sums[0],
                  step_sums[1] - step_sums[0],
                  repeated_sums[1] - step_sums[0],
                  repeated_sums[1] - repeated_sums[0],
                  period_sum + return_sum,
                  original + return_sum, original + ZZ(0), original)
        Pfirst = pt_lift(P, B, k+1)
        Plast = pt_lift(P, B, k+m)
        Pprevious = pt_lift(P, B, k+m-1)
        scalar = dict(
            period_end=(kappa(Plast), kappa(S), maximum),
            lift_last=(kappa(u[-1]), kappa(pt_sub(Plast, Pprevious)),
                       kappa(Plast)-kappa(Pprevious), maximum-kappa(Pprevious)),
            lift_first=(kappa(u[0]), kappa(pt_sub(Pfirst, S)),
                        kappa(Pfirst)-kappa(S), kappa(Pfirst)-maximum),
            return_first=(kappa(r[0]), kappa(pt_scale(-1, pt_sub(G[1], G[0]))),
                          -kappa(G[1])+kappa(G[0]), -kappa(G[1])),
            return_last=(kappa(r[-1]), kappa(pt_scale(-1, pt_sub(G[n], G[n-1]))),
                         -kappa(G[n])+kappa(G[n-1]), kappa(G[n-1])),
            lower=[(kappa(x[i]), kappa(pt_scale(-1, v[b-i-1])), -kappa(v[b-i-1]))
                   for i in range(b)],
            shift=(kappa(B), wh*L*wv-wv*L*wh, ZZ(0)),
            ends=(kappa(G[0]), kappa(G[n])),
            joins=((kappa(v[0]), -kappa(u[-1])), (kappa(v[-1]), -kappa(r[0])),
                   (kappa(x[0]), -kappa(r[-1])), (kappa(x[-1]), -kappa(u[0]))),
            increasing=all(kappa(step) > 0 for step in v),
            parts=all(word[(j+1) % len(word)] != pt_scale(-1, word[j])
                      for word in (u, v, r, x) for j in range(len(word))),
            projected=all(projection_nonbacktracking))
        yield dict(stages=stages, scalar=scalar, at_maximum=at_maximum,
                   period_sum=period_sum, return_sum=return_sum,
                   return_turn=return_turn, original=original, m=m, n=n, k=k, L=L, t=t, c=c)
