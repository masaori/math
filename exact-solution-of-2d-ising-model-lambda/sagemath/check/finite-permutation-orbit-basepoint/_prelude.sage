from itertools import permutations

if "fpob_permutations" not in globals():
    fpob_permutations = [tuple(p) for m in range(7) for p in permutations(range(m))]

    def fpob_iterate(f, n, y):
        for _ in range(n):
            y = f[y]
        return y

    def fpob_inverse(sigma):
        return tuple(sigma.index(y) for y in range(len(sigma)))

    def fpob_orbit(sigma, y):
        support = set()
        for f in (sigma, fpob_inverse(sigma)):
            reached = set()
            z = y
            while z not in reached:
                reached.add(z)
                z = f[z]
            support.update(reached)
        return frozenset(support)

    def fpob_reachable(sigma, y):
        # 二方向の反復列とは別に、無向辺の隣接リストを探索する。
        neighbors = [set() for _ in sigma]
        for z, w in enumerate(sigma):
            neighbors[z].add(w)
            neighbors[w].add(z)
        reached = {y}
        pending = [y]
        while pending:
            z = pending.pop()
            for w in neighbors[z] - reached:
                reached.add(w)
                pending.append(w)
        return frozenset(reached)

    fpob_supports = {(sigma, y): fpob_reachable(sigma, y)
                     for sigma in fpob_permutations for y in range(len(sigma))}

    def fpob_points():
        for sigma in fpob_permutations:
            tau = fpob_inverse(sigma)
            for y in range(len(sigma)):
                yield sigma, tau, y

    def fpob_pairs():
        for sigma, tau, i in fpob_points():
            for y in range(len(sigma)):
                yield sigma, tau, i, y

    def fpob_steps():
        for sigma, tau, i, y in fpob_pairs():
            for n in range(2 * len(sigma) + 1):
                yield sigma, tau, i, y, n

    def fpob_reached_points():
        for sigma, tau, i in fpob_points():
            for n in range(2 * len(sigma) + 1):
                yield sigma, tau, i, n
