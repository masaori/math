from pathlib import Path
load(str(Path(__file__).resolve().parent.parent / "odd-orbit-selection" / "construction.sage"))

def sor_in_domain(sigma):
    return all(sigma[j] != j for j in range(len(sigma))) and bool(oso_odd_points(sigma))

def sor_reversal(sigma, rank):
    if not sor_in_domain(sigma):
        raise ValueError("the permutation is outside the domain of odd-orbit reversal")
    return oso_reverse(sigma, oso_selected(sigma, rank))
