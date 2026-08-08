/-
主張「符号は合成について乗法的である」（および符号の値についての主張）の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.PermutationSign`）の証明が実際に使っているのは
次だけである。行配位であること・格子の形・スピンの値が `{+1,-1}` であること・
順序が辞書式であることは、どこにも使っていない。

  使っている性質            なぜ削れないか
  `Fintype α`               順序対の全体 `P` を有限集合として扱い、その個数を数えるため。
                            無限集合では転倒数が定義できない。
  `DecidableRel lt`         `P` と転倒の集合を `Finset.filter` で作るのに要る。
                            （`DecidableEq α` は要らない。順序対の全体は `α × α` の有限性だけで
                            作れて、相等の判定は使っていない。）
  三分律 `htri`             (1) `Ψ` が定まること（像の 2 成分のどちらが小さいかがちょうど 1 つ
                            決まる）、(2) 場合分けで `A` と `C` の条件がちょうど一方だけ
                            成り立つこと、の 2 か所で使う。これが無いと `Ψ` が作れない。

**推移律は仮定していない。** 人手証明の主張「行配位の辞書式順序は線形順序である」は
三分律と推移律の両方を述べているが、符号の乗法性の証明が使っているのは三分律だけである。
すなわち「順序」である必要すらなく、三分律を満たす二項関係であれば符号は乗法的になる。
これがこの必要十分版の中身である（推移律を仮定に足しても証明は変わらない。
足さずに通ることが「使っていない」ことの検査になっている）。

値の側は `ℤ` に固定してある。符号は `(-1)^n` であって、`-1` が可逆で 2 乗が `1` になる
という性質しか使っていないが、それを一般の環へ持ち上げると「`(-1)` を持つ環」という
仮定を書くことになり、`ℤ` の元としての `(-1)^n` と同じものしか得られない
（人手証明が `ℤ` の中の等式として述べているので、ここでも `ℤ` に固定する）。

証明手順は具体版と同じである（別の論法へ差し替えていない）。
mathlib の `Equiv.Perm.sign` は引かない。引くと転倒数で定めるという人手証明の定義そのものが
消えるので、1 対 1 対応が壊れる。

住処: ここに ℝ / ℂ は現れない（数え上げは ℕ、符号は ℤ）。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Prod
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Logic.Equiv.Basic
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {α : Type*} [Fintype α] (lt : α → α → Prop) [DecidableRel lt]

/-- 人手証明の三分律。`lt a b`・`a = b`・`lt b a` のうちちょうど 1 つが成り立つ。 -/
def Trichotomous : Prop :=
  ∀ a b : α,
    (lt a b ∧ a ≠ b ∧ ¬ lt b a)
      ∨ (¬ lt a b ∧ a = b ∧ ¬ lt b a)
      ∨ (¬ lt a b ∧ a ≠ b ∧ lt b a)

omit [Fintype α] [DecidableRel lt] in
lemma ne_of_lt' (htri : Trichotomous lt) {a b : α} (h : lt a b) : a ≠ b := by
  rcases htri a b with ⟨-, hne, -⟩ | ⟨hnot, -, -⟩ | ⟨hnot, -, -⟩
  · exact hne
  · exact absurd h hnot
  · exact absurd h hnot

omit [Fintype α] [DecidableRel lt] in
lemma not_lt_of_lt' (htri : Trichotomous lt) {a b : α} (h : lt a b) : ¬ lt b a := by
  rcases htri a b with ⟨-, -, hnot⟩ | ⟨hnot, -, -⟩ | ⟨hnot, -, -⟩
  · exact hnot
  · exact absurd h hnot
  · exact absurd h hnot

omit [Fintype α] [DecidableRel lt] in
lemma lt_or_lt_of_ne (htri : Trichotomous lt) {a b : α} (h : a ≠ b) : lt a b ∨ lt b a := by
  rcases htri a b with ⟨hab, -, -⟩ | ⟨-, heq, -⟩ | ⟨-, -, hba⟩
  · exact Or.inl hab
  · exact absurd heq h
  · exact Or.inr hba

/-- 人手証明の `P_L`。順序づけられた対の全体。 -/
def orderedPairs : Finset (α × α) := univ.filter fun p => lt p.1 p.2

/-- 人手証明の `inv(φ)`。`φ` によって順序が入れ替わる対の個数。 -/
def inversionCount (φ : Equiv.Perm α) : ℕ :=
  ((orderedPairs lt).filter fun p => lt (φ p.2) (φ p.1)).card

/-- 人手証明の `sgn(φ) = (-1)^{inv(φ)}`。 -/
def sign (φ : Equiv.Perm α) : ℤ := (-1) ^ inversionCount lt φ

lemma mem_orderedPairs {p : α × α} : p ∈ orderedPairs lt ↔ lt p.1 p.2 := by
  simp [orderedPairs, mem_filter]

/-- 第一の主張。符号は `+1` か `-1` である。 -/
theorem sign_eq_one_or_neg_one (φ : Equiv.Perm α) : sign lt φ = 1 ∨ sign lt φ = -1 :=
  neg_one_pow_eq_or ℤ _

/-- 第二の主張。符号の 2 乗は `1` である。 -/
theorem sign_mul_self (φ : Equiv.Perm α) : sign lt φ * sign lt φ = 1 := by
  unfold sign
  rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]

/-- 第三の主張。恒等置換の転倒数は `0` である（三分律から `lt a b` と `lt b a` は両立しない）。 -/
theorem inversionCount_one (htri : Trichotomous lt) : inversionCount lt (1 : Equiv.Perm α) = 0 := by
  rw [inversionCount, card_eq_zero, filter_eq_empty_iff]
  intro p hp
  exact not_lt_of_lt' lt htri ((mem_orderedPairs lt).mp hp)

theorem sign_one (htri : Trichotomous lt) : sign lt (1 : Equiv.Perm α) = 1 := by
  rw [sign, inversionCount_one lt htri, pow_zero]

/-- 人手証明の写像 `Ψ`。`ψ` の像を `lt` について並べ直した対を返す。 -/
def pairMap (ψ : Equiv.Perm α) (p : α × α) : α × α :=
  if lt (ψ p.1) (ψ p.2) then (ψ p.1, ψ p.2) else (ψ p.2, ψ p.1)

/-- `Ψ` が `P` の中へ入ること（人手証明の「これが定まることを見る」）。 -/
lemma pairMap_mem (htri : Trichotomous lt) (ψ : Equiv.Perm α) {p : α × α}
    (hp : p ∈ orderedPairs lt) : pairMap lt ψ p ∈ orderedPairs lt := by
  have hne : p.1 ≠ p.2 := ne_of_lt' lt htri ((mem_orderedPairs lt).mp hp)
  have hψ : ψ p.1 ≠ ψ p.2 := fun h => hne (ψ.injective h)
  rw [mem_orderedPairs, pairMap]
  by_cases h : lt (ψ p.1) (ψ p.2)
  · simp [h]
  · rcases lt_or_lt_of_ne lt htri hψ with h' | h'
    · exact absurd h' h
    · simpa [h] using h'

/-- `Ψ` が `ψ⁻¹` から作った同じ形の写像を逆に持つこと（人手証明の全単射性）。 -/
lemma pairMap_pairMap (htri : Trichotomous lt) (ψ : Equiv.Perm α) {p : α × α}
    (hp : p ∈ orderedPairs lt) : pairMap lt ψ⁻¹ (pairMap lt ψ p) = p := by
  have hlt : lt p.1 p.2 := (mem_orderedPairs lt).mp hp
  have hnot : ¬ lt p.2 p.1 := not_lt_of_lt' lt htri hlt
  by_cases h : lt (ψ p.1) (ψ p.2)
  · simp [pairMap, h, hlt]
  · simp [pairMap, h, hnot]

/-- `Ψ` を `ψ⁻¹` から作ったものと合わせると恒等写像になること（逆向き）。 -/
lemma pairMap_pairMap_inv (htri : Trichotomous lt) (ψ : Equiv.Perm α) {p : α × α}
    (hp : p ∈ orderedPairs lt) : pairMap lt ψ (pairMap lt ψ⁻¹ p) = p := by
  have h := pairMap_pairMap lt htri ψ⁻¹ hp
  rwa [inv_inv] at h

/-- `Ψ` で数え直しても転倒数は変わらない（人手証明の `|C| = inv(φ)`）。 -/
lemma inversionCount_eq_card_pairMap (htri : Trichotomous lt) (φ ψ : Equiv.Perm α) :
    inversionCount lt φ
      = ((orderedPairs lt).filter fun p =>
          lt (φ (pairMap lt ψ p).2) (φ (pairMap lt ψ p).1)).card := by
  refine card_nbij' (pairMap lt ψ⁻¹) (pairMap lt ψ) ?_ ?_ ?_ ?_
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨pairMap_mem lt htri ψ⁻¹ hq.1, ?_⟩
    rw [pairMap_pairMap_inv lt htri ψ hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨pairMap_mem lt htri ψ hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact pairMap_pairMap_inv lt htri ψ hq.1
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact pairMap_pairMap lt htri ψ hp.1

/-- 「属するときだけ `-1` を掛けた有限積は `(-1)` の個数乗」。人手証明の第 3 の等号。 -/
lemma prod_ite_neg_one {β : Type*} (s : Finset β) (q : β → Prop) [DecidablePred q] :
    (∏ p ∈ s, if q p then (-1 : ℤ) else 1) = (-1) ^ (s.filter q).card := by
  rw [prod_ite, prod_const, prod_const_one, mul_one]

/-- 人手証明の「各対について A, B, C に属するものの個数は偶数である」。
属するときだけ `-1` を掛けた 3 つぶんの積が `1` になる、と書いてある。 -/
lemma parity_at_pair (htri : Trichotomous lt) (φ ψ : Equiv.Perm α) {p : α × α}
    (hp : p ∈ orderedPairs lt) :
    (if lt ((φ * ψ) p.2) ((φ * ψ) p.1) then (-1 : ℤ) else 1)
        * (if lt (φ (pairMap lt ψ p).2) (φ (pairMap lt ψ p).1) then (-1 : ℤ) else 1)
        * (if lt (ψ p.2) (ψ p.1) then (-1 : ℤ) else 1) = 1 := by
  have hlt : lt p.1 p.2 := (mem_orderedPairs lt).mp hp
  have hne : p.1 ≠ p.2 := ne_of_lt' lt htri hlt
  have hψne : ψ p.1 ≠ ψ p.2 := fun hh => hne (ψ.injective hh)
  have hφne : φ (ψ p.1) ≠ φ (ψ p.2) := fun hh => hψne (φ.injective hh)
  by_cases h : lt (ψ p.1) (ψ p.2)
  · -- ψ(τ) ≺ ψ(τ') の場合。B に属さず、A の条件と C の条件が同じ。
    have hB : ¬ lt (ψ p.2) (ψ p.1) := not_lt_of_lt' lt htri h
    by_cases hA : lt (φ (ψ p.2)) (φ (ψ p.1))
    · simp [pairMap, h, hB, hA, Equiv.Perm.mul_apply]
    · simp [pairMap, h, hB, hA, Equiv.Perm.mul_apply]
  · -- ψ(τ') ≺ ψ(τ) の場合。B に属し、A と C はちょうど一方。
    have hB : lt (ψ p.2) (ψ p.1) := by
      rcases lt_or_lt_of_ne lt htri hψne with h' | h'
      · exact absurd h' h
      · exact h'
    by_cases hA : lt (φ (ψ p.2)) (φ (ψ p.1))
    · have hC : ¬ lt (φ (ψ p.1)) (φ (ψ p.2)) := not_lt_of_lt' lt htri hA
      simp [pairMap, h, hB, hA, hC, Equiv.Perm.mul_apply]
    · have hC : lt (φ (ψ p.1)) (φ (ψ p.2)) := by
        rcases lt_or_lt_of_ne lt htri hφne with h' | h'
        · exact h'
        · exact absurd h' hA
      simp [pairMap, h, hB, hA, hC, Equiv.Perm.mul_apply]

/-- 人手証明の乗法性。合成の順序は `(φ * ψ) a = φ (ψ a)` で人手証明の `φ ∘ ψ` に合わせてある。 -/
theorem sign_comp (htri : Trichotomous lt) (φ ψ : Equiv.Perm α) :
    sign lt (φ * ψ) = sign lt φ * sign lt ψ := by
  -- 3 つの符号の積が 1 であること（人手証明の 1 つめの式変形）。
  have hprod : sign lt (φ * ψ) * sign lt φ * sign lt ψ = 1 := by
    rw [sign, sign, sign, inversionCount_eq_card_pairMap lt htri φ ψ]
    simp only [inversionCount]
    rw [← prod_ite_neg_one (orderedPairs lt) fun p => lt ((φ * ψ) p.2) ((φ * ψ) p.1),
      ← prod_ite_neg_one (orderedPairs lt) fun p =>
        lt (φ (pairMap lt ψ p).2) (φ (pairMap lt ψ p).1),
      ← prod_ite_neg_one (orderedPairs lt) fun p => lt (ψ p.2) (ψ p.1),
      ← prod_mul_distrib, ← prod_mul_distrib]
    rw [prod_congr rfl fun p hp => parity_at_pair lt htri φ ψ hp, prod_const_one]
  -- 両辺に sgn(φ) sgn(ψ) を掛けて、符号の 2 乗が 1 であることを使う（人手証明の 2 つめの式変形）。
  calc sign lt (φ * ψ)
      = sign lt (φ * ψ) * 1 * 1 := by ring
    _ = sign lt (φ * ψ) * (sign lt φ * sign lt φ) * (sign lt ψ * sign lt ψ) := by
        rw [sign_mul_self, sign_mul_self]
    _ = (sign lt (φ * ψ) * sign lt φ * sign lt ψ) * (sign lt φ * sign lt ψ) := by ring
    _ = 1 * (sign lt φ * sign lt ψ) := by rw [hprod]
    _ = sign lt φ * sign lt ψ := by ring

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
