/-
「正の有理数の対数は順序を保ちかつ反映する」の必要十分版。

使うのは、写像 `f : X → Y` と `g : Y → X` について (1) `g` の像が述語 `P` を満たすこと、
(2) `f ∘ g` が `Y` 上で恒等であること、(3) `f` が `P` を満たす元の上で単射であること、
そして `Y` の関係が `g` を通した `X` の関係（引き戻し）であることだけである。
対数・素因数分解・有理数・順序であることは本質でない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FreeEntropy

variable {X Y : Type*}

/-- `Y` 上の関係を `g` で `X` の関係へ引き戻したもの（具体版の `logOrderLE` の形）。 -/
def pullbackLEByInverse (leX : X → X → Prop) (g : Y → X) (a b : Y) : Prop := leX (g a) (g b)

/-- 補助等式。`P x` なら `g (f x) = x`（`f (g (f x)) = f x` と `P` 上の単射性）。 -/
theorem left_inverse_on_pred_necSuf (f : X → Y) (g : Y → X) (P : X → Prop)
    (hgP : ∀ y, P (g y)) (hfg : ∀ y, f (g y) = y)
    (hinj : ∀ x x', P x → P x' → f x = f x' → x = x')
    {x : X} (hx : P x) : g (f x) = x :=
  hinj (g (f x)) x (hgP (f x)) hx (hfg (f x))

/-- 主張。`P x`、`P x'` なら `leX x x' ↔ pullbackLEByInverse leX g (f x) (f x')`。 -/
theorem pullback_order_iff_of_left_inverse_necSuf (f : X → Y) (g : Y → X) (P : X → Prop)
    (leX : X → X → Prop)
    (hgP : ∀ y, P (g y)) (hfg : ∀ y, f (g y) = y)
    (hinj : ∀ x x', P x → P x' → f x = f x' → x = x')
    {x x' : X} (hx : P x) (hx' : P x') :
    leX x x' ↔ pullbackLEByInverse leX g (f x) (f x') := by
  unfold pullbackLEByInverse
  rw [left_inverse_on_pred_necSuf f g P hgP hfg hinj hx,
    left_inverse_on_pred_necSuf f g P hgP hfg hinj hx']

end Ising2DLambda.NecSuf.FreeEntropy
