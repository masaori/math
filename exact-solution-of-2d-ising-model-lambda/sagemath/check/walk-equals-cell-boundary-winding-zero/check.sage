"""Run exact checks for claim_walk_equals_cell_boundary_winding_zero."""

from pathlib import Path

check_dir = Path("sagemath/check/walk-equals-cell-boundary-winding-zero").resolve()
load(str(check_dir / "check_horizontal.sage"))
load(str(check_dir / "check_vertical.sage"))
load(str(check_dir / "check_two_cell_boundary.sage"))
print("PASS: boundary coefficients and both winding evaluations over ZZ")
