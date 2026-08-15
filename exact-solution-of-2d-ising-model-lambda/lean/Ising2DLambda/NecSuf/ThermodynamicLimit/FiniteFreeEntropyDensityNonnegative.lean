/-
「有限系の自由エントロピー密度は非負である」の必要十分版。

具体版が使うのは次だけである。二つの型の上の関係 `leX`・`leY`、述語 `P` の上で `leX` を `leY` へ移す写像 `f`
（順序を**保つ**こと。具体版が引く二つの主張は同値（保ちかつ反映）だが、使うのは → の向きだけである）、
基点 `x₀` が基点 `y₀` へ移ること（`log 1 = 0`、`(1/L^2)·ι(0) = 0`）、そして `leX x₀ z`。
このとき `leY y₀ (f z)`。具体版はこれを二度使う（ℚ_{>0} → Λ、Λ → Λ_ℚ）。
対数・有理数倍・埋め込み・分配多項式の中身は本質でない。証明手順は具体版と同じ
（`f` で移してから基点の等式で書き換える）。
-/
import Mathlib.Logic.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X Y : Type*}

/-- 順序を保つ写像は、基点からの下界を基点の像からの下界へ移す。 -/
theorem le_base_transport_of_monotone_necSuf
    (P : X → Prop) (leX : X → X → Prop) (leY : Y → Y → Prop) (f : X → Y)
    (hf : ∀ a b, P a → P b → leX a b → leY (f a) (f b))
    {x₀ z : X} {y₀ : Y} (hx₀ : P x₀) (hz : P z) (hf0 : f x₀ = y₀) (h : leX x₀ z) :
    leY y₀ (f z) := by
  have h' : leY (f x₀) (f z) := hf x₀ z hx₀ hz h   -- f で移す
  rw [hf0] at h'                                    -- 基点の等式で書き換える
  exact h'

end Ising2DLambda.NecSuf.ThermodynamicLimit
