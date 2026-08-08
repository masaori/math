/-
章「固有値の代数性」の「軌道による行配位の全体の分割」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 2 件
（`claim_row_config_orbit_mem_eq` / `claim_row_config_orbit_disjoint_or_eq`）と
定義 1 件（`def_row_config_orbit_set`）と主張 1 件（`claim_row_config_orbit_partition`）に対応する。

  人手証明                                    このファイル
  包含の補題（証明の冒頭に置いたもの）          rowShiftOrbit_subset_of_mem
  τ ∈ O(τ)                                    self_mem_rowShiftOrbit
  k₀ = (e-1)m が τ へ戻すこと                  rowShiftOrbit_eq_of_mem の hij
  τ' ∈ O(τ) ならば O(τ') = O(τ)                rowShiftOrbit_eq_of_mem
  交わるならば一致する                          rowShiftOrbit_eq_of_inter_nonempty
  𝒪_L（軌道の全体）                            rowShiftOrbitSet L
  𝒪_L は R_L の分割である                      rowShiftOrbitSet_partition

人手証明が「逆向きに辿る」のではなく「e·m 回の反復で前向きに辿り着く」形で書いてあるので、
この証明は S の全射性も単射性も使わない。mathlib の軌道の一般論・`Setoid.IsPartition` は
引いていない（引くと「交われば一致する」という人手証明の議論そのものが消える）。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位、回数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbit

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明が証明の冒頭に置いた包含の補題「`τ₂ ∈ O(τ₁)` ならば `O(τ₂) ⊂ O(τ₁)`」。 -/
theorem rowShiftOrbit_subset_of_mem {τ₁ τ₂ : RowConfig L} (hτ₂ : τ₂ ∈ rowShiftOrbit L τ₁) :
    rowShiftOrbit L τ₂ ⊆ rowShiftOrbit L τ₁ := by
  obtain ⟨n, hn⟩ := mem_rowShiftOrbit.mp hτ₂
  intro τ₃ hτ₃
  obtain ⟨k, hk⟩ := mem_rowShiftOrbit.mp hτ₃
  refine mem_rowShiftOrbit.mpr ⟨k + n, ?_⟩
  calc τ₃ = rowShiftIterate L k τ₂ := hk
    _ = rowShiftIterate L k (rowShiftIterate L n τ₁) := by rw [hn]
    _ = rowShiftIterate L (k + n) τ₁ := (rowShiftIterate_add k n τ₁).symm

/-- 人手証明の `τ ∈ O(τ)`（`k = 0` の場合。軌道の定義の中で述べてある）。 -/
theorem self_mem_rowShiftOrbit (τ : RowConfig L) : τ ∈ rowShiftOrbit L τ :=
  mem_rowShiftOrbit.mpr ⟨0, rfl⟩

/-- 人手証明の主張「軌道の元の軌道はもとの軌道に等しい」。

証明は人手証明どおり、包含の補題を 2 度当てる。2 度目のために `τ ∈ O(τ')` が要り、
そこで人手証明が取った反復の回数 `k₀ = (e-1)·m` をそのまま使う。 -/
theorem rowShiftOrbit_eq_of_mem (τ : RowConfig L) {τ' : RowConfig L}
    (hτ' : τ' ∈ rowShiftOrbit L τ) : rowShiftOrbit L τ' = rowShiftOrbit L τ := by
  obtain ⟨m, hm⟩ := mem_rowShiftOrbit.mp hτ'
  set e := rowShiftMinimalPeriod L τ with he
  have hepos : 1 ≤ e := rowShiftMinimalPeriod_pos τ
  -- (e-1)·m + m = e·m。ℕ の引き算が切り詰められないのは e ≥ 1 による
  have hem : (e - 1) * m + m = e * m := by
    obtain ⟨e', he'⟩ : ∃ e', e = e' + 1 := ⟨e - 1, by omega⟩
    rw [he']
    simp [Nat.succ_mul]
  -- τ ∈ O(τ')。e·m 回の反復がもとへ戻ることを使って前向きに辿り着く
  have hττ' : τ ∈ rowShiftOrbit L τ' := by
    refine mem_rowShiftOrbit.mpr ⟨(e - 1) * m, ?_⟩
    calc τ = rowShiftIterate L (e * m) τ :=
          (rowShiftIterate_mul τ (rowShiftIterate_minimalPeriod τ) m).symm
      _ = rowShiftIterate L ((e - 1) * m + m) τ := by rw [hem]
      _ = rowShiftIterate L ((e - 1) * m) (rowShiftIterate L m τ) :=
          rowShiftIterate_add _ m τ
      _ = rowShiftIterate L ((e - 1) * m) τ' := by rw [← hm]
  exact Finset.Subset.antisymm (rowShiftOrbit_subset_of_mem hτ')
    (rowShiftOrbit_subset_of_mem hττ')

/-- 人手証明の主張「2 つの軌道は一致するか互いに素である」。 -/
theorem rowShiftOrbit_eq_of_inter_nonempty (τ₁ τ₂ : RowConfig L)
    (hne : (rowShiftOrbit L τ₁ ∩ rowShiftOrbit L τ₂).Nonempty) :
    rowShiftOrbit L τ₁ = rowShiftOrbit L τ₂ := by
  obtain ⟨τ₃, hτ₃⟩ := hne
  rw [mem_inter] at hτ₃
  calc rowShiftOrbit L τ₁ = rowShiftOrbit L τ₃ := (rowShiftOrbit_eq_of_mem τ₁ hτ₃.1).symm
    _ = rowShiftOrbit L τ₂ := rowShiftOrbit_eq_of_mem τ₂ hτ₃.2

variable (L)

/-- 人手証明の軌道の全体 `𝒪_L = { O(τ) | τ ∈ R_L }`。

同じ軌道を 2 度数えないこと（人手証明が `𝒪_L` を集合として定めていること）は、
`Finset.image` が重複を持たないことにあたる。 -/
noncomputable def rowShiftOrbitSet : Finset (Finset (RowConfig L)) :=
  open Classical in univ.image (rowShiftOrbit L)

variable {L}

lemma mem_rowShiftOrbitSet {O : Finset (RowConfig L)} :
    O ∈ rowShiftOrbitSet L ↔ ∃ τ : RowConfig L, rowShiftOrbit L τ = O := by
  classical
  simp [rowShiftOrbitSet]

variable (L)

/-- 人手証明の主張「軌道の全体は行配位の全体の分割である」。

3 つの条件を人手証明と同じ順で示す（どの元も空でない・相異なる 2 元は互いに素・
合併が `R_L`）。 -/
theorem rowShiftOrbitSet_partition :
    (∀ O ∈ rowShiftOrbitSet L, O.Nonempty)
      ∧ (∀ O₁ ∈ rowShiftOrbitSet L, ∀ O₂ ∈ rowShiftOrbitSet L, O₁ ≠ O₂ → Disjoint O₁ O₂)
      ∧ (rowShiftOrbitSet L).biUnion id = (univ : Finset (RowConfig L)) := by
  classical
  refine ⟨?_, ?_, ?_⟩
  · -- どの元も空でない（τ ∈ O(τ) による）
    intro O hO
    obtain ⟨τ, hτ⟩ := mem_rowShiftOrbitSet.mp hO
    exact ⟨τ, hτ ▸ self_mem_rowShiftOrbit τ⟩
  · -- 相異なる 2 元は互いに素（交われば一致することの対偶）
    intro O₁ hO₁ O₂ hO₂ hne
    obtain ⟨τ₁, hτ₁⟩ := mem_rowShiftOrbitSet.mp hO₁
    obtain ⟨τ₂, hτ₂⟩ := mem_rowShiftOrbitSet.mp hO₂
    rw [Finset.disjoint_left]
    intro τ hτa hτb
    refine hne ?_
    rw [← hτ₁, ← hτ₂]
    exact rowShiftOrbit_eq_of_inter_nonempty τ₁ τ₂
      ⟨τ, mem_inter.mpr ⟨hτ₁ ▸ hτa, hτ₂ ▸ hτb⟩⟩
  · -- 合併が R_L（両包含）
    ext τ
    constructor
    · intro _
      exact mem_univ τ
    · intro _
      exact mem_biUnion.mpr
        ⟨rowShiftOrbit L τ, mem_rowShiftOrbitSet.mpr ⟨τ, rfl⟩, self_mem_rowShiftOrbit τ⟩

end Ising2DLambda.AlgebraicEigenvalue
