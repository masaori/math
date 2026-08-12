/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  R := Qbar（体なので当然に環である）
  a := w ^ m        S := powerSum n m        inv := (w ^ m - 1)⁻¹
  hinv := inv_mul_cancel₀ hne1（hne1 は具体版の準備の段 w^m - 1 ≠ 0。
                               ここでだけ `w^m ≠ 1` と体であることを使う）
  hS := powerSum_mul_invariant hn hw m（ここでだけ S が μ_n にわたる冪の和であることと
                                        w ∈ μ_n を使う）

すなわち、この段が要求するのは**環であることと、`a - 1` が左逆元を持つことと、
`S` が `a` 倍で動かないこと**だけである。体であることも、代数閉であることも、
積が可換であることも、`S` の和としての作り方も使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityPowerSumZero

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 具体版は必要十分版の特殊化である。 -/
theorem powerSumZero_from_necSuf {n : ℕ} (hn : 1 ≤ n) [Fintype (RootOfUnity n)]
    {m : ℕ} {w : Qbar} (hw : w ∈ RootOfUnity n) (hne : w ^ m ≠ 1) :
    powerSum n m = 0 := by
  have hne1 : w ^ m - 1 ≠ 0 := by
    intro h
    apply hne
    calc w ^ m = (w ^ m - 1) + 1 := by rw [sub_add_cancel]
      _ = 0 + 1 := by rw [h]
      _ = 1 := zero_add 1
  exact NecSuf.AlgebraicEigenvalue.power_sum_zero_necSuf (R := Qbar)
    (inv_mul_cancel₀ hne1) (powerSum_mul_invariant hn hw m)

end Ising2DLambda.AlgebraicEigenvalue
