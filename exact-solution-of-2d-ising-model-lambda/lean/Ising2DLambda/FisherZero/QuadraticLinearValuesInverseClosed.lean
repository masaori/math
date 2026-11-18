import Ising2DLambda.FisherZero.QuadraticLinearValuesClosed

/-
本文「平方根の一次式の零でない値は逆元も一次式の値である」との対応:
非零ノルム `n` は `claim_quadratic_norm_nonzero` を引く。
`hprod` の四つの段は本文の分母の通分、差の平方、`b²=a` の代入、非零数の自己除法に対応する。
係数の部分体への所属を示してから、積が一であることにより逆元の表示を得る。
-/
namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 平方根の一次式の非零値の逆元も一次式の値である。 -/
theorem quadraticLinearValues_inv_mem (F : Subfield Qbar) (a b : Qbar)
    (ha : a ∈ F) (hb : b * b = a) (hbF : b ∉ F)
    (y : Qbar) (hy : y ∈ quadraticLinearValues F b) (hy0 : y ≠ 0) :
    y⁻¹ ∈ quadraticLinearValues F b := by
  obtain ⟨u, v, hu, hv, rfl⟩ := hy
  let n : Qbar := u * u - a * (v * v)
  have hnF : n ∈ F := F.sub_mem (F.mul_mem hu hu) (F.mul_mem ha (F.mul_mem hv hv))
  have hn0 : n ≠ 0 := quadraticNorm_ne_zero F a b u v ha hu hv hbF hb hy0
  have huF : u / n ∈ F := F.div_mem hu hnF
  have hvF : -(v / n) ∈ F := F.neg_mem (F.div_mem hv hnF)
  refine ⟨u / n, -(v / n), huF, hvF, ?_⟩
  have hprod : (u + v * b) * (u / n + -(v / n) * b) = 1 := by
    calc
      (u + v * b) * (u / n + -(v / n) * b) = (u + v * b) * (u - v * b) / n := by ring
      _ = (u * u - b * b * (v * v)) / n := by ring
      _ = n / n := by rw [hb]
      _ = 1 := div_self hn0
  exact inv_eq_of_mul_eq_one_right hprod

end Ising2DLambda.FisherZero
