/-
章「固有値の代数性」の定義「軌道の上の全単射の転倒対の集合」と、主張
「互換の軌道への制限の符号は $-1$ である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_orbit_inversion_set`）と主張 1 件（`claim_orbit_transposition_sign`）に対応する。

  人手証明                                        このファイル
  Inv_O(ψ)                                        orbitInversionSet
  inv_O(ψ) = |Inv_O(ψ)|                           orbitInversionCount_eq_card
  M（τa ≺ τ ≺ τb を満たす τ の全体）               betweenSet
  A, B, C                                         leftPairs, rightPairs, {(a,b)}
  Inv_O(ψ) = A ∪ B ∪ C（両包含）                   orbitInversionSet_eq
  第一の主張（inv_O = 2|M| + 1）                   orbitTransposition_inversionCount
  第二の主張（sgn_O = -1）                         orbitTransposition_sign

mathlib の `Equiv.Perm.sign` や `Equiv.swap` の符号の一般論は引いていない
（引くと人手証明の数え上げがまるごと消える）。

住処: 人手証明のこれらのブロックは ℕ と ℤ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその部分集合、順序、数え上げ、整数 -1 の冪だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTransposition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

-- `τ ≺ τ'` ならば `τ ≠ τ'`（三分律の系）は `PermutationSign.lean` の `ne_of_rowConfigLess` を使う。

/-- 人手証明の準備で使う三分律の系。`τ ≺ τ'` と `τ' ≺ τ` は両立しない。 -/
theorem asymm_of_rowConfigLess {τ τ' : RowConfig L} (h : rowConfigLess L τ τ') :
    ¬ rowConfigLess L τ' τ := by
  rcases rowConfigLess_trichotomy (L := L) τ τ' with ⟨_, _, hna⟩ | ⟨hnl, _, _⟩ | ⟨hnl, _, _⟩
  · exact hna
  · exact absurd h hnl
  · exact absurd h hnl

/-- 人手証明の定義「軌道の上の全単射の転倒対の集合」
`Inv_O(ψ) = { (τ,τ') ∈ F(O,O) | ψ(τ') ≺ ψ(τ) }`。 -/
noncomputable def orbitInversionSet (L : ℕ) [NeZero L] (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) : Finset (RowConfig L × RowConfig L) :=
  (crossOrderedPairs L O O).filter fun p => rowConfigLess L (g p.2) (g p.1)

/-- 人手証明の「これは定義の書き換えであって新しい主張ではない」に対応する等式。 -/
theorem orbitInversionCount_eq_card (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) :
    orbitInversionCount L O g = (orbitInversionSet L O g).card := rfl

/-- 人手証明の `M = { τ ∈ O | τa ≺ τ かつ τ ≺ τb }`。 -/
noncomputable def betweenSet (L : ℕ) [NeZero L] (O : Finset (RowConfig L))
    (a b : RowConfig L) : Finset (RowConfig L) :=
  O.filter fun τ => rowConfigLess L a τ ∧ rowConfigLess L τ b

/-- 人手証明の `A = { (τa, τ) | τ ∈ M }`。 -/
noncomputable def leftPairs (L : ℕ) [NeZero L] (O : Finset (RowConfig L))
    (a b : RowConfig L) : Finset (RowConfig L × RowConfig L) :=
  (betweenSet L O a b).image fun τ => (a, τ)

/-- 人手証明の `B = { (τ, τb) | τ ∈ M }`。 -/
noncomputable def rightPairs (L : ℕ) [NeZero L] (O : Finset (RowConfig L))
    (a b : RowConfig L) : Finset (RowConfig L × RowConfig L) :=
  (betweenSet L O a b).image fun τ => (τ, b)

theorem mem_betweenSet {O : Finset (RowConfig L)} {a b τ : RowConfig L} :
    τ ∈ betweenSet L O a b ↔ τ ∈ O ∧ rowConfigLess L a τ ∧ rowConfigLess L τ b := by
  simp [betweenSet]

theorem mem_orbitInversionSet {O : Finset (RowConfig L)} {g : RowConfig L → RowConfig L}
    {p : RowConfig L × RowConfig L} :
    p ∈ orbitInversionSet L O g ↔
      (p.1 ∈ O ∧ p.2 ∈ O ∧ rowConfigLess L p.1 p.2) ∧ rowConfigLess L (g p.2) (g p.1) := by
  simp [orbitInversionSet, crossOrderedPairs, Finset.mem_filter, Finset.mem_product, and_assoc]

/-- 人手証明の集合の等号 `Inv_O(ψ) = A ∪ B ∪ C`（両包含で示す）。 -/
theorem orbitInversionSet_eq {O : Finset (RowConfig L)} {a b : RowConfig L}
    (ha : a ∈ O) (hb : b ∈ O) (hab : rowConfigLess L a b) :
    orbitInversionSet L O (orbitTransposition L a b)
      = leftPairs L O a b ∪ rightPairs L O a b ∪ {(a, b)} := by
  have hba : b ≠ a := fun h => (ne_of_rowConfigLess hab) h.symm
  ext p
  obtain ⟨τ, τ'⟩ := p
  constructor
  · -- ⊆ 方向。人手証明の 7 つの場合分けに対応する。
    intro hp
    rw [mem_orbitInversionSet] at hp
    obtain ⟨⟨hτ, hτ', hlt⟩, hinv⟩ := hp
    by_cases hτa : τ = a
    · subst hτa
      by_cases hτ'b : τ' = b
      · subst hτ'b
        simp
      · -- τ = τa かつ τ' ≠ τb（τ' = τa は τ ≺ τ' に反する）
        have hτ'a : τ' ≠ τ := fun h => (ne_of_rowConfigLess hlt) h.symm
        have h1 : orbitTransposition L τ b τ = b := by simp [orbitTransposition]
        have h2 : orbitTransposition L τ b τ' = τ' := by
          simp [orbitTransposition, hτ'a, hτ'b]
        rw [h1, h2] at hinv
        have hmem : τ' ∈ betweenSet L O τ b := mem_betweenSet.mpr ⟨hτ', hlt, hinv⟩
        exact Finset.mem_union_left _
          (Finset.mem_union_left _ (Finset.mem_image.mpr ⟨τ', hmem, rfl⟩))
    · by_cases hτb : τ = b
      · -- τ = τb の場合。τ' は τa でも τb でもありえない
        subst hτb
        have hτ'τ : τ' ≠ τ := fun h => (ne_of_rowConfigLess hlt) h.symm
        by_cases hτ'a : τ' = a
        · subst hτ'a
          exact absurd hlt (asymm_of_rowConfigLess hab)
        · have h1 : orbitTransposition L a τ τ = a := by simp [orbitTransposition, hτa]
          have h2 : orbitTransposition L a τ τ' = τ' := by
            simp [orbitTransposition, hτ'a, hτ'τ]
          rw [h1, h2] at hinv
          -- τa ≺ τb ≺ τ' から τa ≺ τ'、これは τ' ≺ τa と両立しない
          exact absurd (rowConfigLess_trans hab hlt) (asymm_of_rowConfigLess hinv)
      · by_cases hτ'b : τ' = b
        · -- τ' = τb かつ τ ∉ {τa, τb}
          subst hτ'b
          have h1 : orbitTransposition L a τ' τ = τ := by
            simp [orbitTransposition, hτa, hτb]
          have h2 : orbitTransposition L a τ' τ' = a := by
            simp [orbitTransposition, fun h : τ' = a => hba h]
          rw [h1, h2] at hinv
          have hmem : τ ∈ betweenSet L O a τ' := mem_betweenSet.mpr ⟨hτ, hinv, hlt⟩
          exact Finset.mem_union_left _
            (Finset.mem_union_right _ (Finset.mem_image.mpr ⟨τ, hmem, rfl⟩))
        · by_cases hτ'a : τ' = a
          · -- τ' = τa かつ τ ∉ {τa, τb}。τ ≺ τa ≺ τb と τb ≺ τ が両立しない
            subst hτ'a
            have h1 : orbitTransposition L τ' b τ = τ := by
              simp [orbitTransposition, hτa, hτb]
            have h2 : orbitTransposition L τ' b τ' = b := by simp [orbitTransposition]
            rw [h1, h2] at hinv
            exact absurd (rowConfigLess_trans hlt hab) (asymm_of_rowConfigLess hinv)
          · -- どちらも τa でも τb でもない。ψ が両方を動かさないので τ' ≺ τ、三分律に反する
            have h1 : orbitTransposition L a b τ = τ := by
              simp [orbitTransposition, hτa, hτb]
            have h2 : orbitTransposition L a b τ' = τ' := by
              simp [orbitTransposition, hτ'a, hτ'b]
            rw [h1, h2] at hinv
            exact absurd hinv (asymm_of_rowConfigLess hlt)
  · -- ⊇ 方向。人手証明の A・B・C それぞれについての確認に対応する。
    intro hp
    simp only [Finset.mem_union, Finset.mem_singleton, leftPairs, rightPairs,
      Finset.mem_image] at hp
    rcases hp with (⟨σ, hσ, hσeq⟩ | ⟨σ, hσ, hσeq⟩) | hCmem
    · obtain ⟨hσO, haσ, hσb⟩ := mem_betweenSet.mp hσ
      rw [← hσeq, mem_orbitInversionSet]
      refine ⟨⟨ha, hσO, haσ⟩, ?_⟩
      have hσa : σ ≠ a := fun h => (ne_of_rowConfigLess haσ) h.symm
      have h1 : orbitTransposition L a b a = b := by simp [orbitTransposition]
      have h2 : orbitTransposition L a b σ = σ := by
        simp [orbitTransposition, ne_of_rowConfigLess hσb, hσa]
      simp only [h1, h2]
      exact hσb
    · obtain ⟨hσO, haσ, hσb⟩ := mem_betweenSet.mp hσ
      rw [← hσeq, mem_orbitInversionSet]
      refine ⟨⟨hσO, hb, hσb⟩, ?_⟩
      have hσa : σ ≠ a := fun h => (ne_of_rowConfigLess haσ) h.symm
      have h1 : orbitTransposition L a b σ = σ := by
        simp [orbitTransposition, ne_of_rowConfigLess hσb, hσa]
      have h2 : orbitTransposition L a b b = a := by simp [orbitTransposition, hba]
      simp only [h1, h2]
      exact haσ
    · rw [hCmem, mem_orbitInversionSet]
      refine ⟨⟨ha, hb, hab⟩, ?_⟩
      have h1 : orbitTransposition L a b a = b := by simp [orbitTransposition]
      have h2 : orbitTransposition L a b b = a := by simp [orbitTransposition, hba]
      simp only [h1, h2]
      exact hab

theorem leftPairs_card {O : Finset (RowConfig L)} {a b : RowConfig L} :
    (leftPairs L O a b).card = (betweenSet L O a b).card :=
  Finset.card_image_of_injective _ (fun _ _ h => congrArg Prod.snd h)

theorem rightPairs_card {O : Finset (RowConfig L)} {a b : RowConfig L} :
    (rightPairs L O a b).card = (betweenSet L O a b).card :=
  Finset.card_image_of_injective _ (fun _ _ h => congrArg Prod.fst h)

/-- 人手証明の第一の主張。`inv_O(t^O) = 2|M| + 1` である。 -/
theorem orbitTransposition_inversionCount {O : Finset (RowConfig L)} {a b : RowConfig L}
    (ha : a ∈ O) (hb : b ∈ O) (hab : rowConfigLess L a b) :
    orbitInversionCount L O (orbitTransposition L a b)
      = 2 * (betweenSet L O a b).card + 1 := by
  classical
  -- A と B が互いに素であること（A の第 1 成分は τa、B の第 1 成分は τa と異なる）。
  have hAB : Disjoint (leftPairs L O a b) (rightPairs L O a b) := by
    rw [Finset.disjoint_left]
    rintro p hpA hpB
    simp only [leftPairs, rightPairs, Finset.mem_image] at hpA hpB
    obtain ⟨σ, hσ, hσeq⟩ := hpA
    obtain ⟨σ', hσ', hσ'eq⟩ := hpB
    obtain ⟨_, haσ', _⟩ := mem_betweenSet.mp hσ'
    have h1 : p.1 = a := by rw [← hσeq]
    have h2 : p.1 = σ' := by rw [← hσ'eq]
    exact (ne_of_rowConfigLess haσ') (h2.symm.trans h1).symm
  -- A ∪ B と C が互いに素であること（M の元は τa とも τb とも異なる）。
  have hC : Disjoint (leftPairs L O a b ∪ rightPairs L O a b) ({(a, b)} :
      Finset (RowConfig L × RowConfig L)) := by
    rw [Finset.disjoint_right]
    intro p hp hpU
    simp only [Finset.mem_singleton] at hp
    subst hp
    simp only [Finset.mem_union, leftPairs, rightPairs, Finset.mem_image] at hpU
    rcases hpU with ⟨σ, hσ, hσeq⟩ | ⟨σ, hσ, hσeq⟩
    · obtain ⟨_, _, hσb⟩ := mem_betweenSet.mp hσ
      exact (ne_of_rowConfigLess hσb) (congrArg Prod.snd hσeq)
    · obtain ⟨_, haσ, _⟩ := mem_betweenSet.mp hσ
      exact (ne_of_rowConfigLess haσ) (congrArg Prod.fst hσeq).symm
  calc orbitInversionCount L O (orbitTransposition L a b)
      = (orbitInversionSet L O (orbitTransposition L a b)).card :=
        orbitInversionCount_eq_card _ _
    _ = (leftPairs L O a b ∪ rightPairs L O a b ∪ {(a, b)}).card := by
        rw [orbitInversionSet_eq ha hb hab]
    _ = (leftPairs L O a b ∪ rightPairs L O a b).card + 1 := by
        rw [Finset.card_union_of_disjoint hC, Finset.card_singleton]
    _ = (leftPairs L O a b).card + (rightPairs L O a b).card + 1 := by
        rw [Finset.card_union_of_disjoint hAB]
    _ = (betweenSet L O a b).card + (betweenSet L O a b).card + 1 := by
        rw [leftPairs_card, rightPairs_card]
    _ = 2 * (betweenSet L O a b).card + 1 := by ring

/-- 人手証明の第二の主張。`sgn_O(t^O) = -1` である。 -/
theorem orbitTransposition_sign {O : Finset (RowConfig L)} {a b : RowConfig L}
    (ha : a ∈ O) (hb : b ∈ O) (hab : rowConfigLess L a b) :
    orbitPermSign L O (orbitTransposition L a b) = -1 := by
  have hcount := orbitTransposition_inversionCount ha hb hab
  calc orbitPermSign L O (orbitTransposition L a b)
      = (-1 : ℤ) ^ orbitInversionCount L O (orbitTransposition L a b) := rfl
    _ = (-1 : ℤ) ^ (2 * (betweenSet L O a b).card + 1) := by rw [hcount]
    _ = ((-1 : ℤ) ^ 2) ^ (betweenSet L O a b).card * (-1 : ℤ) ^ 1 := by
        rw [pow_add, pow_mul]
    _ = 1 ^ (betweenSet L O a b).card * (-1 : ℤ) := by norm_num
    _ = -1 := by simp

end Ising2DLambda.AlgebraicEigenvalue
