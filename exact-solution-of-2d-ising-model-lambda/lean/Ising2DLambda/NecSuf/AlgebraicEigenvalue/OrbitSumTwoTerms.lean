/-
主張「軌道ごとの和は、軌道の元の個数を指数とする冪と、単位元の加法についての逆元との和である」
の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitSumTwoTerms`）の証明は、
2 つの元 `a`（`id_O`）と `b`（`S↾_O`）の外で項が零元であることから和を `{a, b}` へ狭め、
`a ≠ b` か `a = b` かで場合を分けて 2 項の和か 1 項に落とす。
証明手順は具体版と同じ（狭める → 場合分け → 項を並べる）。

  使っている性質                なぜ削れないか
  `hzero : i ≠ a → i ≠ b →`     狭める段の唯一の根拠。これが無いと `{a,b}` の外の項が残る。
  `  f i = 0`
  `Fintype ι`                   左辺が「型全体にわたる和」なので、和が定まるために要る。
  `DecidableEq ι`               `{a, b}` を `Finset` として作るために要る。
  `AddCommMonoid M`             有限和そのものに要る（並べる順序によらないこと）。

削れたもの: 添字が軌道の上の全単射であること、`a` が恒等写像で `b` が巡回シフトの制限で
あること、`f` が軌道の因子であること、値が多項式であること（可換な加法モノイドで足りる）、
零元以外の代数構造（積も、加法の逆元も使わない）、順序 `≺`、行配位。

**2 つの場合を別々の定理にしてある。** 具体版が `|O| ≥ 2` と `|O| = 1` で別々の値を出すのは、
そこで `a = b` になるか否かが変わるからであって、軌道の元の個数そのものではない。
必要十分版でこの 2 つを分けておくと、そのことが型に現れる。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、値は一般の可換な加法モノイド）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 狭める段。`a` と `b` の外で項が零元ならば、型全体にわたる和は `{a, b}` にわたる和に等しい。 -/
theorem sum_eq_sum_pair_of_outside_zero {ι : Type*} [Fintype ι] [DecidableEq ι]
    {M : Type*} [AddCommMonoid M] (f : ι → M) (a b : ι)
    (hzero : ∀ i, i ≠ a → i ≠ b → f i = 0) :
    ∑ i, f i = ∑ i ∈ ({a, b} : Finset ι), f i := by
  refine (Finset.sum_subset (Finset.subset_univ _) ?_).symm
  intro i _ hnot
  have h₁ : i ≠ a := fun h => hnot (by rw [h]; exact Finset.mem_insert_self _ _)
  have h₂ : i ≠ b := fun h =>
    hnot (by rw [h]; exact Finset.mem_insert_of_mem (Finset.mem_singleton_self _))
  exact hzero i h₁ h₂

/-- 第一の場合。`a ≠ b` ならば、和は 2 つの項の和である。 -/
theorem sum_eq_add_of_outside_zero {ι : Type*} [Fintype ι] [DecidableEq ι]
    {M : Type*} [AddCommMonoid M] (f : ι → M) (a b : ι)
    (hzero : ∀ i, i ≠ a → i ≠ b → f i = 0) (hab : a ≠ b) :
    ∑ i, f i = f a + f b := by
  rw [sum_eq_sum_pair_of_outside_zero f a b hzero, Finset.sum_pair hab]

/-- 第二の場合。`a = b` ならば、和は 1 つの項である。 -/
theorem sum_eq_single_of_outside_zero {ι : Type*} [Fintype ι] [DecidableEq ι]
    {M : Type*} [AddCommMonoid M] (f : ι → M) (a b : ι)
    (hzero : ∀ i, i ≠ a → i ≠ b → f i = 0) (hab : a = b) :
    ∑ i, f i = f a := by
  rw [sum_eq_sum_pair_of_outside_zero f a b hzero, ← hab, Finset.pair_eq_singleton,
    Finset.sum_singleton]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
