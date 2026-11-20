/-
節「一次因子の積の根」の必要十分版。
具体版 `Ising2DLambda.FisherZero.qbarLinearFactorProductRootIsListedRoot` と同じ手順
（値を取ると因子ごとの差の積になる → 積が零なら因子のどれかが零 → 差が零なら等しい）を、
手順が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 因子を掛ける可換モノイド M と、値を取る写像 ev : M →* R（積と単位元を保つこと。
  具体版では多項式の値 aev_z）。M の加法は使わない。
- 値の側 R は可換環で、零因子が無く（積が零なら因子のどれかが零）、0 ≠ 1 である
  （N = 0 で空積 1 が零でないこと。0 = 1 の環では空積の値が零になり主張が偽になる）。
- 各因子の値が z - root(r) であること（hev。具体版では aev_z が和と逆元を保ち aev_z(t) = z、
  aev_z(â) = a であることが供給する）。

削れたもの: 多項式であること・体であること（逆元を使わない）・代数閉であること。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

open scoped BigOperators

/-- 零因子の無い可換環で、範囲 `r < N` にわたる有限積が零なら零の因子がある（N についての帰納法）。 -/
theorem range_prod_eq_zero_exists_necSuf {R : Type*} [CommRing R] [NoZeroDivisors R]
    [Nontrivial R] (c : ℕ → R) :
    ∀ N : ℕ, (∏ r ∈ Finset.range N, c r) = 0 → ∃ r : ℕ, r < N ∧ c r = 0 := by
  intro N
  induction N with
  | zero =>
      intro h
      rw [Finset.range_zero, Finset.prod_empty] at h
      exact absurd h one_ne_zero
  | succ N ih =>
      intro h
      rw [Finset.prod_range_succ] at h
      rcases mul_eq_zero.mp h with h' | h'
      · obtain ⟨r, hr, hc⟩ := ih h'
        exact ⟨r, by omega, hc⟩
      · exact ⟨N, by omega, h'⟩

theorem linear_factor_product_root_is_listed_root_necSuf
    {M : Type*} [CommMonoid M] {R : Type*} [CommRing R] [NoZeroDivisors R] [Nontrivial R]
    (ev : M →* R) (fac : ℕ → M) (root : ℕ → R) (z : R)
    (hev : ∀ r : ℕ, ev (fac r) = z - root r) (N : ℕ)
    (h : ev (∏ r ∈ Finset.range N, fac r) = 0) :
    ∃ r : ℕ, r < N ∧ z = root r := by
  have hprod : (∏ r ∈ Finset.range N, (z - root r)) = 0 := by
    calc
      (∏ r ∈ Finset.range N, (z - root r))
          = ∏ r ∈ Finset.range N, ev (fac r) :=
            Finset.prod_congr rfl (fun r _ => (hev r).symm)
      _ = ev (∏ r ∈ Finset.range N, fac r) := (map_prod ev fac _).symm
      _ = 0 := h
  obtain ⟨r₀, hr₀, hzero⟩ := range_prod_eq_zero_exists_necSuf (fun r => z - root r) N hprod
  refine ⟨r₀, hr₀, ?_⟩
  calc
    z = (z - root r₀) + root r₀ := by rw [sub_add_cancel]
    _ = 0 + root r₀ := by rw [show z - root r₀ = 0 from hzero]
    _ = root r₀ := by rw [zero_add]

end Ising2DLambda.NecSuf.FisherZero
