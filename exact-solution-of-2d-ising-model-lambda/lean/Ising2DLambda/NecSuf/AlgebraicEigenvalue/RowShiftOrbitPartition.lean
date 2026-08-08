/-
主張「軌道の元の軌道はもとの軌道に等しい」「2 つの軌道は一致するか互いに素である」
「軌道の全体は行配位の全体の分割である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbitPartition`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ（同じ包含の補題を 2 度当てる形・
同じ反復の回数 `k₀ = (e-1)m`・同じ 3 条件の順）。

  主張                          使っている性質
  orbit_subset_of_mem           何も要らない（反復の加法性だけ）。
  orbit_eq_of_mem               その点が 1 回以上の反復で戻ること**だけ**。
  orbit_eq_of_inter_nonempty    2 点それぞれについて上と同じこと。
  orbitSet_partition            すべての点について上と同じこと。

削れなかった仮定は 2 つで、いずれも理由が異なる。

1. 点ごとの周期の存在（`∃ k, 1 ≤ k ∧ iterLeft f k i = i`）。`i ∈ O(j)` を出すために、
   `e·m` 回の反復がもとへ戻ることを使う。人手証明が最小周期 `e(τ)` を引いているのに
   あたるが、**最小性は使っていない**（`e` が最小であることはどの段にも現れない）。
2. `Fintype ι` と `DecidableEq ι`。軌道を `Finset` として書き、軌道の全体を
   `Finset (Finset ι)` として書くために要る。数え上げの中身には効いていない。

**`Function.Injective f` は仮定に入っていない。** 前の主張（軌道の元の個数）は単射性を
使っていたが、分割の側は使わない。人手証明が「逆向きに辿る代わりに `e·m` 回の反復で
前向きに辿り着く」形で書かれているためである。すなわち `S` が全単射であることは、
分割にはまったく効いていない。

mathlib の `Function.periodicOrbit` / 群作用の軌道の一般論 / `Setoid.IsPartition` は
引いていない。引くと「軌道が交われば一致する」という人手証明の議論そのものが、
既製の同値関係の性質へ置き換わる。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、回数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftOrbit

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 人手証明が証明の冒頭に置いた包含の補題「`j ∈ O(i)` ならば `O(j) ⊆ O(i)`」。

`j = f^[n](i)` と書き、`l = f^[k](j) = f^[k+n](i)` を見るだけである。
写像にも型にも何も要求していない（有限性と相等の判定は `Finset` の記法のためだけ）。 -/
theorem orbit_subset_of_mem (f : ι → ι) {i j : ι} (hj : j ∈ orbit f i) :
    orbit f j ⊆ orbit f i := by
  obtain ⟨n, hn⟩ := mem_orbit.mp hj
  intro l hl
  obtain ⟨k, hk⟩ := mem_orbit.mp hl
  refine mem_orbit.mpr ⟨k + n, ?_⟩
  calc l = iterLeft f k j := hk
    _ = iterLeft f k (iterLeft f n i) := by rw [hn]
    _ = iterLeft f (k + n) i := (iterLeft_add f k n i).symm

/-- 人手証明の `τ ∈ O(τ)`（`k = 0` の場合）。 -/
theorem self_mem_orbit (f : ι → ι) (i : ι) : i ∈ orbit f i :=
  mem_orbit.mpr ⟨0, rfl⟩

/-- 人手証明の主張「軌道の元の軌道はもとの軌道に等しい」。

証明は人手証明どおり、上の包含の補題を 2 度当てる。2 度目のために `i ∈ O(j)` が要り、
そこで人手証明が取った反復の回数 `k₀ = (e-1)·m` をそのまま使う。 -/
theorem orbit_eq_of_mem (f : ι → ι) (i : ι) (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i)
    {j : ι} (hj : j ∈ orbit f i) : orbit f j = orbit f i := by
  obtain ⟨m, hm⟩ := mem_orbit.mp hj
  set e := minimalPeriod f i h with he
  have hepos : 1 ≤ e := minimalPeriod_pos f i h
  -- (e-1)·m + m = e·m。ℕ の引き算が切り詰められないのは e ≥ 1 による
  have hem : (e - 1) * m + m = e * m := by
    obtain ⟨e', he'⟩ : ∃ e', e = e' + 1 := ⟨e - 1, by omega⟩
    rw [he']
    simp [Nat.succ_mul]
  -- i ∈ O(j)。前向きに e·m 回反復してもとへ戻る
  have hij : i ∈ orbit f j := by
    refine mem_orbit.mpr ⟨(e - 1) * m, ?_⟩
    calc i = iterLeft f (e * m) i := (iterLeft_mul f i e (iterLeft_minimalPeriod f i h) m).symm
      _ = iterLeft f ((e - 1) * m + m) i := by rw [hem]
      _ = iterLeft f ((e - 1) * m) (iterLeft f m i) := iterLeft_add f _ m i
      _ = iterLeft f ((e - 1) * m) j := by rw [← hm]
  exact Finset.Subset.antisymm (orbit_subset_of_mem f hj) (orbit_subset_of_mem f hij)

/-- 人手証明の主張「2 つの軌道は一致するか互いに素である」。 -/
theorem orbit_eq_of_inter_nonempty (f : ι → ι) (i₁ i₂ : ι)
    (h₁ : ∃ k, 1 ≤ k ∧ iterLeft f k i₁ = i₁) (h₂ : ∃ k, 1 ≤ k ∧ iterLeft f k i₂ = i₂)
    (hne : (orbit f i₁ ∩ orbit f i₂).Nonempty) : orbit f i₁ = orbit f i₂ := by
  obtain ⟨i₃, hi₃⟩ := hne
  rw [mem_inter] at hi₃
  calc orbit f i₁ = orbit f i₃ := (orbit_eq_of_mem f i₁ h₁ hi₃.1).symm
    _ = orbit f i₂ := orbit_eq_of_mem f i₂ h₂ hi₃.2

variable (ι)

/-- 人手証明の軌道の全体 `𝒪_L = { O(τ) | τ ∈ R_L }`。 -/
noncomputable def orbitSet (f : ι → ι) : Finset (Finset ι) :=
  open Classical in univ.image (orbit f)

variable {ι}

lemma mem_orbitSet {f : ι → ι} {O : Finset ι} :
    O ∈ orbitSet ι f ↔ ∃ i : ι, orbit f i = O := by
  classical
  simp [orbitSet]

/-- 人手証明の主張「軌道の全体は行配位の全体の分割である」。

3 つの条件を人手証明と同じ順で示す（空でない・相異なる 2 元は互いに素・合併が全体）。 -/
theorem orbitSet_partition (f : ι → ι) (h : ∀ i : ι, ∃ k, 1 ≤ k ∧ iterLeft f k i = i) :
    (∀ O ∈ orbitSet ι f, O.Nonempty)
      ∧ (∀ O₁ ∈ orbitSet ι f, ∀ O₂ ∈ orbitSet ι f, O₁ ≠ O₂ → Disjoint O₁ O₂)
      ∧ (orbitSet ι f).biUnion id = (univ : Finset ι) := by
  classical
  refine ⟨?_, ?_, ?_⟩
  · -- どの元も空でない（τ ∈ O(τ) による）
    intro O hO
    obtain ⟨i, hi⟩ := mem_orbitSet.mp hO
    exact ⟨i, hi ▸ self_mem_orbit f i⟩
  · -- 相異なる 2 元は互いに素（交われば一致することの対偶）
    intro O₁ hO₁ O₂ hO₂ hne
    obtain ⟨i₁, hi₁⟩ := mem_orbitSet.mp hO₁
    obtain ⟨i₂, hi₂⟩ := mem_orbitSet.mp hO₂
    rw [Finset.disjoint_left]
    intro a ha₁ ha₂
    refine hne ?_
    rw [← hi₁, ← hi₂]
    exact orbit_eq_of_inter_nonempty f i₁ i₂ (h i₁) (h i₂)
      ⟨a, mem_inter.mpr ⟨hi₁ ▸ ha₁, hi₂ ▸ ha₂⟩⟩
  · -- 合併が全体（両包含）
    ext a
    constructor
    · intro _
      exact mem_univ a
    · intro _
      exact mem_biUnion.mpr ⟨orbit f a, mem_orbitSet.mpr ⟨a, rfl⟩, self_mem_orbit f a⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
