/-
「一次因子との分解の残りの因子の、その一次因子の根における値は零でない」の必要十分版。

具体版の本体が使うのは、2 つの分解の等式（f = l·g と f = l·B）・左因子の消去 1 回・
等しい元での値の書き換えだけである。したがって型 α・β に代数構造は一切不要で、
積は抽象の 2 項演算 mul でよく、値も抽象の写像 v でよい。
準備（因数定理・商の係数の上界・商の値の非零性）は具体版の側の作業であり、
ここでは仮定 hfg・hcancel・hg として受け取る。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem remaining_factor_value_necSuf {α β : Type*}
    (mul : α → α → α) (l f g B : α) (v : α → β) (z : β)
    (hfg : f = mul l g)
    (hfB : f = mul l B)
    -- 消去は「同じ左因子との積が等しければ等しい」という形で受け取る。
    -- 具体版ではこれが一次因子の消去（係数の帰納法）である。
    (hcancel : mul l B = mul l g → B = g)
    (hg : v g ≠ z) : v B ≠ z := by
  -- 本体: mul l B = f = mul l g から消去で B = g。
  have hBg : B = g := hcancel (by rw [← hfB, hfg])
  -- 値の鎖: v B = v g ≠ z。
  rw [hBg]
  exact hg

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
