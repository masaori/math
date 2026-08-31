"""接続階段とその周期並進が二つの周期持ち上げを単純閉路へ閉じることを厳密検査する。

対象:
- def_periodic_lift_closure_cycle
- claim_periodic_lift_closure_is_simple_cycle

先行する接続階段の検査と同じ有限全列挙を使い、周期数 c = 1, 2, 3 のそれぞれについて
四部分を定義どおりに合成する。閉性、全ての連続差が単位格子ベクトルであること、
終点を除く頂点の相異なりを ZZ 上で検査する。さらに、三つの閉包の循環総回転数が
一致することと、順向き・逆向きの持ち上げ一周期分の循環回転数が相殺することを検査する。
"""

load("sagemath/check/first-hit-connecting-staircase/check.sage")


def periodic_lift_point(index, base_points, period):
    quotient, remainder = ZZ(index).quo_rem(ZZ(len(base_points)))
    representative = base_points[remainder]
    return (representative[0] + quotient * period[0],
            representative[1] + quotient * period[1])


def translated_lift_indices(point, base_points, period, shift):
    indices = []
    period_length = ZZ(len(base_points))
    for remainder, representative in enumerate(base_points):
        diff0 = point[0] - representative[0] - shift[0]
        diff1 = point[1] - representative[1] - shift[1]
        if period[0] != 0:
            quotient, residual = diff0.quo_rem(period[0])
            if residual == 0 and diff1 == quotient * period[1]:
                indices.append(quotient * period_length + remainder)
        else:
            quotient, residual = diff1.quo_rem(period[1])
            if residual == 0 and diff0 == quotient * period[0]:
                indices.append(quotient * period_length + remainder)
    return indices


def unit_step(left, right):
    return (right[0] - left[0], right[1] - left[1])


def step_turning(left_step, right_step):
    direction = {
        (ZZ(0), ZZ(1)): ZZ(0),
        (ZZ(1), ZZ(0)): ZZ(1),
        (ZZ(0), ZZ(-1)): ZZ(2),
        (ZZ(-1), ZZ(0)): ZZ(3),
    }
    difference = (direction[right_step] - direction[left_step]) % 4
    assert difference != 2
    if difference == 3:
        return ZZ(-1)
    return ZZ(difference)


def cyclic_total_turning(closed_points):
    assert closed_points[0] == closed_points[-1]
    steps = [unit_step(left, right)
             for left, right in zip(closed_points, closed_points[1:])]
    return sum(step_turning(steps[index], steps[(index + 1) % len(steps)])
               for index in range(len(steps)))


def periodic_direction_turning(start_index, base_points, period, reverse=False):
    period_length = len(base_points)
    if reverse:
        steps = [unit_step(periodic_lift_point(start_index - index, base_points, period),
                           periodic_lift_point(start_index - index - 1, base_points, period))
                 for index in range(period_length)]
    else:
        steps = [unit_step(periodic_lift_point(start_index + index, base_points, period),
                           periodic_lift_point(start_index + index + 1, base_points, period))
                 for index in range(period_length)]
    return sum(step_turning(steps[index], steps[(index + 1) % period_length])
               for index in range(period_length))


cycle_total = 0
closure_total = 0
closure_vertex_total = 0
turning_comparison_total = 0
for L in range(1, 4):
    oriented = edges(L)
    for first in oriented:
        frontier = [[first]]
        for length in range(1, L * L + 1):
            next_frontier = []
            for walk in frontier:
                targets = [endpoints(L, edge)[1] for edge in walk]
                if len(set(targets)) == len(targets) \
                        and walk[0] in successors(L, oriented, walk[-1]):
                    w_h = sum(seam_indicators(L, edge)[0] * ZZ(1 - 2 * edge[3])
                              for edge in walk)
                    w_v = sum(seam_indicators(L, edge)[1] * ZZ(1 - 2 * edge[3])
                              for edge in walk)
                    if (w_h, w_v) != (ZZ(0), ZZ(0)):
                        points = [(ZZ(endpoints(L, walk[0])[0][0]),
                                   ZZ(endpoints(L, walk[0])[0][1]))]
                        for edge in walk:
                            dr, dc = displacement(edge)
                            points.append((points[-1][0] + dr,
                                           points[-1][1] + dc))
                        reps = points[:len(walk)]
                        period = (ZZ(L) * w_v, ZZ(L) * w_h)
                        base_values = [transverse(rep, w_h, w_v) for rep in reps]
                        k_max = max(base_values)
                        k_min = min(base_values)
                        w_perp = w_h * w_h + w_v * w_v
                        d_perp = (w_h, -w_v)
                        u_min = (k_max - k_min) // w_perp + 1
                        top_bases = []
                        for quotient in range(-2, 3):
                            for remainder, representative in enumerate(reps):
                                base = (representative[0] + ZZ(quotient) * period[0],
                                        representative[1] + ZZ(quotient) * period[1])
                                if transverse(base, w_h, w_v) == k_max:
                                    top_bases.append((base, ZZ(quotient * len(reps) + remainder)))
                        assert len(top_bases) >= 1
                        stair = staircase(w_h, w_v)
                        for base, k_0 in top_bases:
                            assert periodic_lift_point(k_0, reps, period) == base
                            for u in (u_min, u_min + 1):
                                shift = (ZZ(u) * d_perp[0], ZZ(u) * d_perp[1])
                                walk_points = iterated_staircase(base, u, w_h, w_v, stair)
                                hits = [s for s in range(1, len(walk_points))
                                        if in_translated_lift(walk_points[s], reps, period, shift)]
                                assert len(hits) >= 1
                                h = min(hits)
                                connecting = walk_points[:h + 1]
                                hit_indices = translated_lift_indices(
                                    connecting[-1], reps, period, shift)
                                assert len(hit_indices) == 1
                                k_1 = hit_indices[0]
                                closure_turnings = []
                                for c in (ZZ(1), ZZ(2), ZZ(3)):
                                    translated_segment = [
                                        (periodic_lift_point(k, reps, period)[0] + shift[0],
                                         periodic_lift_point(k, reps, period)[1] + shift[1])
                                        for k in range(k_1 + 1, k_1 + c * len(reps) + 1)
                                    ]
                                    reversed_connector_translate = [
                                        (connecting[s][0] + c * period[0],
                                         connecting[s][1] + c * period[1])
                                        for s in range(h - 1, -1, -1)
                                    ]
                                    reversed_original_segment = [
                                        periodic_lift_point(k, reps, period)
                                        for k in range(k_0 + c * len(reps) - 1, k_0 - 1, -1)
                                    ]
                                    closure = (connecting + translated_segment
                                               + reversed_connector_translate
                                               + reversed_original_segment)
                                    expected_length = 2 * h + 2 * c * len(reps) + 1
                                    assert len(closure) == expected_length
                                    assert closure[0] == closure[-1]
                                    for left, right in zip(closure, closure[1:]):
                                        difference = (right[0] - left[0], right[1] - left[1])
                                        assert difference in {
                                            (ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)),
                                            (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)),
                                        }
                                    assert len(set(closure[:-1])) == len(closure) - 1
                                    closure_turnings.append(cyclic_total_turning(closure))
                                    closure_total += 1
                                    closure_vertex_total += len(closure)
                                forward_turning = periodic_direction_turning(
                                    k_1, reps, period)
                                reverse_turning = periodic_direction_turning(
                                    k_0, reps, period, reverse=True)
                                assert reverse_turning == -forward_turning
                                assert len(set(closure_turnings)) == 1
                                assert closure_turnings[1] - closure_turnings[0] \
                                    == forward_turning + reverse_turning
                                assert closure_turnings[2] - closure_turnings[1] \
                                    == forward_turning + reverse_turning
                                turning_comparison_total += 1
                        cycle_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks, "
      f"{closure_total} periodic-lift closures, {closure_vertex_total} closure "
      f"vertices, {turning_comparison_total} three-period turning comparisons "
      f"over L=1,2,3")
