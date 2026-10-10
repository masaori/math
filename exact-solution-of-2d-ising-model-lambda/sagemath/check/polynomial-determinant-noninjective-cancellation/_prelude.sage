from itertools import permutations, product

_nic_field = CyclotomicField(8)
_nic_zeta = _nic_field.gen()
_nic_ring = PolynomialRing(_nic_field, "x")
_nic_x = _nic_ring.gen()


def _nic_sum(values):
    return sum(values, _nic_ring.zero())


def _nic_prod(values):
    return prod(values, _nic_ring.one())


def _nic_sign(sigma):
    inversions = sum(1 for i in range(len(sigma))
                     for j in range(i + 1, len(sigma)) if sigma[j] < sigma[i])
    return ZZ(-1)^ZZ(inversions)


def _nic_compose(sigma, tau):
    return tuple(sigma[tau[i]] for i in range(len(sigma)))


def _nic_constant(integer):
    assert integer.parent() is ZZ
    return _nic_ring([_nic_field(integer)])


def _nic_build_rows():
    rows = {}
    stats = {"functions": 0, "collisions": 0, "permutations": 0,
             "matrix_collisions": 0, "subset_candidates": 0,
             "stable_subsets": 0, "nonempty_choices": 0,
             "dense_nonzero_weights": 0}

    def add(name, lhs, rhs):
        rows.setdefault(name, []).append((lhs, rhs))

    def structure(name, condition):
        assert isinstance(condition, bool), (name, type(condition))
        rows.setdefault("structure", []).append((name, condition))

    for n in (int(2), int(3)):
        J = tuple(range(n))
        perms = tuple(permutations(J))
        z, x = _nic_zeta, _nic_x
        matrices = (
            ("diagonal", matrix(_nic_ring, n, lambda i, j:
                (i + 1) + z*x if i == j else 0)),
            ("dense", matrix(_nic_ring, n, lambda i, j:
                _nic_field(1 if i == j else 0) + z^(1+i+2*j)*x + (1+i*n+j)*x^2)),
            ("sparse", matrix(_nic_ring, n, lambda i, j:
                (1 + z*x) if i == j else
                z^(i+1)*x^2 if j == (i+1) % n else 0)),
        )
        sign = {sigma: _nic_sign(sigma) for sigma in perms}
        coefficient = {sigma: _nic_constant(sign[sigma]) for sigma in perms}
        for kind, B in matrices:
            structure("matrix coefficient ring", B.base_ring() is _nic_ring)
            if kind == "dense":
                structure("nonrational coefficient", B[0, 0][1] not in QQ)
                injective_sum = _nic_sum(coefficient[sigma] *
                    _nic_prod(B[i, sigma[i]] for i in J) for sigma in perms)
                structure("injective control has constant coefficient one",
                          injective_sum[0] == _nic_field.one())

        for f in product(J, repeat=n):
            if len(set(f)) == n:
                continue
            stats["functions"] += 1
            for a, b in product(J, repeat=int(2)):
                if a == b or f[a] != f[b]:
                    continue
                stats["collisions"] += 1
                t = tuple(b if i == a else a if i == b else i for i in J)
                theta = {sigma: _nic_compose(sigma, t) for sigma in perms}
                add("collision_at_left_transposition", f[t[a]], f[b])
                add("collision_at_left_equal_image", f[b], f[a])
                add("collision_at_right_transposition", f[t[b]], f[a])
                add("collision_at_right_equal_image", f[a], f[b])
                for i in J:
                    if i != a and i != b:
                        add("collision_away_from_pair", f[t[i]], f[i])
                structure("transposition is a bijection", set(t) == set(J))
                structure("all row indices are preserved", all(f[t[i]] == f[i] for i in J))
                for sigma in perms:
                    stats["permutations"] += 1
                    paired = theta[sigma]
                    for i in J:
                        add("involution_outer_definition", theta[paired][i], paired[t[i]])
                        add("involution_inner_definition", paired[t[i]], sigma[t[t[i]]])
                        add("involution_transposition", sigma[t[t[i]]], sigma[i])
                    add("no_fixed_point_definition", paired[a], sigma[t[a]])
                    add("no_fixed_point_transposition", sigma[t[a]], sigma[b])
                    add("no_fixed_point_inequality", sigma[b], sigma[a])
                    add("sign_definition", sign[paired], _nic_sign(_nic_compose(sigma, t)))
                    add("sign_composition", _nic_sign(_nic_compose(sigma, t)),
                        sign[sigma]*_nic_sign(t))
                    add("sign_transposition", sign[sigma]*_nic_sign(t), sign[sigma]*ZZ(-1))
                    add("sign_negation", sign[sigma]*ZZ(-1), -sign[sigma])
                    structure("permutation involution", theta[paired] == sigma)
                    structure("no fixed point", paired != sigma)

                    # The exclusion hypotheses have these preimages, outside the remainder.
                    rho = paired
                    structure("preimage of first removed point", theta[rho] == sigma)
                    add("exclude_first_involution", rho, theta[theta[rho]])
                    add("exclude_first_substitution", theta[theta[rho]], theta[sigma])
                    rho = sigma
                    structure("preimage of second removed point", theta[rho] == theta[sigma])
                    add("exclude_second_involution", rho, theta[theta[rho]])
                    add("exclude_second_substitution", theta[theta[rho]], theta[theta[sigma]])
                    add("exclude_second_return", theta[theta[sigma]], sigma)

                stable_subsets = []
                for mask in range(int(2)^len(perms)):
                    stats["subset_candidates"] += 1
                    subset = frozenset(perms[k] for k in range(len(perms)) if (mask >> k) & 1)
                    if all(theta[sigma] in subset for sigma in subset):
                        stable_subsets.append(subset)
                structure("all invariant subsets enumerated",
                          len(stable_subsets) == int(2)^(len(perms)//int(2)))
                structure("empty subset included", frozenset() in stable_subsets)
                structure("whole permutation set included", frozenset(perms) in stable_subsets)
                for subset in stable_subsets:
                    for sigma in sorted(subset):
                        paired = theta[sigma]
                        remainder = (subset - {sigma}) - {paired}
                        structure("selected point belongs to subset", sigma in subset)
                        structure("partner survives first erase", paired in subset - {sigma})
                        structure("remainder is a proper subset", remainder < subset)
                        structure("cardinality strictly decreases", len(remainder) < len(subset))
                        structure("remainder is invariant", all(theta[rho] in remainder for rho in remainder))
                        for rho in sorted(remainder):
                            structure("first inverse image excluded", theta[rho] != sigma)
                            structure("second inverse image excluded", theta[rho] != paired)

                for kind, B in matrices:
                    stats["matrix_collisions"] += 1
                    P = {sigma: _nic_prod(B[f[i], sigma[i]] for i in J) for sigma in perms}
                    w = {sigma: coefficient[sigma]*P[sigma] for sigma in perms}
                    for sigma in perms:
                        paired = theta[sigma]
                        if kind == "dense":
                            structure("dense weight is nonzero", w[sigma] != _nic_ring.zero())
                            stats["dense_nonzero_weights"] += 1
                        product_chain = (
                            P[paired],
                            _nic_prod(B[f[i], paired[i]] for i in J),
                            _nic_prod(B[f[i], sigma[t[i]]] for i in J),
                            _nic_prod(B[f[t[i]], sigma[t[i]]] for i in J),
                            _nic_prod(B[f[j], sigma[j]] for j in J),
                            P[sigma],
                        )
                        for name, lhs, rhs in zip(("product_definition", "product_theta_definition",
                                "product_row_collision", "product_reindex", "product_fold"),
                                product_chain, product_chain[1:]):
                            add(name, lhs, rhs)
                        coefficient_chain = (
                            coefficient[paired],
                            _nic_constant(sign[paired]),
                            _nic_constant(-sign[sigma]),
                            _nic_ring([-_nic_field(sign[sigma])]),
                            -_nic_constant(sign[sigma]),
                            -coefficient[sigma],
                        )
                        for name, lhs, rhs in zip(("coefficient_definition", "coefficient_sign_negation",
                                "coefficient_integer_embedding", "coefficient_constant_embedding",
                                "coefficient_fold"), coefficient_chain, coefficient_chain[1:]):
                            add(name, lhs, rhs)
                        weight_chain = (
                            w[paired], coefficient[paired]*P[paired],
                            (-coefficient[sigma])*P[paired], (-coefficient[sigma])*P[sigma],
                            -(coefficient[sigma]*P[sigma]), -w[sigma],
                        )
                        for name, lhs, rhs in zip(("weight_definition", "weight_coefficient_negation",
                                "weight_product_invariance", "weight_negated_product", "weight_fold"),
                                weight_chain, weight_chain[1:]):
                            add(name, lhs, rhs)
                        add("pair_substitute_negative", w[sigma]+w[paired], w[sigma]+(-w[sigma]))
                        add("pair_additive_inverse", w[sigma]+(-w[sigma]), _nic_ring.zero())
                    add("empty_sum", _nic_sum(w[sigma] for sigma in ()), _nic_ring.zero())
                    for subset in stable_subsets:
                        stats["stable_subsets"] += 1
                        structure("invariant subset has zero sum",
                                  _nic_sum(w[rho] for rho in sorted(subset)) == _nic_ring.zero())
                        for sigma in sorted(subset):
                            stats["nonempty_choices"] += 1
                            paired = theta[sigma]
                            first_erase = subset - {sigma}
                            remainder = first_erase - {paired}
                            remaining_sum = _nic_sum(w[rho] for rho in sorted(remainder))
                            sum_chain = (
                                _nic_sum(w[rho] for rho in sorted(subset)),
                                w[sigma]+_nic_sum(w[rho] for rho in sorted(first_erase)),
                                w[sigma]+(w[paired]+remaining_sum),
                                (w[sigma]+w[paired])+remaining_sum,
                                _nic_ring.zero()+remaining_sum,
                                _nic_ring.zero()+_nic_ring.zero(),
                                _nic_ring.zero(),
                            )
                            for name, lhs, rhs in zip(("sum_erase_first", "sum_erase_second", "sum_associate",
                                    "sum_cancel_pair", "sum_induction_hypothesis", "sum_zero_addition"),
                                    sum_chain, sum_chain[1:]):
                                add(name, lhs, rhs)
                    add("whole_sum_definition", _nic_sum(coefficient[sigma] *
                        _nic_prod(B[f[i], sigma[i]] for i in J) for sigma in perms),
                        _nic_sum(w[sigma] for sigma in perms))
                    add("whole_sum_cancellation", _nic_sum(w[sigma] for sigma in perms), _nic_ring.zero())
    return rows, stats


def _nic_verify(name, kind):
    pairs = _nic_rows[name]
    assert pairs, (name, "no instances")
    for index, (lhs, rhs) in enumerate(pairs):
        if kind == "polynomial":
            assert lhs.parent() is _nic_ring and rhs.parent() is _nic_ring
        elif kind == "integer":
            assert lhs.parent() is ZZ and rhs.parent() is ZZ
        elif kind in ("index", "index_inequality"):
            assert type(lhs) is int and type(rhs) is int
            assert 0 <= lhs < 3 and 0 <= rhs < 3
        elif kind == "permutation":
            assert type(lhs) is tuple and type(rhs) is tuple
            assert len(lhs) == len(rhs) and len(lhs) in (2, 3)
            assert all(type(value) is int for value in lhs + rhs)
            assert set(lhs) == set(range(len(lhs))) and set(rhs) == set(range(len(rhs)))
        elif kind == "structure":
            assert isinstance(lhs, str) and type(rhs) is bool
            assert rhs is True, (lhs, index)
            continue
        else:
            raise ValueError("unknown comparison type: " + kind)
        if kind == "index_inequality":
            assert lhs != rhs, (name, index, lhs, rhs)
        else:
            assert lhs == rhs, (name, index, lhs, rhs)
    print("RESULT: PASS %s: %d exact %s checks" % (name, len(pairs), kind))
    return len(pairs)


if "_nic_rows" not in globals():
    _nic_rows, _nic_stats = _nic_build_rows()
