/-
# 開鎖項 `D_0` と周期境界項 `G`（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`

| 人手 | Lean |
| --- | --- |
| `def_D0_open_chain_operator` の `D_0 := ∑_{m=1}^{M_col-1} σ^z_m σ^z_{m+1}` | `Ising2D.openChainD0` |
| `def_G_boundary_operator` の `G := σ^z_{M_col} σ^z_1` | `Ising2D.boundaryG` |

人手のサイトの添字 `m ∈ {1,…,M_col}` と Lean のサイト `m : Fin M` は、写像 `finIndexToZZ M`（`def_index_set_from_one_to_n`）で行き来する。
人手の `m ∈ {1,…,M_col-1}`（像が `ι_{ℕ→ℤ}(M)` でないこと）を、Lean の定義 `openChainD0` は値の条件 `(m : ℕ) + 1 ≠ M` で書く
（二つの条件は `finIndexToZZ_eq_iff_val_add_one_eq` で移る）。人手の `m+1` はその範囲で `nextSite m`
（像は `finIndexToZZ M m + 1_ℤ`。`finIndexToZZ_nextSite_of_lt`）である。
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

/-- 人手のサイト `M_col` の次のサイトは `1`（周期規約 `σ_{M_col+1} := σ_1`）。

二つのサイトを人手の添字の集合 `{1,…,M_col}` の元へ写像 `finIndexToZZ M`（`def_index_set_from_one_to_n`）で送って比べる:
サイト `M_col` の像は `ι_{ℕ→ℤ}(M)`（`finIndexToZZ_lastSite`）なので、その次のサイトの像は `1_ℤ`（`finIndexToZZ_nextSite_of_last`。
その仮定の値の等式は `finIndexToZZ_eq_iff_val_add_one_eq` で像の等式から移す）、
サイト `1` の像も `1_ℤ`（`finIndexToZZ_firstSite`）。像が等しいサイトは等しい（`finIndexToZZ_bijective_onto_index_set` の単射）。 -/
theorem nextSite_lastSite (hM : M ≠ 0) : nextSite (lastSite M hM) = firstSite M hM := by
  apply (finIndexToZZ_bijective_onto_index_set M).1
  rw [finIndexToZZ_nextSite_of_last
        ((finIndexToZZ_eq_iff_val_add_one_eq M (lastSite M hM)).1 (finIndexToZZ_lastSite hM)),
      finIndexToZZ_firstSite hM]

end Ising2D
