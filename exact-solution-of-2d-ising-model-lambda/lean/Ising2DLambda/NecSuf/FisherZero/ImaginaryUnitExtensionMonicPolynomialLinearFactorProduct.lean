/-
主張「虚数単位を足した体を係数とする最高次の係数が一の多項式は、その体の元を根とする一次因子の積である」
（ラベル `claim_imaginary_unit_extension_monic_polynomial_linear_factor_product`）の必要十分版。
具体版 `Ising2DLambda.FisherZero.imaginaryUnitExtension_monicPolynomial_linearFactorProduct` と同じ
d についての帰納法を、帰納法が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 因子と商を掛ける可換モノイド M（最後の因子を有限積の末尾へ回す段で交換則・結合則を使う）と、
  根の型 α・根から因子を与える写像 fac。多項式であること・加法は使わない。
- 係数の所属の述語 P（M 上。具体版では「係数が全て Lin_F(ω)」）と根の所属の述語 S（α 上。
  具体版では「Lin_F(ω) に属する」）。
- S を満たす根が一つあること（hs0。出発点 d = 0 で根の列を置く。具体版では 0 ∈ Lin_F(ω)）。
- 上界の述語 bound と先頭の係数の述語 lead（中身は問わない）。
- 出発点: 番号 0 の上界と先頭の係数を持つ元は単位元である（hbase。具体版では
  `claim_qbar_monic_polynomial_linear_factor_product` の d = 0 が供給する）。
- 一歩: P と番号 m + 1 の上界・先頭の係数を持つ元は、S を満たす根の因子と、P と番号 m の上界・先頭の
  係数を持つ商に分かれる（hstep。具体版では根の存在・因数定理・商の係数の所属・商の係数の上界・
  一次因子との積の先頭の係数が供給する）。

削れたもの: 加法・分配則・体であること・ω·ω = -1・正錐・共役。これらは仮定（hs0・hbase・hstep）の
供給側に隔離される。根の存在と因数分解を一つの仮定 hstep にまとめたのは、具体版の一歩でも根の存在が
商の構成にだけ使われ、帰納法そのものは「因子と商への分解」しか使わないからである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

open scoped BigOperators

theorem imaginaryUnitExtension_monicPolynomial_linearFactorProduct_necSuf
    {M : Type*} [CommMonoid M] {α : Type*}
    (fac : α → M) (P : M → Prop) (S : α → Prop)
    (bound : M → ℕ → Prop) (lead : M → ℕ → Prop)
    (hs0 : ∃ x : α, S x)
    (hbase : ∀ f : M, bound f 0 → lead f 0 → f = 1)
    (hstep : ∀ (g : M) (m : ℕ), P g → bound g (m + 1) → lead g (m + 1) →
      ∃ x : α, ∃ q : M, S x ∧ g = fac x * q ∧ P q ∧ bound q m ∧ lead q m) :
    ∀ (d : ℕ) (f : M), P f → bound f d → lead f d →
      ∃ w : ℕ → α, (∀ i : ℕ, S (w i)) ∧ f = ∏ i ∈ Finset.range d, fac (w i) := by
  obtain ⟨x₀, hx₀⟩ := hs0
  intro d
  induction d with
  | zero =>
      intro f _ hbound hlead
      refine ⟨fun _ => x₀, fun _ => hx₀, ?_⟩
      rw [Finset.range_zero, Finset.prod_empty]
      exact hbase f hbound hlead
  | succ d ih =>
      intro f hP hbound hlead
      -- 一歩: 根の因子と商への分解。
      obtain ⟨x, q, hx, hfact, hqP, hqbound, hqlead⟩ := hstep f d hP hbound hlead
      -- 帰納法の仮定を商へ当てる。
      obtain ⟨w', hw'S, hw'⟩ := ih q hqP hqbound hqlead
      refine ⟨fun i => if i = d then x else w' i, ?_, ?_⟩
      · intro i
        by_cases hid : i = d
        · simp only [if_pos hid]; exact hx
        · simp only [if_neg hid]; exact hw'S i
      · have hprod :
            (∏ i ∈ Finset.range d, fac (w' i))
              = ∏ i ∈ Finset.range d, fac ((fun i => if i = d then x else w' i) i) := by
          refine Finset.prod_congr rfl (fun i hi => ?_)
          have hid : ¬ i = d := by
            have := Finset.mem_range.mp hi
            omega
          simp only [if_neg hid]
        calc
          f = fac x * q := hfact
          _ = fac x * ∏ i ∈ Finset.range d, fac (w' i) := by rw [← hw']
          _ = (∏ i ∈ Finset.range d, fac (w' i)) * fac x := by rw [mul_comm]
          _ = (∏ i ∈ Finset.range d, fac ((fun i => if i = d then x else w' i) i))
                * fac ((fun i => if i = d then x else w' i) d) := by
                rw [← hprod]; simp only [↓reduceIte]
          _ = ∏ i ∈ Finset.range (d + 1), fac ((fun i => if i = d then x else w' i) i) := by
                rw [Finset.prod_range_succ]

end Ising2DLambda.NecSuf.FisherZero
