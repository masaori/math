/-
「対数順序群の順序は正整数倍で変わらない」の必要十分版。

使うのは、写像が正整数倍を冪へ送ること（補助等式）と、冪が像の上で順序を保ちかつ反映することだけ。
素数・素因数分解・有理数であることは本質でない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FreeEntropy

variable {X Y : Type*}

def pullbackLEBy' (leY : Y → Y → Prop) (toY : X → Y) (a b : X) : Prop := leY (toY a) (toY b)

theorem pullback_multiple_iff_necSuf
    (smulX : ℕ → X → X) (powY : Y → ℕ → Y) (leY : Y → Y → Prop) (toY : X → Y)
    (hmap : ∀ n a, toY (smulX n a) = powY (toY a) n)
    (hpow_iff : ∀ n, 1 ≤ n → ∀ a b : X, leY (powY (toY a) n) (powY (toY b) n) ↔ leY (toY a) (toY b))
    (n : ℕ) (hn : 1 ≤ n) (a b : X) :
    pullbackLEBy' leY toY a b ↔ pullbackLEBy' leY toY (smulX n a) (smulX n b) := by
  unfold pullbackLEBy'
  rw [hmap, hmap]
  exact (hpow_iff n hn a b).symm

end Ising2DLambda.NecSuf.FreeEntropy
