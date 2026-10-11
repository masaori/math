from pathlib import Path
sfn_file = __file__
__file__ = str(Path(__file__).resolve().parent.parent / "selected-odd-orbit-reversal" / "_prelude.sage")
load(__file__)
__file__ = sfn_file

def sfn_iterate(f, n, a):
    value = a
    for _ in range(n):
        value = f[value]
    return value

if "sfn_odd_rows" not in globals():
    sfn_odd_rows = [dict(row, a=row["minimum"], b=row["sigma"][row["minimum"]],
        ell=len(row["subset"]), k=(len(row["subset"]) - 1) // 2)
        for row in sor_domain_cases()]
    sfn_two_rows = []
    for sigma in sor_permutations:
        for a, support in sor_supports[sigma].items():
            if len(support) == 2:
                inverse = oso_inverse(sigma)
                sfn_two_rows.append(dict(sigma=sigma, inverse=inverse, a=a,
                    b=sigma[a], subset=support, tau=oso_reverse(sigma, support), ell=2))
    assert len(sfn_odd_rows) == 172
    assert sfn_two_rows
    assert all(row["tau"] == row["sigma"] and row["a"] != row["b"] for row in sfn_two_rows)
    sfn_local_rows = sfn_odd_rows + sfn_two_rows

def sfn_iteration_rows():
    for row in sfn_two_rows:
        for f in (row["sigma"], row["inverse"]):
            for n in range(2 * len(f) + 2):
                yield row, f, n

sfn_results = globals().get("sfn_results", {})
def sfn_record(name, count):
    assert count > 0
    sfn_results[name] = count
    print(name + ": " + str(count) + " exact checks; PASS")
