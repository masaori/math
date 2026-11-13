/-
「非零巻き付きの頂点単純な閉路の循環総回転数は零である」
（`claim_nonzero_winding_simple_cycle_turning_zero`）の必要十分版。

具体版と同じ手順をとる。周期数 `c` の閉包 `Γ c` の回転数が隣の周期数で元の辺列の回転数だけ増えること
（周期数差）と、`c = 1, 2, 3` で回転数が二値 `upper`・`lower` のどちらかであることから、
`a := turn (Γ 1) - turn γ`、`b := turn γ` について `a + b`、`a + (b + b)`、`a + ((b + b) + b)` を
三つの閉包の回転数に書き、三項の補題の必要十分版へ渡す。

使うのは加法群の公理と、二値の差を二回足しても零にならないこと（`hdouble`）だけである。
辺列・閉包が何であるか（向き付き辺の列、一側閉包の構成）も、回転数が整数であることも、加法の可換性も使わない。
周期数差を `turn (Γ (c + 1)) = turn (Γ c) + turn γ` の向きで受けるのは、可換性なしで
`a + (b + b) = turn (Γ 2)` を組むためである。`hdouble` は三項の補題の必要十分版と同じ理由で要る
（二値の差が位数二なら、`b` をその差として三つの閉包が二値を交互に訪れられる）。
-/
import Ising2DLambda.NecSuf.KacWard.ThreeTermPmFourDifferenceZero

namespace Ising2DLambda.NecSuf.KacWard

theorem nonzero_winding_cycle_turning_zero_necSuf {W G : Type*} [AddGroup G]
    (turn : W → G) (γ : W) (Γ : ℕ → W) (upper lower : G)
    (hdouble : (-lower + upper) + (-lower + upper) ≠ 0)
    (hdiff : ∀ c : ℕ, 0 < c → turn (Γ (c + 1)) = turn (Γ c) + turn γ)
    (hpm : ∀ c : ℕ, 0 < c → turn (Γ c) = upper ∨ turn (Γ c) = lower) :
    turn γ = 0 := by
  -- 具体版の a, b
  let b : G := turn γ
  let a : G := turn (Γ 1) - b
  have h1 : a + b = turn (Γ 1) := sub_add_cancel (turn (Γ 1)) b
  have h2 : a + (b + b) = turn (Γ 2) := by
    calc a + (b + b) = (a + b) + b := (add_assoc a b b).symm
      _ = turn (Γ 1) + b := by rw [h1]
      _ = turn (Γ 2) := (hdiff 1 (by omega)).symm
  have h3 : a + ((b + b) + b) = turn (Γ 3) := by
    calc a + ((b + b) + b) = (a + (b + b)) + b := (add_assoc a (b + b) b).symm
      _ = turn (Γ 2) + b := by rw [h2]
      _ = turn (Γ 3) := (hdiff 2 (by omega)).symm
  exact (threeTermTwoValue_difference_zero_necSuf a b upper lower hdouble
    (by rw [h1]; exact hpm 1 (by omega))
    (by rw [h2]; exact hpm 2 (by omega))
    (by rw [h3]; exact hpm 3 (by omega))).1

end Ising2DLambda.NecSuf.KacWard
