/-
「1 の冪根は零でない」の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                このファイル
  背理法（w = 0 と仮定する）              intro h0 で仮定を取り、1 = 0 を導く
  鎖の第 1 段（1 = w^n）                  hw を対称に使う段
  鎖の第 2 段（w = 0 の代入）             h0 で書き換える段
  鎖の第 3 段（n = (n-1)+1）              Nat.sub_add_cancel hn の段
  鎖の第 4 段（冪の約束 z^{k+1}=z^k·z）   pow_succ の段
  鎖の第 5 段（積の零元 a·0 = 0）         mul_zero の段
  矛盾の核（体で 1 ≠ 0）                  one_ne_zero

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- `n ≥ 1` のとき、1 の `n` 乗根は零でない（`claim_root_of_unity_element_ne_zero`）。 -/
theorem rootOfUnityElementNeZero (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) : w ≠ 0 := by
  -- 背理法。w = 0 と仮定して 1 = 0 を導く。
  intro h0
  apply one_ne_zero (α := Qbar)
  calc
    (1 : Qbar) = w ^ n := ((mem_rootOfUnity).1 hw).symm
    _ = (0 : Qbar) ^ n := by rw [h0]
    _ = (0 : Qbar) ^ ((n - 1) + 1) := by rw [Nat.sub_add_cancel hn]
    _ = (0 : Qbar) ^ (n - 1) * 0 := pow_succ 0 (n - 1)
    _ = 0 := mul_zero _

end Ising2DLambda.AlgebraicEigenvalue
