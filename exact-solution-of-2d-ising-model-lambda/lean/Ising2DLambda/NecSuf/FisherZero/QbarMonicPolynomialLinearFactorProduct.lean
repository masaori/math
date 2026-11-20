/-
節「最高次の係数が一の多項式の一次因子への分解」の必要十分版。
具体版 `Ising2DLambda.FisherZero.qbarMonicPolynomialLinearFactorProduct` と同じ d についての帰納法を、
帰納法が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 因子と商を掛ける可換モノイド M（最後の因子を有限積の末尾へ回す段で交換則・結合則を使う）と、
  根の型 α・根から因子を与える写像 fac。多項式であること・加法は使わない。
- α が空でないこと（出発点 d = 0 で根の列を一つ置く。具体版では零元を置いた）。
- 上界の述語 bound と先頭の係数の述語 lead（中身は問わない）。
- 出発点: 番号 0 の上界と先頭の係数を持つ元は単位元である（hbase。具体版では
  単項式分解から 1̂·1 = 1 に至る式鎖が供給する）。
- 根の供給: 先頭の係数を番号 m ≥ 1 に持つ元は根を持つ（hroot。具体版では Qbar の代数閉性が供給する）。
- 因数分解: 根を持つ元は、その根の因子と、上界が一つ下がり先頭の係数を保つ商に分かれる
  （hfactor。具体版では因数定理・商の係数上界・一次因子との積の先頭の係数が供給する）。

削れたもの: 加法・分配則・体であること・代数閉であること。これらは仮定（hbase・hroot・hfactor）の
供給側に隔離される。根の相異性は主張に含まないので、それを出す仮定も要らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

open scoped BigOperators

theorem monic_linear_factor_product_necSuf
    {M : Type*} [CommMonoid M] {α : Type*} [Nonempty α]
    (fac : α → M) (bound : M → ℕ → Prop) (lead : M → ℕ → Prop)
    (isRoot : α → M → Prop)
    (hbase : ∀ f : M, bound f 0 → lead f 0 → f = 1)
    (hroot : ∀ (g : M) (m : ℕ), 1 ≤ m → lead g m → ∃ x : α, isRoot x g)
    (hfactor : ∀ (g : M) (x : α) (m : ℕ), 1 ≤ m → bound g m → lead g m →
      isRoot x g → ∃ q : M, g = fac x * q ∧ bound q (m - 1) ∧ lead q (m - 1)) :
    ∀ (d : ℕ) (f : M), bound f d → lead f d →
      ∃ w : ℕ → α, f = ∏ i ∈ Finset.range d, fac (w i) := by
  intro d
  induction d with
  | zero =>
      intro f hbound hlead
      refine ⟨fun _ => Classical.arbitrary α, ?_⟩
      rw [Finset.range_zero, Finset.prod_empty]
      exact hbase f hbound hlead
  | succ d ih =>
      intro f hbound hlead
      -- 根の供給。
      obtain ⟨x, hx⟩ := hroot f (d + 1) (by omega) hlead
      -- 因数分解と、商の上界・先頭の係数。
      obtain ⟨q, hfact, hqbound, hqlead⟩ := hfactor f x (d + 1) (by omega) hbound hlead hx
      have hqbound' : bound q d := by simpa using hqbound
      have hqlead' : lead q d := by simpa using hqlead
      -- 帰納法の仮定を商へ当てる。
      obtain ⟨w', hw'⟩ := ih q hqbound' hqlead'
      refine ⟨fun i => if i = d then x else w' i, ?_⟩
      have hprod :
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
              * fac ((fun i => if i = d then x else w' i) d) := by rw [← hprod]; simp only [↓reduceIte]
        _ = ∏ i ∈ Finset.range (d + 1), fac ((fun i => if i = d then x else w' i) i) := by
              rw [Finset.prod_range_succ]

end Ising2DLambda.NecSuf.FisherZero
