/-
主張「有限線型順序集合の相異なる二点の互換の符号は -1 である」
（`claim_transposition_sign_on_finite_ordered_set`）の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                        このファイル
  t_{a,b}（場合分けによる定義）                    finiteTransposition
  二回合成すると各元を元へ戻すので全単射           finiteTransposition_involutive・finiteTranspositionPerm
  二点の名前を交換しても同じ写像                   finiteTranspositionPerm_comm
  M, A, B, C                                      transpositionBetween, transpositionLeftPairs,
                                                  transpositionRightPairs, {(a,b)}
  I = A ∪ B ∪ C（場合分けによる両包含）            transpositionInversionSet_eq
  inv(t_{a,b}) = |M| + |M| + 1 = 2|M| + 1          finiteTransposition_inversionCount
  sgn(t_{a,b}) の四行                              finiteTransposition_sign

符号・転倒数・順序対の集合は、本文の定義 `def_permutation_sign` をそのまま書いた定義
（`sign`・`inversionCount`・`orderedPairs`）を使う。定理は一つも引かない。
mathlib の `Equiv.swap` と `Equiv.Perm.sign` の一般論も引かない（引くと数え上げが消える）。

住処: 有限集合の数え上げと整数 -1 の冪だけで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign inversionCount orderedPairs)

variable {J : Type*} [LinearOrder J]

/-- 人手証明の写像 `t_{a,b}`。 -/
def finiteTransposition (a b : J) (u : J) : J :=
  if u = a then b else if u = b then a else u

theorem finiteTransposition_apply_left (a b : J) : finiteTransposition a b a = b := by
  simp [finiteTransposition]

theorem finiteTransposition_apply_right (a b : J) : finiteTransposition a b b = a := by
  by_cases hba : b = a
  · subst hba; simp [finiteTransposition]
  · simp [finiteTransposition, hba]

theorem finiteTransposition_apply_of_ne (a b : J) {u : J} (hua : u ≠ a) (hub : u ≠ b) :
    finiteTransposition a b u = u := by
  simp [finiteTransposition, hua, hub]

/-- 人手証明の「互換は二回合成すると各元を元へ戻す」。 -/
theorem finiteTransposition_involutive (a b : J) (u : J) :
    finiteTransposition a b (finiteTransposition a b u) = u := by
  by_cases hua : u = a
  · subst hua; rw [finiteTransposition_apply_left, finiteTransposition_apply_right]
  · by_cases hub : u = b
    · subst hub; rw [finiteTransposition_apply_right, finiteTransposition_apply_left]
    · rw [finiteTransposition_apply_of_ne a b hua hub, finiteTransposition_apply_of_ne a b hua hub]

/-- 人手証明の「したがって全単射である」。逆写像は自分自身。 -/
def finiteTranspositionPerm (a b : J) : Equiv.Perm J where
  toFun := finiteTransposition a b
  invFun := finiteTransposition a b
  left_inv := finiteTransposition_involutive a b
  right_inv := finiteTransposition_involutive a b

theorem finiteTranspositionPerm_apply (a b u : J) :
    finiteTranspositionPerm a b u = finiteTransposition a b u := rfl

/-- 人手証明の「互換は二点の名前を交換しても同じ写像」。 -/
theorem finiteTranspositionPerm_comm (a b : J) :
    finiteTranspositionPerm a b = finiteTranspositionPerm b a := by
  ext u
  simp only [finiteTranspositionPerm_apply, finiteTransposition]
  by_cases hab : a = b
  · subst hab; rfl
  · by_cases hua : u = a
    · rw [hua]; simp [hab]
    · by_cases hub : u = b
      · rw [hub]; simp [Ne.symm hab]
      · simp [hua, hub]

variable [Fintype J]

/-- 人手証明の `M = { u | a ≺ u かつ u ≺ b }`。 -/
def transpositionBetween (a b : J) : Finset J :=
  univ.filter fun u => a < u ∧ u < b

/-- 人手証明の `A = { (a,u) | u ∈ M }`。 -/
def transpositionLeftPairs (a b : J) : Finset (J × J) :=
  (transpositionBetween a b).image fun u => (a, u)

/-- 人手証明の `B = { (u,b) | u ∈ M }`。 -/
def transpositionRightPairs (a b : J) : Finset (J × J) :=
  (transpositionBetween a b).image fun u => (u, b)

/-- 人手証明の `I = { (u,v) ∈ P | t(v) ≺ t(u) }`。 -/
def transpositionInversionSet (a b : J) : Finset (J × J) :=
  (orderedPairs (fun x y : J => x < y)).filter fun p =>
    finiteTransposition a b p.2 < finiteTransposition a b p.1

theorem mem_transpositionBetween {a b u : J} :
    u ∈ transpositionBetween a b ↔ a < u ∧ u < b := by
  simp [transpositionBetween]

theorem mem_transpositionInversionSet {a b : J} {p : J × J} :
    p ∈ transpositionInversionSet a b ↔
      p.1 < p.2 ∧ finiteTransposition a b p.2 < finiteTransposition a b p.1 := by
  simp [transpositionInversionSet, orderedPairs]

/-- 人手証明の集合の等号 `I = A ∪ B ∪ C`。`⊆` は人手証明の五つの場合分け、
`⊇` は三集合それぞれの確認に対応する。 -/
theorem transpositionInversionSet_eq {a b : J} (hab : a < b) :
    transpositionInversionSet a b =
      transpositionLeftPairs a b ∪ transpositionRightPairs a b ∪ {(a, b)} := by
  have hba : b ≠ a := ne_of_gt hab
  ext ⟨u, v⟩
  rw [mem_transpositionInversionSet]
  simp only [transpositionLeftPairs, transpositionRightPairs, mem_union, mem_image,
    mem_singleton, mem_transpositionBetween, Prod.mk.injEq]
  constructor
  · rintro ⟨huv, hinv⟩
    by_cases hua : u = a
    · -- u = a の場合。v = b、a ≺ v ≺ b、b ≺ v の三場合。
      subst hua
      have hvu : v ≠ u := ne_of_gt huv
      by_cases hvb : v = b
      · exact Or.inr ⟨rfl, hvb⟩
      · rw [finiteTransposition_apply_left, finiteTransposition_apply_of_ne u b hvu hvb] at hinv
        exact Or.inl (Or.inl ⟨v, ⟨huv, hinv⟩, rfl, rfl⟩)
    · by_cases hvb : v = b
      · -- v = b かつ u ≠ a の場合。a ≺ u ≺ b と u ≺ a の二場合。
        subst hvb
        have hub : u ≠ v := ne_of_lt huv
        rw [finiteTransposition_apply_right, finiteTransposition_apply_of_ne a v hua hub] at hinv
        exact Or.inl (Or.inr ⟨u, ⟨hinv, huv⟩, rfl, rfl⟩)
      · by_cases hva : v = a
        · -- v = a の場合。u ≺ a で、t(u) = u ≺ b = t(a) なので転倒ではない。
          subst hva
          have hub : u ≠ b := ne_of_lt (huv.trans hab)
          rw [finiteTransposition_apply_left, finiteTransposition_apply_of_ne v b hua hub] at hinv
          exact absurd (huv.trans hab) (not_lt_of_gt hinv)
        · by_cases hub : u = b
          · -- u = b の場合。b ≺ v で、t(b) = a ≺ v = t(v) なので転倒ではない。
            subst hub
            rw [finiteTransposition_apply_right, finiteTransposition_apply_of_ne a u hva hvb] at hinv
            exact absurd (hab.trans huv) (not_lt_of_gt hinv)
          · -- u, v ∉ {a, b} の場合。互換は両方を動かさない。
            rw [finiteTransposition_apply_of_ne a b hua hub,
              finiteTransposition_apply_of_ne a b hva hvb] at hinv
            exact absurd huv (not_lt_of_gt hinv)
  · rintro ((⟨w, ⟨haw, hwb⟩, rfl, rfl⟩ | ⟨w, ⟨haw, hwb⟩, rfl, rfl⟩) | ⟨rfl, rfl⟩)
    · -- A の元 (a, w)：t(w) = w ≺ b = t(a)。
      refine ⟨haw, ?_⟩
      rw [finiteTransposition_apply_left,
        finiteTransposition_apply_of_ne _ _ (ne_of_gt haw) (ne_of_lt hwb)]
      exact hwb
    · -- B の元 (w, b)：t(b) = a ≺ w = t(w)。
      refine ⟨hwb, ?_⟩
      rw [finiteTransposition_apply_right,
        finiteTransposition_apply_of_ne _ _ (ne_of_gt haw) (ne_of_lt hwb)]
      exact haw
    · -- C の元 (a, b)：t(b) = a ≺ b = t(a)。
      refine ⟨hab, ?_⟩
      rw [finiteTransposition_apply_left, finiteTransposition_apply_right]
      exact hab

/-- 人手証明の転倒数の二行 `inv(t_{a,b}) = |M| + |M| + 1 = 2|M| + 1`。
互いに素であることと `|A| = |B| = |M|`、`|C| = 1` を先に示す。 -/
theorem finiteTransposition_inversionCount {a b : J} (hab : a < b) :
    inversionCount (fun x y : J => x < y) (finiteTranspositionPerm a b) =
      2 * (transpositionBetween a b).card + 1 := by
  have hAB : Disjoint (transpositionLeftPairs a b) (transpositionRightPairs a b) := by
    rw [Finset.disjoint_left]
    rintro p hpA hpB
    simp only [transpositionLeftPairs, transpositionRightPairs, mem_image] at hpA hpB
    obtain ⟨w, -, rfl⟩ := hpA
    obtain ⟨w', hw', hw'eq⟩ := hpB
    have haw' := (mem_transpositionBetween.mp hw').1
    exact (ne_of_lt haw') (congrArg Prod.fst hw'eq).symm
  have hC : Disjoint (transpositionLeftPairs a b ∪ transpositionRightPairs a b)
      ({(a, b)} : Finset (J × J)) := by
    rw [Finset.disjoint_right]
    intro p hp hpU
    rw [mem_singleton] at hp
    subst hp
    simp only [mem_union, transpositionLeftPairs, transpositionRightPairs, mem_image] at hpU
    rcases hpU with ⟨w, hw, hweq⟩ | ⟨w, hw, hweq⟩
    · exact (ne_of_lt (mem_transpositionBetween.mp hw).2) (congrArg Prod.snd hweq)
    · exact (ne_of_lt (mem_transpositionBetween.mp hw).1) (congrArg Prod.fst hweq).symm
  have hAcard : (transpositionLeftPairs a b).card = (transpositionBetween a b).card :=
    card_image_of_injective _ (fun _ _ h => congrArg Prod.snd h)
  have hBcard : (transpositionRightPairs a b).card = (transpositionBetween a b).card :=
    card_image_of_injective _ (fun _ _ h => congrArg Prod.fst h)
  calc inversionCount (fun x y : J => x < y) (finiteTranspositionPerm a b)
      = (transpositionInversionSet a b).card := rfl
    _ = (transpositionLeftPairs a b ∪ transpositionRightPairs a b ∪ {(a, b)}).card := by
        rw [transpositionInversionSet_eq hab]
    _ = (transpositionLeftPairs a b).card + (transpositionRightPairs a b).card + 1 := by
        rw [card_union_of_disjoint hC, card_union_of_disjoint hAB, card_singleton]
    _ = (transpositionBetween a b).card + (transpositionBetween a b).card + 1 := by
        rw [hAcard, hBcard]
    _ = 2 * (transpositionBetween a b).card + 1 := by ring

/-- 人手証明の符号の四行。`a ≺ b` の場合。 -/
theorem finiteTransposition_sign_of_lt {a b : J} (hab : a < b) :
    sign (fun x y : J => x < y) (finiteTranspositionPerm a b) = -1 := by
  calc sign (fun x y : J => x < y) (finiteTranspositionPerm a b)
      = (-1 : ℤ) ^ inversionCount (fun x y : J => x < y) (finiteTranspositionPerm a b) := rfl
    _ = (-1 : ℤ) ^ (2 * (transpositionBetween a b).card + 1) := by
        rw [finiteTransposition_inversionCount hab]
    _ = ((-1 : ℤ) ^ 2) ^ (transpositionBetween a b).card * (-1) := by
        rw [pow_add, pow_mul, pow_one]
    _ = -1 := by norm_num

/-- 主張の本体。三分律で `a ≺ b` か `b ≺ a` に分け、後者は名前を交換して前者へ帰着する。 -/
theorem finiteTransposition_sign {a b : J} (hab : a ≠ b) :
    sign (fun x y : J => x < y) (finiteTranspositionPerm a b) = -1 := by
  rcases lt_or_gt_of_ne hab with hlt | hgt
  · exact finiteTransposition_sign_of_lt hlt
  · rw [finiteTranspositionPerm_comm]
    exact finiteTransposition_sign_of_lt hgt

end Ising2DLambda.KacWard
