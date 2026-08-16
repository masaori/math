/-
「開境界正方形の密度の下組は空でない」の必要十分版。

具体版が使うのは、(1) 正の元 ε（`le 0 ε`、`ε ≠ 0`）が一つあること、(2) その ε について逆元律 `−ε + ε = 0`、
(3) 列の項が添字 1 以上で非負であること（`le 0 (l L)`）だけである。加法は `Add X`、逆元は `Neg X`、
`Zero X` は `0 ≤` を述べる名前としてだけ要る。順序の推移律も加法単調性も線形性も有理数倍も `Λ_ℚ` も使わない。
逆元律は ε 一つについてだけ受ける（群の公理全体は使わない）。証明手順は具体版と同じ
（証人 ε, N := 1、`−ε + ε = 0` で書き換え、非負を当てる）。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet
import Mathlib.Order.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Add X] [Zero X] [Neg X]

/-- 正の元 `ε` の逆元 `−ε` は、添字 1 以上で非負な列の下組に属する。 -/
theorem neg_mem_lowerSetOfSequence_of_nonneg_necSuf (le : X → X → Prop) (l : ℕ → X)
    (ε : X) (hε0 : le 0 ε) (hεne : ε ≠ 0) (hcancel : -ε + ε = 0)
    (hnonneg : ∀ L : ℕ, 1 ≤ L → le 0 (l L)) :
    -ε ∈ lowerSetOfSequence le l := by
  refine ⟨ε, hε0, hεne, 1, Nat.le_refl 1, ?_⟩
  intro L hL
  rw [hcancel]
  exact hnonneg L hL

end Ising2DLambda.NecSuf.ThermodynamicLimit
