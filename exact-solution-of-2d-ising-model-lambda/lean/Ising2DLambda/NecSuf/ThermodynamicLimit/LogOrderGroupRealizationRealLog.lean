/-
「対数順序群の元の実現は rat_Λ の実対数である」の必要十分版。

具体版が使うのは、(1) 正の実数の乗法が**可換**群をなすこと（有限集合に渡る積を作るのに可換性が要る。
それ以外は整数冪の必要十分版が使う群の性質だけ）、(2) 値の側 ℝ が**可換**加法群をなすこと
（有限集合に渡る和を作るのに可換性が要る）、(3) 写像 `f`（具体版では `log_ℝ`）が乗法を加法へ移すこと、
だけである。順序・完備性・実対数の狭義単調性は使わない。`ι_{ℚ→ℝ}` が整数冪・有限積を保つことは、
`ℚ` の中の冪・積を `ℝ` の中の冪・積へ読み替える具体側の事情なので、導出版に置く。
証明手順は具体版と同じ（有限積の像は像の和（有限集合の元の個数の帰納法）、各項に整数冪の必要十分版）。
mathlib の `map_prod`・`MonoidHom.map_zpow` 等の既製定理は使わない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finsupp.Defs
import Ising2DLambda.NecSuf.ThermodynamicLimit.RealLogarithmIntPower

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {G A : Type*} [CommGroup G] [AddCommGroup A]

/-- 準備: 有限積の像は像の和。有限集合 `S` の元の個数についての帰納法。 -/
theorem map_prod_necSuf {α : Type*} [DecidableEq α] (f : G → A)
    (hf : ∀ u v : G, f (u * v) = f u + f v) (S : Finset α) (u : α → G) :
    f (∏ p ∈ S, u p) = ∑ p ∈ S, f (u p) := by
  induction S using Finset.induction_on with
  | empty =>
      rw [Finset.prod_empty, Finset.sum_empty]                          -- 空積は 1、空和は 0
      exact map_one_necSuf f hf                                          -- f 1 = 0
  | insert p S hp ih =>
      rw [Finset.prod_insert hp, Finset.sum_insert hp]                   -- S ∪ {p} の積・和
      rw [hf]                                                            -- 乗法を加法へ
      rw [ih]                                                            -- 帰納法の仮定

/-- `Σ_{p ∈ supp l} l(p) • f(w p) = f(Π_{p ∈ supp l} (w p)^{l(p)})`。 -/
theorem realize_int_prod_necSuf {α : Type*} [DecidableEq α] (f : G → A)
    (hf : ∀ u v : G, f (u * v) = f u + f v) (w : α → G) (l : α →₀ ℤ) :
    ∑ p ∈ l.support, (l p) • f (w p) = f (∏ p ∈ l.support, (w p) ^ (l p)) := by
  calc
    ∑ p ∈ l.support, (l p) • f (w p)
        = ∑ p ∈ l.support, f ((w p) ^ (l p)) := by
          refine Finset.sum_congr rfl fun p _ => ?_
          exact (map_zpow_necSuf f hf (w p) (l p)).symm                  -- 整数冪の像は整数倍
    _ = f (∏ p ∈ l.support, (w p) ^ (l p)) :=
          (map_prod_necSuf f hf l.support fun p => (w p) ^ (l p)).symm    -- 準備: 有限積の像は和

end Ising2DLambda.NecSuf.ThermodynamicLimit
