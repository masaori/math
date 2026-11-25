/-
# 開鎖項 `D_0` と周期境界項 `G`（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`

| 人手 | Lean |
| --- | --- |
| `def_D0_open_chain_operator` の `D_0 := ∑_{m=1}^{M_col-1} σ^z_m σ^z_{m+1}` | `Ising2D.openChainD0` |
| `def_G_boundary_operator` の `G := σ^z_{M_col} σ^z_1` | `Ising2D.boundaryG` |

人手のサイトの添字 `m ∈ {1,…,M_col}` と Lean のサイト `m : Fin M` は、写像 `finIndexToZZ M`（`def_index_set_from_one_to_n`）で行き来する。
人手の和の添字 `m ∈ {1,…,M_col-1}` は、Lean では `Fin (M - 1)` の元 `j`（像は `finIndexToZZ (M - 1) j`）である。
人手はその `m` をそのままサイトの添字 `{1,…,M_col}` の元として `σ^z_m` に渡すので、Lean は `j` をサイト `Fin.castLE (Nat.sub_le M 1) j : Fin M`
へ移す（像が同じ整数であることは `finIndexToZZ_castLE`）。人手の `m+1` はそのサイトの `nextSite`
（像は `finIndexToZZ M m + 1_ℤ`。`finIndexToZZ_nextSite_of_lt`）である。
`castLE_sub_one_val_add_one_ne` は、和の添字から移したサイトが人手のサイト `M_col` でないこと（`m ≤ M_col - 1`）を述べる。
人手のサイト `1` と `M_col` は `Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2` の `firstSite`・`lastSite`。

人手は両定義で `M_col ∈ ℤ_{≥2}` を置くが、`G` はサイト `1` と `M_col` が在ること（`M ≠ 0`）だけで定まるので、Lean の仮定はそれだけにする。
`D_0` は Lean では仮定なしで定める。人手の `M_col - 1` は ℤ の差で、Lean の和の添字の個数 `M - 1` は ℕ の差である。
`M ≥ 1` では `ι_{ℕ→ℤ}(M - 1) = ι_{ℕ→ℤ}(M) - 1_ℤ` で両者は一致する。`M ≤ 1` の値（`M = 0` では ℕ の差が本文の定義域の外で `0 - 1 = 0`、
どちらも `Fin 0` の上の空の和）は人手の定義の範囲（`M_col ≥ 2`）の外である。この定義と `openChainEnergy` を使う主張
（`openChainD0_mulVec_basisVec`・`openChainEnergy_mem_int`・`H1plus_eq_bulk_sub_boundary` など）は、人手の `M_col ≥ 2` を仮定 `2 ≤ M` に置き、
`M ≤ 1` の値について述べない。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV1InZYEpsilon

namespace Ising2D

variable {M : ℕ}

/-- **人手 `def_D0_open_chain_operator`**: `D_0 := ∑_{m=1}^{M_col-1} σ^z_m σ^z_{m+1}`。 -/
noncomputable def openChainD0 (M : ℕ) : TensorPow M :=
  ∑ j : Fin (M - 1), sigmaZ (Fin.castLE (Nat.sub_le M 1) j) * sigmaZ (nextSite (Fin.castLE (Nat.sub_le M 1) j))

/-- 人手の和の添字 `m ∈ {1,…,M_col-1}` から移したサイト `Fin.castLE (Nat.sub_le M 1) j` は、人手のサイト `M_col` ではない
（Lean の `lastSign`・`nextSite` の場合分けの条件 `(m : ℕ) + 1 = M` が成り立たない）。

二つの添字の集合の元へ写像 `finIndexToZZ` で送って比べる（Lean だけの段の補題）: サイトの像は和の添字の像 `finIndexToZZ (M - 1) j` に等しく
（`finIndexToZZ_castLE`）、それは `ι_{ℕ→ℤ}(M - 1)` 以下である（`finIndexToZZ_bijective_onto_index_set` の値の範囲）。
一方、条件 `(m : ℕ) + 1 = M` はサイトの像が `ι_{ℕ→ℤ}(M)` であることと同値である（`finIndexToZZ_eq_iff_val_add_one_eq`）。
`j` が在るので `M - 1 ≥ 1`、したがって `ι_{ℕ→ℤ}(M - 1) < ι_{ℕ→ℤ}(M)` で、二つは両立しない（`ι` を `Nat.cast` へ移し ℤ と ℕ の一次の不等式で閉じる）。 -/
theorem castLE_sub_one_val_add_one_ne (j : Fin (M - 1)) :
    ((Fin.castLE (Nat.sub_le M 1) j : Fin M) : ℕ) + 1 ≠ M := by
  intro h
  have himage : finIndexToZZ M (Fin.castLE (Nat.sub_le M 1) j) = inclusionNNtoZZ M :=
    (finIndexToZZ_eq_iff_val_add_one_eq M _).2 h
  rw [finIndexToZZ_castLE] at himage
  have hrange := ((finIndexToZZ_bijective_onto_index_set (M - 1)).2.1 j).2
  have hj := j.isLt
  rw [himage] at hrange
  simp only [inclusionNNtoZZ_eq_natCast] at hrange
  omega

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
