/-
章「固有値の代数性」の置換と符号の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（ラベル `def_row_permutation` / `def_inversion_count` / `def_permutation_sign`）と主張 2 件
（`claim_permutation_sign_values` / `claim_permutation_sign_mul`）に対応する。

  人手証明                                  このファイル
  S_L（行配位の置換の全体）                 Equiv.Perm (RowConfig L)
  P_L（順序づけられた対の全体）             orderedPairs
  inv(φ)                                    inversionCount
  sgn(φ)                                    permSign
  第一の主張（sgn は ±1）                   permSign_eq_one_or_neg_one
  第二の主張（sgn の 2 乗は 1）             permSign_mul_self
  第三の主張（sgn(id) = 1）                 permSign_id（と inversionCount_id）
  乗法性の証明の準備の写像 Ψ                pairMap
  Ψ が P_L の中へ入ること                   pairMap_mem
  Ψ が全単射であること                      pairMap_pairMap / pairMap_pairMap_inv
  |C| = inv(φ)                              inversionCount_eq_card_pairMap
  各対で A, B, C が偶数個                   parity_at_pair
  乗法性                                    permSign_comp

置換を `Equiv.Perm` で書くのは、人手証明が「全単射 φ とその逆写像 φ⁻¹」を使うためである
（人手証明は Ψ の逆写像を ψ⁻¹ から作る）。合成の順序は mathlib の `(φ * ψ) a = φ (ψ a)` が
人手証明の `φ ∘ ψ` と同じである。

mathlib の `Equiv.Perm.sign` は引かない。引くと「転倒数で定める」という人手証明の定義そのものが
消えて、1 対 1 対応が壊れる。符号が置換の符号の通常の定義と一致することは
SageMath 側（`sagemath/check/permutation-sign`）で独立に確かめてある。

`≺` の判定（`rowConfigLessDecidable`）と、それを使う定義は `noncomputable` である。
`k_0` を `Nat.find`（自然数の整列性）で取っているためで、数学の内容ではなく Lean の
実行可能性の話である（SageMath 側では同じ `k_0` を最小値の探索として実際に計算している）。

住処: 人手証明のこれらのブロックは ℤ を宣言している。ここに ℝ / ℂ は現れない
（数え上げは ℕ、符号は ℤ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowConfigOrder
import Mathlib.Data.Fintype.Prod
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- `≺` は判定できる（`τ = τ'` かどうかを見て、異なるなら `k_0` の位置で `ε` を比べる）。 -/
noncomputable instance rowConfigLessDecidable (τ τ' : RowConfig L) : Decidable (rowConfigLess L τ τ') := by
  by_cases h : τ = τ'
  · exact isFalse (by rintro ⟨hne, -⟩; exact hne h)
  · exact decidable_of_iff _ (rowConfigLess_iff h).symm

/-- 人手証明の `P_L = {(τ,τ') | τ ≺ τ'}`。 -/
noncomputable def orderedPairs : Finset (RowConfig L × RowConfig L) :=
  univ.filter fun p => rowConfigLess L p.1 p.2

/-- 人手証明の `inv(φ)`。`φ` によって順序が入れ替わる対の個数。 -/
noncomputable def inversionCount (φ : Equiv.Perm (RowConfig L)) : ℕ :=
  ((orderedPairs L).filter fun p => rowConfigLess L (φ p.2) (φ p.1)).card

/-- 人手証明の `sgn(φ) = (-1)^{inv(φ)} ∈ ℤ`。 -/
noncomputable def permSign (φ : Equiv.Perm (RowConfig L)) : ℤ := (-1) ^ inversionCount L φ

variable {L}

lemma mem_orderedPairs {p : RowConfig L × RowConfig L} :
    p ∈ orderedPairs L ↔ rowConfigLess L p.1 p.2 := by
  simp [orderedPairs]

/-- 三分律から出る 3 つの帰結（人手証明が証明のなかで使う形）。 -/
lemma ne_of_rowConfigLess {τ τ' : RowConfig L} (h : rowConfigLess L τ τ') : τ ≠ τ' := by
  rcases h with ⟨hne, -⟩
  exact hne

lemma not_rowConfigLess_of_rowConfigLess {τ τ' : RowConfig L} (h : rowConfigLess L τ τ') :
    ¬ rowConfigLess L τ' τ := by
  rcases rowConfigLess_trichotomy τ τ' with ⟨-, -, hnot⟩ | ⟨hnot, -, -⟩ | ⟨hnot, -, -⟩
  · exact hnot
  · exact absurd h hnot
  · exact absurd h hnot

lemma rowConfigLess_or_rowConfigLess {τ τ' : RowConfig L} (h : τ ≠ τ') :
    rowConfigLess L τ τ' ∨ rowConfigLess L τ' τ := by
  rcases rowConfigLess_trichotomy τ τ' with ⟨hlt, -, -⟩ | ⟨-, heq, -⟩ | ⟨-, -, hgt⟩
  · exact Or.inl hlt
  · exact absurd heq h
  · exact Or.inr hgt

/-- 第一の主張。符号は `+1` か `-1` である。 -/
theorem permSign_eq_one_or_neg_one (φ : Equiv.Perm (RowConfig L)) :
    permSign L φ = 1 ∨ permSign L φ = -1 :=
  neg_one_pow_eq_or ℤ _

/-- 第二の主張。符号の 2 乗は `1` である（人手証明の 4 つの等号）。 -/
theorem permSign_mul_self (φ : Equiv.Perm (RowConfig L)) :
    permSign L φ * permSign L φ = 1 := by
  unfold permSign
  rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]

/-- 第三の主張の前半。恒等置換の転倒数は `0` である。 -/
theorem inversionCount_id : inversionCount L (1 : Equiv.Perm (RowConfig L)) = 0 := by
  rw [inversionCount, card_eq_zero, filter_eq_empty_iff]
  intro p hp
  exact not_rowConfigLess_of_rowConfigLess (mem_orderedPairs.mp hp)

/-- 第三の主張。恒等置換の符号は `+1` である（人手証明の 3 つの等号）。 -/
theorem permSign_id : permSign L (1 : Equiv.Perm (RowConfig L)) = 1 := by
  rw [permSign, inversionCount_id, pow_zero]

variable (L)

/-- 人手証明の写像 `Ψ`。`ψ` の像を `≺` について並べ直した対を返す。 -/
noncomputable def pairMap (ψ : Equiv.Perm (RowConfig L)) (p : RowConfig L × RowConfig L) :
    RowConfig L × RowConfig L :=
  if rowConfigLess L (ψ p.1) (ψ p.2) then (ψ p.1, ψ p.2) else (ψ p.2, ψ p.1)

variable {L}

/-- `Ψ` が `P_L` の中へ入ること（人手証明の「これが定まることを見る」）。 -/
lemma pairMap_mem (ψ : Equiv.Perm (RowConfig L)) {p : RowConfig L × RowConfig L}
    (hp : p ∈ orderedPairs L) : pairMap L ψ p ∈ orderedPairs L := by
  have hne : p.1 ≠ p.2 := ne_of_rowConfigLess (mem_orderedPairs.mp hp)
  have hψ : ψ p.1 ≠ ψ p.2 := fun h => hne (ψ.injective h)
  rw [mem_orderedPairs, pairMap]
  by_cases h : rowConfigLess L (ψ p.1) (ψ p.2)
  · simp [h]
  · rcases rowConfigLess_or_rowConfigLess hψ with h' | h'
    · exact absurd h' h
    · simpa [h] using h'

/-- `Ψ` の逆写像が `ψ⁻¹` から同じ作り方で得られること（人手証明の全単射性）。 -/
lemma pairMap_pairMap (ψ : Equiv.Perm (RowConfig L)) {p : RowConfig L × RowConfig L}
    (hp : p ∈ orderedPairs L) : pairMap L ψ⁻¹ (pairMap L ψ p) = p := by
  have hlt : rowConfigLess L p.1 p.2 := mem_orderedPairs.mp hp
  have hnot : ¬ rowConfigLess L p.2 p.1 := not_rowConfigLess_of_rowConfigLess hlt
  by_cases h : rowConfigLess L (ψ p.1) (ψ p.2)
  · simp [pairMap, h, hlt]
  · simp [pairMap, h, hnot]

lemma pairMap_pairMap_inv (ψ : Equiv.Perm (RowConfig L)) {p : RowConfig L × RowConfig L}
    (hp : p ∈ orderedPairs L) : pairMap L ψ (pairMap L ψ⁻¹ p) = p := by
  have h := pairMap_pairMap ψ⁻¹ hp
  rwa [inv_inv] at h

/-- `Ψ` で数え直しても転倒数は変わらないこと（人手証明の `|C| = inv(φ)`）。 -/
lemma inversionCount_eq_card_pairMap (φ ψ : Equiv.Perm (RowConfig L)) :
    inversionCount L φ
      = ((orderedPairs L).filter fun p =>
          rowConfigLess L (φ (pairMap L ψ p).2) (φ (pairMap L ψ p).1)).card := by
  refine card_nbij' (pairMap L ψ⁻¹) (pairMap L ψ) ?_ ?_ ?_ ?_
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨pairMap_mem ψ⁻¹ hq.1, ?_⟩
    rw [pairMap_pairMap_inv ψ hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨pairMap_mem ψ hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact pairMap_pairMap_inv ψ hq.1
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact pairMap_pairMap ψ hp.1

/-- 「属するときだけ `-1` を掛けた有限積は `(-1)` の個数乗」（人手証明の第 3 の等号）。 -/
lemma prod_ite_neg_one {β : Type*} (s : Finset β) (q : β → Prop) [DecidablePred q] :
    (∏ p ∈ s, if q p then (-1 : ℤ) else 1) = (-1) ^ (s.filter q).card := by
  rw [prod_ite, prod_const, prod_const_one, mul_one]

/-- 人手証明の「各対について A, B, C に属するものの個数は偶数である」。 -/
lemma parity_at_pair (φ ψ : Equiv.Perm (RowConfig L)) {p : RowConfig L × RowConfig L}
    (hp : p ∈ orderedPairs L) :
    (if rowConfigLess L ((φ * ψ) p.2) ((φ * ψ) p.1) then (-1 : ℤ) else 1)
        * (if rowConfigLess L (φ (pairMap L ψ p).2) (φ (pairMap L ψ p).1) then (-1 : ℤ) else 1)
        * (if rowConfigLess L (ψ p.2) (ψ p.1) then (-1 : ℤ) else 1) = 1 := by
  have hlt : rowConfigLess L p.1 p.2 := mem_orderedPairs.mp hp
  have hne : p.1 ≠ p.2 := ne_of_rowConfigLess hlt
  have hψne : ψ p.1 ≠ ψ p.2 := fun hh => hne (ψ.injective hh)
  have hφne : φ (ψ p.1) ≠ φ (ψ p.2) := fun hh => hψne (φ.injective hh)
  by_cases h : rowConfigLess L (ψ p.1) (ψ p.2)
  · -- ψ(τ) ≺ ψ(τ') の場合。B に属さず、A の条件と C の条件が同じ。
    have hB : ¬ rowConfigLess L (ψ p.2) (ψ p.1) := not_rowConfigLess_of_rowConfigLess h
    by_cases hA : rowConfigLess L (φ (ψ p.2)) (φ (ψ p.1))
    · simp [pairMap, h, hB, hA, Equiv.Perm.mul_apply]
    · simp [pairMap, h, hB, hA, Equiv.Perm.mul_apply]
  · -- ψ(τ') ≺ ψ(τ) の場合。B に属し、A と C はちょうど一方。
    have hB : rowConfigLess L (ψ p.2) (ψ p.1) := by
      rcases rowConfigLess_or_rowConfigLess hψne with h' | h'
      · exact absurd h' h
      · exact h'
    by_cases hA : rowConfigLess L (φ (ψ p.2)) (φ (ψ p.1))
    · have hC : ¬ rowConfigLess L (φ (ψ p.1)) (φ (ψ p.2)) :=
        not_rowConfigLess_of_rowConfigLess hA
      simp [pairMap, h, hB, hA, hC, Equiv.Perm.mul_apply]
    · have hC : rowConfigLess L (φ (ψ p.1)) (φ (ψ p.2)) := by
        rcases rowConfigLess_or_rowConfigLess hφne with h' | h'
        · exact h'
        · exact absurd h' hA
      simp [pairMap, h, hB, hA, hC, Equiv.Perm.mul_apply]

/-- 人手証明の乗法性 `sgn(φ ∘ ψ) = sgn(φ) sgn(ψ)`。
`(φ * ψ) τ = φ (ψ τ)` なので、mathlib の積が人手証明の合成にあたる。 -/
theorem permSign_comp (φ ψ : Equiv.Perm (RowConfig L)) :
    permSign L (φ * ψ) = permSign L φ * permSign L ψ := by
  -- 3 つの符号の積が 1 であること（人手証明の 1 つめの式変形）。
  have hprod : permSign L (φ * ψ) * permSign L φ * permSign L ψ = 1 := by
    rw [permSign, permSign, permSign, inversionCount_eq_card_pairMap φ ψ]
    simp only [inversionCount]
    rw [← prod_ite_neg_one (orderedPairs L) fun p =>
        rowConfigLess L ((φ * ψ) p.2) ((φ * ψ) p.1),
      ← prod_ite_neg_one (orderedPairs L) fun p =>
        rowConfigLess L (φ (pairMap L ψ p).2) (φ (pairMap L ψ p).1),
      ← prod_ite_neg_one (orderedPairs L) fun p => rowConfigLess L (ψ p.2) (ψ p.1),
      ← prod_mul_distrib, ← prod_mul_distrib]
    rw [prod_congr rfl fun p hp => parity_at_pair φ ψ hp, prod_const_one]
  -- 両辺に sgn(φ) sgn(ψ) を掛ける（人手証明の 2 つめの式変形）。
  calc permSign L (φ * ψ)
      = permSign L (φ * ψ) * 1 * 1 := by ring
    _ = permSign L (φ * ψ) * (permSign L φ * permSign L φ)
          * (permSign L ψ * permSign L ψ) := by rw [permSign_mul_self, permSign_mul_self]
    _ = (permSign L (φ * ψ) * permSign L φ * permSign L ψ)
          * (permSign L φ * permSign L ψ) := by ring
    _ = 1 * (permSign L φ * permSign L ψ) := by rw [hprod]
    _ = permSign L φ * permSign L ψ := by ring

end Ising2DLambda.AlgebraicEigenvalue
