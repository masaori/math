/-
# 開鎖項 `D_0` と周期境界項 `G`（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`

| 人手 | Lean |
| --- | --- |
| `def_D0_open_chain_operator` の `D_0 := ∑_{m=1}^{M_col-1} σ^z_m σ^z_{m+1}` | `Ising2D.openChainD0` |
| `def_G_boundary_operator` の `G := σ^z_{M_col} σ^z_1` | `Ising2D.boundaryG` |

Lean のサイト添字は 0 始まりなので、人手の `m ∈ {1,…,M_col-1}` は `(m : ℕ) + 1 ≠ M` なる `m : Fin M`、
人手の `m+1` はその範囲で `nextSite m`（値は `m + 1`。`nextSite_val_of_lt`）である。
人手のサイト `1` と `M_col` は `Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2` の `firstSite`・`lastSite`。

人手は両定義で `M_col ∈ ℤ_{≥2}` を置くが、`D_0` は仮定なしで、`G` はサイト `1` と `M_col` が在ること
（`M ≠ 0`）だけで定まるので、Lean の仮定はそれだけにする。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV1InZYEpsilon

namespace Ising2D

variable {M : ℕ}

/-- **人手 `def_D0_open_chain_operator`**: `D_0 := ∑_{m=1}^{M_col-1} σ^z_m σ^z_{m+1}`。 -/
noncomputable def openChainD0 (M : ℕ) : TensorPow M :=
  ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M), sigmaZ m * sigmaZ (nextSite m)

/-- **人手 `def_G_boundary_operator`**: `G := σ^z_{M_col} σ^z_1`。 -/
noncomputable def boundaryG (M : ℕ) (hM : M ≠ 0) : TensorPow M :=
  sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM)

/-- 人手のサイト `M_col` の次のサイトは `1`（周期規約 `σ_{M_col+1} := σ_1`）。 -/
theorem nextSite_lastSite (hM : M ≠ 0) : nextSite (lastSite M hM) = firstSite M hM := by
  apply Fin.val_injective
  rw [nextSite_val_of_last (by simp [lastSite]; omega)]
  rfl

end Ising2D
