/-
「有限台指数ベクトルの和は正の有理数の積へ移る」と
「対数順序群の順序は加法について単調である」の必要十分版。

一つ目が使うのは、逆写像で元へ戻ること、積を和へ送ること、着目する二元での単射性だけである。
二つ目が使うのは、写像が和を積へ送ることと、右から同じ元を掛けると順序が保たれることだけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FreeEntropy

variable {X Y : Type*}

theorem inverse_add_to_mul_necSuf
    (addX : X → X → X) (mulY : Y → Y → Y) (posY : Y → Prop)
    (toY : X → Y) (toX : Y → X)
    (hpos : ∀ a, posY (toY a))
    (hmul_pos : ∀ a b, posY (mulY (toY a) (toY b)))
    (hleft : ∀ a, toX (toY a) = a)
    (hmul : ∀ a b, toX (mulY (toY a) (toY b)) = addX a b)
    (hinj : ∀ {u v}, posY u → posY v → toX u = toX v → u = v) (a b : X) :
    toY (addX a b) = mulY (toY a) (toY b) := by
  apply hinj (hpos (addX a b)) (hmul_pos a b)
  calc
    toX (toY (addX a b)) = addX a b := hleft (addX a b)
    _ = toX (mulY (toY a) (toY b)) := (hmul a b).symm

def pullbackLEBy (leY : Y → Y → Prop) (toY : X → Y) (a b : X) : Prop := leY (toY a) (toY b)

theorem pullback_add_right_mono_necSuf
    (addX : X → X → X) (mulY : Y → Y → Y) (leY : Y → Y → Prop) (toY : X → Y)
    (hmap : ∀ a b, toY (addX a b) = mulY (toY a) (toY b))
    (posY : Y → Prop) (hpos : ∀ c, posY (toY c))
    (hmul_mono : ∀ a b c, leY a b → posY c → leY (mulY a c) (mulY b c))
    {a b : X} (h : pullbackLEBy leY toY a b) (c : X) :
    pullbackLEBy leY toY (addX a c) (addX b c) := by
  unfold pullbackLEBy at h ⊢
  rw [hmap, hmap]
  exact hmul_mono (toY a) (toY b) (toY c) h (hpos c)

end Ising2DLambda.NecSuf.FreeEntropy
