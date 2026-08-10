/-
章「固有値の代数性」の主張「軌道の上の全単射の符号は合成について乗法的である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_permutation_sign_mul`）に対応する。

  人手証明                                          このファイル
  準備の第一（ψ₁∘ψ₂ ∈ 𝔅_O）                        orbitComp_mem / orbitComp_injOn /
                                                    orbitComp_surjOn
  準備の第二（srt_{ψ₂} が定まる）                   orbitSortPair / orbitSortPair_mem
  準備の第三（srt_{ψ₂} が全単射）                   orbitSortPair_sortPair
  |A|, |B|, |C| と転倒数の一致                      orbitInversionCount_eq_card_sortPair
  各対で A, B, C に属するものの個数が偶数           orbit_parity_at_pair
  2 つの式変形                                      orbitPermSign_comp

人手証明が `ψ : O → O` と書くところを、前のセクションと同じく ambient の写像
`g : RowConfig L → RowConfig L` で受ける（`orbitPermSign` がその形で定義されている）。
`ψ₂` の逆写像も ambient の写像 `g₂'` として受け、`O` の上で両向きの往復が恒等写像である
ことを仮定する（`O` の外での値は台 `F(O,O) ⊂ O × O` に効かない）。

mathlib の `Equiv.Perm.sign` は引いていない（引くと転倒数で定めるという人手証明の定義が消える）。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは個数（ℕ）と符号（ℤ）だけである）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignValues

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の準備の第一の一部。`O` を保つ 2 つの写像の合成は `O` を保つ。 -/
theorem orbitComp_mem {O : Finset (RowConfig L)} {g₁ g₂ : RowConfig L → RowConfig L}
    (h₁ : ∀ τ ∈ O, g₁ τ ∈ O) (h₂ : ∀ τ ∈ O, g₂ τ ∈ O) :
    ∀ τ ∈ O, g₁ (g₂ τ) ∈ O := fun τ hτ => h₁ _ (h₂ τ hτ)

/-- 人手証明の準備の第一の単射性。`ψ₁(ψ₂(τ)) = ψ₁(ψ₂(τ'))` から `τ = τ'` を出す。 -/
theorem orbitComp_injOn {O : Finset (RowConfig L)} {g₁ g₂ : RowConfig L → RowConfig L}
    (h₂ : ∀ τ ∈ O, g₂ τ ∈ O)
    (hinj₁ : ∀ τ ∈ O, ∀ τ' ∈ O, g₁ τ = g₁ τ' → τ = τ')
    (hinj₂ : ∀ τ ∈ O, ∀ τ' ∈ O, g₂ τ = g₂ τ' → τ = τ') :
    ∀ τ ∈ O, ∀ τ' ∈ O, g₁ (g₂ τ) = g₁ (g₂ τ') → τ = τ' := by
  intro τ hτ τ' hτ' h
  exact hinj₂ τ hτ τ' hτ' (hinj₁ _ (h₂ τ hτ) _ (h₂ τ' hτ') h)

/-- 人手証明の準備の第一の全射性。`ψ₁` の全射性で `υ` を取り、`ψ₂` の全射性で `τ` を取る。 -/
theorem orbitComp_surjOn {O : Finset (RowConfig L)} {g₁ g₂ : RowConfig L → RowConfig L}
    (hsurj₁ : ∀ τ ∈ O, ∃ υ ∈ O, g₁ υ = τ)
    (hsurj₂ : ∀ τ ∈ O, ∃ υ ∈ O, g₂ υ = τ) :
    ∀ τ'' ∈ O, ∃ τ ∈ O, g₁ (g₂ τ) = τ'' := by
  intro τ'' hτ''
  obtain ⟨υ, hυ, hυv⟩ := hsurj₁ τ'' hτ''
  obtain ⟨τ, hτ, hτv⟩ := hsurj₂ υ hυ
  exact ⟨τ, hτ, by rw [hτv, hυv]⟩

/-- `O` の上の左逆写像を持つ写像は `O` の上で単射である（人手証明が `ψ₂` の単射性として使う）。 -/
theorem injOn_of_leftInverse {O : Finset (RowConfig L)} {g g' : RowConfig L → RowConfig L}
    (hleft : ∀ τ ∈ O, g' (g τ) = τ) :
    ∀ τ ∈ O, ∀ τ' ∈ O, g τ = g τ' → τ = τ' := by
  intro τ hτ τ' hτ' h
  rw [← hleft τ hτ, ← hleft τ' hτ', h]

variable (L)

/-- 人手証明の写像 `srt_{ψ₂} : F(O,O) → F(O,O)`。像の 2 成分を `≺` について並べ直す。 -/
noncomputable def orbitSortPair (g : RowConfig L → RowConfig L)
    (p : RowConfig L × RowConfig L) : RowConfig L × RowConfig L :=
  if rowConfigLess L (g p.1) (g p.2) then (g p.1, g p.2) else (g p.2, g p.1)

variable {L}

/-- 人手証明の準備の第二。`srt_{ψ₂}` の値が `F(O,O)` に属すること。

三分律のうち「相異なる 2 点はどちらかが小さい」を使う（`ψ₂` の単射性から相異なることを出す）。 -/
theorem orbitSortPair_mem {O : Finset (RowConfig L)} {g : RowConfig L → RowConfig L}
    (hmem : ∀ τ ∈ O, g τ ∈ O)
    (hinj : ∀ τ ∈ O, ∀ τ' ∈ O, g τ = g τ' → τ = τ')
    {p : RowConfig L × RowConfig L} (hp : p ∈ crossOrderedPairs L O O) :
    orbitSortPair L g p ∈ crossOrderedPairs L O O := by
  obtain ⟨⟨h1, h2⟩, hlt⟩ := mem_crossOrderedPairs.mp hp
  have hne : p.1 ≠ p.2 := ne_of_rowConfigLess hlt
  have hgne : g p.1 ≠ g p.2 := fun h => hne (hinj p.1 h1 p.2 h2 h)
  by_cases h : rowConfigLess L (g p.1) (g p.2)
  · rw [mem_crossOrderedPairs]
    simp only [orbitSortPair, if_pos h]
    exact ⟨⟨hmem p.1 h1, hmem p.2 h2⟩, h⟩
  · have h' : rowConfigLess L (g p.2) (g p.1) := by
      rcases rowConfigLess_or_rowConfigLess hgne with h'' | h''
      · exact absurd h'' h
      · exact h''
    rw [mem_crossOrderedPairs]
    simp only [orbitSortPair, if_neg h]
    exact ⟨⟨hmem p.2 h2, hmem p.1 h1⟩, h'⟩

/-- 人手証明の準備の第三。`srt_{ψ₂}` を `ψ₂` の逆写像から作ったものと合わせると恒等写像になる。

人手証明どおり、`ψ₂(τ) ≺ ψ₂(τ')` の場合と `ψ₂(τ') ≺ ψ₂(τ)` の場合に分け、
どちらでも `τ ≺ τ'` に戻ることを見る。 -/
theorem orbitSortPair_sortPair {O : Finset (RowConfig L)} {g g' : RowConfig L → RowConfig L}
    (hleft : ∀ τ ∈ O, g' (g τ) = τ)
    {p : RowConfig L × RowConfig L} (hp : p ∈ crossOrderedPairs L O O) :
    orbitSortPair L g' (orbitSortPair L g p) = p := by
  obtain ⟨⟨h1, h2⟩, hlt⟩ := mem_crossOrderedPairs.mp hp
  have hnot : ¬ rowConfigLess L p.2 p.1 := not_rowConfigLess_of_rowConfigLess hlt
  by_cases h : rowConfigLess L (g p.1) (g p.2)
  · simp [orbitSortPair, h, hleft p.1 h1, hleft p.2 h2, hlt]
  · simp [orbitSortPair, h, hleft p.1 h1, hleft p.2 h2, hnot]

/-- 人手証明の `|C| = inv_O(ψ₁)`。並べ直しの写像で数え直しても転倒数は変わらない。 -/
theorem orbitInversionCount_eq_card_sortPair {O : Finset (RowConfig L)}
    {g₁ g₂ g₂' : RowConfig L → RowConfig L}
    (hmem₂ : ∀ τ ∈ O, g₂ τ ∈ O) (hmem₂' : ∀ τ ∈ O, g₂' τ ∈ O)
    (hleft : ∀ τ ∈ O, g₂' (g₂ τ) = τ) (hright : ∀ τ ∈ O, g₂ (g₂' τ) = τ) :
    orbitInversionCount L O g₁
      = ((crossOrderedPairs L O O).filter fun p =>
          rowConfigLess L (g₁ (orbitSortPair L g₂ p).2)
            (g₁ (orbitSortPair L g₂ p).1)).card := by
  have hinj₂ : ∀ τ ∈ O, ∀ τ' ∈ O, g₂ τ = g₂ τ' → τ = τ' := injOn_of_leftInverse hleft
  have hinj₂' : ∀ τ ∈ O, ∀ τ' ∈ O, g₂' τ = g₂' τ' → τ = τ' := injOn_of_leftInverse hright
  rw [orbitInversionCount]
  refine card_nbij' (orbitSortPair L g₂') (orbitSortPair L g₂) ?_ ?_ ?_ ?_
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨orbitSortPair_mem hmem₂' hinj₂' hq.1, ?_⟩
    rw [orbitSortPair_sortPair hright hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨orbitSortPair_mem hmem₂ hinj₂ hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact orbitSortPair_sortPair hright hq.1
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact orbitSortPair_sortPair hleft hp.1

/-- 人手証明の「各対について `A, B, C` のうち属するものの個数は偶数である」。

属するときだけ `-1` を掛けた 3 つぶんの積が `1` になる、と書いてある。 -/
theorem orbit_parity_at_pair {O : Finset (RowConfig L)} {g₁ g₂ : RowConfig L → RowConfig L}
    (hmem₂ : ∀ τ ∈ O, g₂ τ ∈ O)
    (hinj₂ : ∀ τ ∈ O, ∀ τ' ∈ O, g₂ τ = g₂ τ' → τ = τ')
    (hinj₁ : ∀ τ ∈ O, ∀ τ' ∈ O, g₁ τ = g₁ τ' → τ = τ')
    {p : RowConfig L × RowConfig L} (hp : p ∈ crossOrderedPairs L O O) :
    (if rowConfigLess L (g₁ (g₂ p.2)) (g₁ (g₂ p.1)) then (-1 : ℤ) else 1)
        * (if rowConfigLess L (g₁ (orbitSortPair L g₂ p).2)
              (g₁ (orbitSortPair L g₂ p).1) then (-1 : ℤ) else 1)
        * (if rowConfigLess L (g₂ p.2) (g₂ p.1) then (-1 : ℤ) else 1) = 1 := by
  obtain ⟨⟨h1, h2⟩, hlt⟩ := mem_crossOrderedPairs.mp hp
  have hne : p.1 ≠ p.2 := ne_of_rowConfigLess hlt
  have h₂ne : g₂ p.1 ≠ g₂ p.2 := fun h => hne (hinj₂ p.1 h1 p.2 h2 h)
  have h₁₂ne : g₁ (g₂ p.1) ≠ g₁ (g₂ p.2) := fun h =>
    h₂ne (hinj₁ _ (hmem₂ p.1 h1) _ (hmem₂ p.2 h2) h)
  by_cases h : rowConfigLess L (g₂ p.1) (g₂ p.2)
  · -- ψ₂(τ) ≺ ψ₂(τ') の場合。B に属さず、A の条件と C の条件が同じ。
    have hB : ¬ rowConfigLess L (g₂ p.2) (g₂ p.1) := not_rowConfigLess_of_rowConfigLess h
    by_cases hA : rowConfigLess L (g₁ (g₂ p.2)) (g₁ (g₂ p.1))
    · simp [orbitSortPair, h, hB, hA]
    · simp [orbitSortPair, h, hB, hA]
  · -- ψ₂(τ') ≺ ψ₂(τ) の場合。B に属し、A と C はちょうど一方。
    have hB : rowConfigLess L (g₂ p.2) (g₂ p.1) := by
      rcases rowConfigLess_or_rowConfigLess h₂ne with h' | h'
      · exact absurd h' h
      · exact h'
    by_cases hA : rowConfigLess L (g₁ (g₂ p.2)) (g₁ (g₂ p.1))
    · have hC : ¬ rowConfigLess L (g₁ (g₂ p.1)) (g₁ (g₂ p.2)) :=
        not_rowConfigLess_of_rowConfigLess hA
      simp [orbitSortPair, h, hB, hA, hC]
    · have hC : rowConfigLess L (g₁ (g₂ p.1)) (g₁ (g₂ p.2)) := by
        rcases rowConfigLess_or_rowConfigLess h₁₂ne with h' | h'
        · exact h'
        · exact absurd h' hA
      simp [orbitSortPair, h, hB, hA, hC]

/-- 人手証明の主張。軌道の上の全単射の符号は合成について乗法的である。

人手証明の 2 つの式変形をそのまま辿る。まず 3 つの符号の積が `1` であることを示し、
つぎに符号の 2 乗が `1` であること（`orbitPermSign_mul_self`）を使って結論を得る。 -/
theorem orbitPermSign_comp {O : Finset (RowConfig L)}
    {g₁ g₂ g₂' : RowConfig L → RowConfig L}
    (hmem₂ : ∀ τ ∈ O, g₂ τ ∈ O) (hmem₂' : ∀ τ ∈ O, g₂' τ ∈ O)
    (hleft : ∀ τ ∈ O, g₂' (g₂ τ) = τ) (hright : ∀ τ ∈ O, g₂ (g₂' τ) = τ)
    (hinj₁ : ∀ τ ∈ O, ∀ τ' ∈ O, g₁ τ = g₁ τ' → τ = τ') :
    orbitPermSign L O (fun τ => g₁ (g₂ τ))
      = orbitPermSign L O g₁ * orbitPermSign L O g₂ := by
  have hinj₂ : ∀ τ ∈ O, ∀ τ' ∈ O, g₂ τ = g₂ τ' → τ = τ' := injOn_of_leftInverse hleft
  -- 3 つの符号の積が 1 であること（人手証明の 1 つめの式変形）。
  have hprod : orbitPermSign L O (fun τ => g₁ (g₂ τ)) * orbitPermSign L O g₁
      * orbitPermSign L O g₂ = 1 := by
    rw [orbitPermSign, orbitPermSign, orbitPermSign,
      orbitInversionCount_eq_card_sortPair (g₁ := g₁) hmem₂ hmem₂' hleft hright]
    simp only [orbitInversionCount]
    rw [← prod_ite_neg_one (crossOrderedPairs L O O) fun p =>
        rowConfigLess L (g₁ (g₂ p.2)) (g₁ (g₂ p.1)),
      ← prod_ite_neg_one (crossOrderedPairs L O O) fun p =>
        rowConfigLess L (g₁ (orbitSortPair L g₂ p).2) (g₁ (orbitSortPair L g₂ p).1),
      ← prod_ite_neg_one (crossOrderedPairs L O O) fun p =>
        rowConfigLess L (g₂ p.2) (g₂ p.1),
      ← prod_mul_distrib, ← prod_mul_distrib]
    rw [prod_congr rfl fun p hp => orbit_parity_at_pair hmem₂ hinj₂ hinj₁ hp, prod_const_one]
  -- 両辺に sgn_O(ψ₁) sgn_O(ψ₂) を掛ける（人手証明の 2 つめの式変形）。
  calc orbitPermSign L O (fun τ => g₁ (g₂ τ))
      = orbitPermSign L O (fun τ => g₁ (g₂ τ)) * 1 * 1 := by ring
    _ = orbitPermSign L O (fun τ => g₁ (g₂ τ))
          * (orbitPermSign L O g₁ * orbitPermSign L O g₁)
          * (orbitPermSign L O g₂ * orbitPermSign L O g₂) := by
        rw [orbitPermSign_mul_self, orbitPermSign_mul_self]
    _ = (orbitPermSign L O (fun τ => g₁ (g₂ τ)) * orbitPermSign L O g₁
          * orbitPermSign L O g₂) * (orbitPermSign L O g₁ * orbitPermSign L O g₂) := by ring
    _ = 1 * (orbitPermSign L O g₁ * orbitPermSign L O g₂) := by rw [hprod]
    _ = orbitPermSign L O g₁ * orbitPermSign L O g₂ := by ring

end Ising2DLambda.AlgebraicEigenvalue
