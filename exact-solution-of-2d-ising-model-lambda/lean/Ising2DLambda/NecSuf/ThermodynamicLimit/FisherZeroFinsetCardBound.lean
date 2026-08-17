/-
「有限格子の Fisher 零点の有限部分集合の個数は 2L^2 を超えない」
（`claim_fisher_zero_finset_card_bound`）の必要十分版。

具体版と同じ手順で進む:
  第 1 の仮定: p ≠ zero。零なら n 以下の係数がすべて 0（仮定 `hcoeff_of_zero`）、
    係数の総和が total（仮定 `hsum`）で total ≠ 0（仮定 `htotal`）なので矛盾。
    具体版では `partitionPolynomial_coeff`・`claim_coefficient_sum`・2^{L^2} ≠ 0。
  第 2 の仮定: Bound n p（仮定 `hbound`。具体版では 2L^2 < k で ac_k = 0）。
  第 3 の仮定: S ⊂ F の元は p の根（仮定 `hF`。具体版では持ち上げの値の一致と F_L の定義）。
  個数の上界（仮定 `cardBound`。具体版では `claim_qbar_distinct_roots_card_bound`）を当てる。

必要な構造は「係数の有限和が取れること」（`AddCommMonoid`）だけである。多項式・評価・体は仮定せず、
根・上界・零元は述語と定数として受け取る。実数体・複素数体は現れない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 必要十分版: 零元・根・上界の述語と「零でない対象の根の有限集合の個数は上界を超えない」を受け取り、
係数の総和が零でないことから対象が零でないことを出し、`F` の有限部分集合の個数を抑える。 -/
theorem finset_card_le_of_subset_root_set_necSuf {P α M : Type*} [AddCommMonoid M]
    (zero : P) (Root : P → α → Prop) (Bound : ℕ → P → Prop)
    (cardBound : ∀ (p : P) (s : Finset α) (n : ℕ),
      p ≠ zero → Bound n p → (∀ a ∈ s, Root p a) → s.card ≤ n)
    (p : P) (n : ℕ) (coeff : ℕ → M) (total : M)
    (hcoeff_of_zero : p = zero → ∀ m ∈ Finset.range (n + 1), coeff m = 0)
    (hsum : total = ∑ m ∈ Finset.range (n + 1), coeff m)
    (htotal : total ≠ 0)
    (hbound : Bound n p)
    (F : Set α) (hF : ∀ a ∈ F, Root p a)
    (S : Finset α) (hS : ∀ a ∈ S, a ∈ F) :
    S.card ≤ n := by
  -- 第 1 の仮定: p ≠ zero。
  have hpne : p ≠ zero := by
    intro hzero
    have hmult := hcoeff_of_zero hzero
    have hsum0 : total = 0 := by
      calc total
          = ∑ m ∈ Finset.range (n + 1), coeff m := hsum
        _ = ∑ m ∈ Finset.range (n + 1), (0 : M) := Finset.sum_congr rfl hmult
        _ = 0 := Finset.sum_const_zero
    exact htotal hsum0
  -- 第 3 の仮定: S の元は p の根。
  have hroot : ∀ a ∈ S, Root p a := fun a ha => hF a (hS a ha)
  -- 上界を当てる。
  exact cardBound p S n hpne hbound hroot

end Ising2DLambda.NecSuf.ThermodynamicLimit
