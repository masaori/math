/-
# `{-1,1}` と行配位の集合（必要十分版の側の定義）

具体版の `SpinVal`・その `Fintype` の構造・`SpinConf`（`PartitionFunction/TransferMatrixRepresentation/DefinitionRowConfigurations.lean`。
人手 `def_row_configurations`）と、`{0,1}` と `{-1,1}` の全単射 `spinIdxEquiv`（`PartitionFunction/TransferMatrixRepresentation/DefinitionConfigBasisIso.lean`。
人手 `def_config_basis_iso` の成分ごとの全単射）を、必要十分版の側に同じ式で置いたものである。
必要十分版はこの名前だけを使い、具体版の定義を参照しない。具体版との一致（いずれも定義上の一致）は
導出 `PartitionFunction/TransferMatrixRepresentation/DefinitionRowConfigurationsFromNecSuf.lean` だけが述べる。

スピンの値を `ℝ` の部分集合 `{-1,1}` のまま置くのは、これを使う必要十分版（`NecSuf/OpenChainSpinSum.lean`）が
具体版の `Φ`・`ς` と同じ手順を踏むために人手の定義のまま固定しているからである（効いている性質はそのファイルの冒頭に書いた）。
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum

namespace Ising2D.NecSuf

/-- 具体版 `SpinVal` と同じ式: 人手の `{-1, 1} ⊂ ℝ`。 -/
abbrev SpinVal' : Type := {r : ℝ // r = 1 ∨ r = -1}

/-- 具体版の `Fintype SpinVal` と同じ式: `{-1, 1}` は有限集合（元は `1` と `-1` の 2 つ）。 -/
noncomputable instance instFintypeSpinVal' : Fintype SpinVal' :=
  Fintype.subtype {1, -1} (fun r => by simp)

/-- 具体版 `SpinConf` と同じ式: 人手の `𝔐 = Map({1,…,M_col}, {-1,1})`。 -/
abbrev SpinConf' (M : ℕ) : Type := Fin M → SpinVal'

/-- 具体版 `sgn` と同じ式: `{0,1}`（Lean の `Fin 2`）からスピン値への読み替え `0 ↦ 1`、`1 ↦ -1`。 -/
def sgn' : Fin 2 → ℝ := ![1, -1]

@[simp] theorem sgn'_zero : sgn' 0 = 1 := rfl
@[simp] theorem sgn'_one : sgn' 1 = -1 := rfl

theorem sgn'_mem (i : Fin 2) : sgn' i = 1 ∨ sgn' i = -1 := by
  fin_cases i <;> simp

/-- 具体版 `idxOfSpin` と同じ式: `+1 ↦ 0`、`-1 ↦ 1`。 -/
noncomputable def idxOfSpin' (s : SpinVal') : Fin 2 := if (s : ℝ) = 1 then 0 else 1

/-- 具体版 `spinOfIdx` と同じ式（`idxOfSpin'` の逆向き）。 -/
def spinOfIdx' (i : Fin 2) : SpinVal' := ⟨sgn' i, sgn'_mem i⟩

theorem sgn'_idxOfSpin' (s : SpinVal') : sgn' (idxOfSpin' s) = (s : ℝ) := by
  rcases s.2 with h | h
  · rw [idxOfSpin', if_pos h, sgn'_zero, h]
  · rw [idxOfSpin', if_neg (by rw [h]; norm_num), sgn'_one, h]

/-- 具体版 `spinIdxEquiv` と同じ式: 成分ごとの全単射 `{-1,1} → {0,1}`（逆写像は `spinOfIdx'`）。 -/
noncomputable def spinIdxEquiv' : SpinVal' ≃ Fin 2 where
  toFun := idxOfSpin'
  invFun := spinOfIdx'
  left_inv s := by
    apply Subtype.ext
    show sgn' (idxOfSpin' s) = (s : ℝ)
    rw [sgn'_idxOfSpin']
  right_inv i := by
    fin_cases i <;> simp [idxOfSpin', spinOfIdx', sgn'] <;> norm_num

end Ising2D.NecSuf
