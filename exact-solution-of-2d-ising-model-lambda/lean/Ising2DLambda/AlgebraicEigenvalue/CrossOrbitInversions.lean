/-
章「固有値の代数性」の「2 つの軌道にまたがる転倒対」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 3 件
（`def_cross_orbit_ordered_pairs` / `def_cross_orbit_ordered_pairs_image` /
`def_cross_orbit_inversions`）と主張 2 件
（`claim_cross_orbit_ordered_card` / `claim_cross_orbit_inversions_even`）に対応する。

  人手証明                                    このファイル
  F(O,O')                                     crossOrderedPairs
  F_φ(O,O')                                   crossOrderedPairsImage
  J_φ(O,O')                                   crossInversions
  Υ(τ,τ') = (φ(τ), φ(τ'))                     upsilon
  |F_φ(O,O')| = |F(O,O')|                     card_crossOrderedPairsImage
  O ≠ O' ならば O ∩ O' = ∅                    disjoint_of_ne_of_mem_orbitSet
  J_1 = F \ F_φ                               crossInversions_left_eq_sdiff
  sw が J_2 と F_φ \ F を対応させる            card_crossInversions_right
  |F \ F_φ| = |F_φ \ F|                       card_sdiff_eq_card_sdiff
  |J_φ(O,O')| = 2|F \ F_φ|                    card_crossInversions_eq_two_mul

mathlib の `Equiv.Perm.sign` / `Finset.sum_involution` / 群作用の軌道の一般論は引いていない
（引くと「まただ対を 2 つに分け、成分を入れ替える写像で対応させる」という人手証明の
数え上げが既製の定理へ置き換わる）。使ったのは `Finset.card_nbij'`（人手証明が
1 対 1 対応で個数を移す形そのもの）と、有限集合の差と共通部分の個数の基本補題だけである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitRestriction
import Mathlib.Data.Finset.Prod

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の `F(O,O') = { (τ,τ') ∈ O × O' | τ ≺ τ' }`。 -/
noncomputable def crossOrderedPairs (L : ℕ) [NeZero L] (O O' : Finset (RowConfig L)) :
    Finset (RowConfig L × RowConfig L) :=
  (O ×ˢ O').filter fun p => rowConfigLess L p.1 p.2

/-- 人手証明の `F_φ(O,O') = { (τ,τ') ∈ O × O' | φ(τ) ≺ φ(τ') }`。 -/
noncomputable def crossOrderedPairsImage (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L))
    (O O' : Finset (RowConfig L)) : Finset (RowConfig L × RowConfig L) :=
  (O ×ˢ O').filter fun p => rowConfigLess L (φ p.1) (φ p.2)

/-- 人手証明の `J_φ(O,O')`（`P_L` のうち成分が O と O' へ分かれて属する転倒対）。 -/
noncomputable def crossInversions (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L))
    (O O' : Finset (RowConfig L)) : Finset (RowConfig L × RowConfig L) :=
  (orderedPairs L).filter fun p =>
    ((p.1 ∈ O ∧ p.2 ∈ O') ∨ (p.1 ∈ O' ∧ p.2 ∈ O)) ∧ rowConfigLess L (φ p.2) (φ p.1)

lemma mem_crossOrderedPairs {O O' : Finset (RowConfig L)} {p : RowConfig L × RowConfig L} :
    p ∈ crossOrderedPairs L O O' ↔ (p.1 ∈ O ∧ p.2 ∈ O') ∧ rowConfigLess L p.1 p.2 := by
  simp [crossOrderedPairs, Finset.mem_filter, Finset.mem_product, and_assoc]

lemma mem_crossOrderedPairsImage {φ : Equiv.Perm (RowConfig L)} {O O' : Finset (RowConfig L)}
    {p : RowConfig L × RowConfig L} :
    p ∈ crossOrderedPairsImage L φ O O'
      ↔ (p.1 ∈ O ∧ p.2 ∈ O') ∧ rowConfigLess L (φ p.1) (φ p.2) := by
  simp [crossOrderedPairsImage, Finset.mem_filter, Finset.mem_product, and_assoc]

lemma mem_crossInversions {φ : Equiv.Perm (RowConfig L)} {O O' : Finset (RowConfig L)}
    {p : RowConfig L × RowConfig L} :
    p ∈ crossInversions L φ O O'
      ↔ rowConfigLess L p.1 p.2
        ∧ ((p.1 ∈ O ∧ p.2 ∈ O') ∨ (p.1 ∈ O' ∧ p.2 ∈ O))
        ∧ rowConfigLess L (φ p.2) (φ p.1) := by
  simp [crossInversions, Finset.mem_filter, mem_orderedPairs]

/-- 逆写像が軌道を保つこと（人手証明の Υ の全射性で使う「逆像を軌道の中に取る」段）。 -/
theorem inv_mem_of_orbitPreserving {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hτ : τ ∈ O) :
    φ⁻¹ τ ∈ O := by
  classical
  have h : O.image φ = O := image_orbit_eq_of_orbitPreserving hφ hO
  rw [← h] at hτ
  obtain ⟨σ, hσ, hστ⟩ := Finset.mem_image.mp hτ
  have : φ⁻¹ τ = σ := by
    rw [← hστ]
    simp
  rwa [this]

/-- 人手証明の主張「軌道を保つ置換はまたがる順序づけられた対の個数を変えない」。

証明は人手証明どおり、Υ(τ,τ') = (φ(τ), φ(τ')) が `F_φ` から `F` への全単射であることによる
（逆向きは `φ⁻¹` から同じ形で作る）。 -/
theorem card_crossOrderedPairsImage {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O O' : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) :
    (crossOrderedPairsImage L φ O O').card = (crossOrderedPairs L O O').card := by
  classical
  refine Finset.card_nbij' (fun p => (φ p.1, φ p.2)) (fun p => (φ⁻¹ p.1, φ⁻¹ p.2)) ?_ ?_ ?_ ?_
  · -- Υ が F_φ を F の中へ写す
    intro p hp
    simp only [Finset.mem_coe, mem_crossOrderedPairsImage] at hp
    simp only [Finset.mem_coe, mem_crossOrderedPairs]
    exact ⟨⟨mem_of_orbitPreserving hφ hO hp.1.1, mem_of_orbitPreserving hφ hO' hp.1.2⟩, hp.2⟩
  · -- 逆向きが F を F_φ の中へ写す
    intro p hp
    simp only [Finset.mem_coe, mem_crossOrderedPairs] at hp
    simp only [Finset.mem_coe, mem_crossOrderedPairsImage]
    refine ⟨⟨inv_mem_of_orbitPreserving hφ hO hp.1.1, inv_mem_of_orbitPreserving hφ hO' hp.1.2⟩, ?_⟩
    simpa using hp.2
  · intro p _
    simp
  · intro p _
    simp

/-- 相異なる 2 つの軌道は交わらない（`claim_row_config_orbit_disjoint_or_eq` の言い換え）。 -/
theorem disjoint_of_ne_of_mem_orbitSet {O O' : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) (hne : O ≠ O')
    {τ : RowConfig L} (h : τ ∈ O) (h' : τ ∈ O') : False := by
  obtain ⟨τ₀, rfl⟩ := mem_rowShiftOrbitSet.mp hO
  obtain ⟨τ₁, rfl⟩ := mem_rowShiftOrbitSet.mp hO'
  exact hne (rowShiftOrbit_eq_of_inter_nonempty τ₀ τ₁ ⟨τ, Finset.mem_inter.mpr ⟨h, h'⟩⟩)

section Distinct

variable {φ : Equiv.Perm (RowConfig L)} {O O' : Finset (RowConfig L)}

/-- 人手証明の `J_1`（第 1 成分が O にある側）。 -/
noncomputable def crossInversionsLeft (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L))
    (O O' : Finset (RowConfig L)) : Finset (RowConfig L × RowConfig L) :=
  (crossInversions L φ O O').filter fun p => p.1 ∈ O ∧ p.2 ∈ O'

/-- 人手証明の `J_2`（第 1 成分が O' にある側）。 -/
noncomputable def crossInversionsRight (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L))
    (O O' : Finset (RowConfig L)) : Finset (RowConfig L × RowConfig L) :=
  (crossInversions L φ O O').filter fun p => p.1 ∈ O' ∧ p.2 ∈ O

/-- 人手証明の「J_1 = F \ F_φ」。 -/
theorem crossInversions_left_eq_sdiff (hφ : OrbitPreserving L φ)
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) (hne : O ≠ O') :
    crossInversionsLeft L φ O O' = crossOrderedPairs L O O' \ crossOrderedPairsImage L φ O O' := by
  classical
  ext p
  simp only [crossInversionsLeft, Finset.mem_filter, Finset.mem_sdiff, mem_crossInversions,
    mem_crossOrderedPairs, mem_crossOrderedPairsImage]
  constructor
  · rintro ⟨⟨hlt, -, hinv⟩, hmem⟩
    exact ⟨⟨hmem, hlt⟩, fun h => not_rowConfigLess_of_rowConfigLess hinv h.2⟩
  · rintro ⟨⟨hmem, hlt⟩, hnot⟩
    -- φ p.1 ∈ O、φ p.2 ∈ O' で O ∩ O' = ∅ なので φ p.1 ≠ φ p.2。三分律で逆向きが出る。
    have h1 : φ p.1 ∈ O := mem_of_orbitPreserving hφ hO hmem.1
    have h2 : φ p.2 ∈ O' := mem_of_orbitPreserving hφ hO' hmem.2
    have hne' : φ p.1 ≠ φ p.2 := by
      intro h
      exact disjoint_of_ne_of_mem_orbitSet hO hO' hne h1 (h ▸ h2)
    have hinv : rowConfigLess L (φ p.2) (φ p.1) := by
      rcases rowConfigLess_or_rowConfigLess hne' with h | h
      · exact absurd ⟨hmem, h⟩ hnot
      · exact h
    exact ⟨⟨hlt, Or.inl hmem, hinv⟩, hmem⟩

/-- 人手証明の「sw が J_2 を F_φ \ F の上へ写す」。

この段は `φ` が軌道を保つことを使わない（使うのは O と O' が交わらないことだけである）ので、
`OrbitPreserving` を仮定に置いていない。人手証明でもこの段は像について何も言っていない。 -/
theorem card_crossInversions_right
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) (hne : O ≠ O') :
    (crossInversionsRight L φ O O').card
      = (crossOrderedPairsImage L φ O O' \ crossOrderedPairs L O O').card := by
  classical
  refine Finset.card_nbij' Prod.swap Prod.swap ?_ ?_ ?_ ?_
  · intro p hp
    simp only [Finset.mem_coe, crossInversionsRight, Finset.mem_filter, mem_crossInversions] at hp
    obtain ⟨⟨hlt, -, hinv⟩, hmem⟩ := hp
    simp only [Finset.mem_coe, Finset.mem_sdiff, mem_crossOrderedPairsImage, mem_crossOrderedPairs, Prod.swap]
    exact ⟨⟨⟨hmem.2, hmem.1⟩, hinv⟩, fun h => not_rowConfigLess_of_rowConfigLess hlt h.2⟩
  · intro q hq
    simp only [Finset.mem_coe, Finset.mem_sdiff, mem_crossOrderedPairsImage, mem_crossOrderedPairs] at hq
    obtain ⟨⟨hmem, himg⟩, hnot⟩ := hq
    -- q.1 ∈ O、q.2 ∈ O' で O ∩ O' = ∅ なので q.1 ≠ q.2。三分律で q.2 ≺ q.1 が出る。
    have hne' : q.1 ≠ q.2 := by
      intro h
      exact disjoint_of_ne_of_mem_orbitSet hO hO' hne hmem.1 (h ▸ hmem.2)
    have hlt : rowConfigLess L q.2 q.1 := by
      rcases rowConfigLess_or_rowConfigLess hne' with h | h
      · exact absurd ⟨hmem, h⟩ hnot
      · exact h
    simp only [Finset.mem_coe, crossInversionsRight, Finset.mem_filter, mem_crossInversions, Prod.swap]
    exact ⟨⟨hlt, Or.inr ⟨hmem.2, hmem.1⟩, himg⟩, ⟨hmem.2, hmem.1⟩⟩
  · intro p _
    simp
  · intro q _
    simp

/-- 人手証明の準備の第三「|F \ F_φ| = |F_φ \ F|」。 -/
theorem card_sdiff_eq_card_sdiff (hφ : OrbitPreserving L φ)
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) :
    (crossOrderedPairs L O O' \ crossOrderedPairsImage L φ O O').card
      = (crossOrderedPairsImage L φ O O' \ crossOrderedPairs L O O').card := by
  classical
  have hcard := card_crossOrderedPairsImage hφ hO hO'
  have h1 := Finset.card_sdiff_add_card_inter
    (crossOrderedPairs L O O') (crossOrderedPairsImage L φ O O')
  have h2 := Finset.card_sdiff_add_card_inter
    (crossOrderedPairsImage L φ O O') (crossOrderedPairs L O O')
  rw [Finset.inter_comm] at h2
  omega

/-- 人手証明の主張「2 つの相異なる軌道にまたがる転倒対の個数は偶数である」。

証明は人手証明どおり、J を J_1 と J_2 へ分け、J_1 が F \ F_φ に等しいこと、
J_2 が sw で F_φ \ F と 1 対 1 に対応すること、その 2 つの差の個数が等しいことを使う。 -/
theorem card_crossInversions_eq_two_mul (hφ : OrbitPreserving L φ)
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) (hne : O ≠ O') :
    (crossInversions L φ O O').card
      = 2 * (crossOrderedPairs L O O' \ crossOrderedPairsImage L φ O O').card := by
  classical
  -- J = J_1 ∪ J_2 で、この 2 つは交わらない（O ∩ O' = ∅ による）。
  have hright : crossInversionsRight L φ O O'
      = (crossInversions L φ O O').filter (fun p => ¬ (p.1 ∈ O ∧ p.2 ∈ O')) := by
    ext p
    simp only [crossInversionsRight, Finset.mem_filter, mem_crossInversions]
    constructor
    · rintro ⟨hJ, hp⟩
      refine ⟨hJ, ?_⟩
      rintro ⟨hpO, -⟩
      exact disjoint_of_ne_of_mem_orbitSet hO hO' hne hpO hp.1
    · rintro ⟨hJ, hnot⟩
      exact ⟨hJ, hJ.2.1.resolve_left hnot⟩
  have hsplit : (crossInversions L φ O O').card
      = (crossInversionsLeft L φ O O').card + (crossInversionsRight L φ O O').card := by
    rw [crossInversionsLeft, hright]
    exact (Finset.card_filter_add_card_filter_not
      (s := crossInversions L φ O O') (p := fun p => p.1 ∈ O ∧ p.2 ∈ O')).symm
  rw [hsplit, crossInversions_left_eq_sdiff hφ hO hO' hne,
    card_crossInversions_right hO hO' hne,
    ← card_sdiff_eq_card_sdiff hφ hO hO']
  ring

end Distinct

end Ising2DLambda.AlgebraicEigenvalue
