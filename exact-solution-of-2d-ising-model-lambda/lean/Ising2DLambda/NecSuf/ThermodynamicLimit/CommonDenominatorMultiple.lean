/-
「共通分母の正整数倍は共通分母である」の必要十分版。

使うのは、`M` に作用する二つの環（ここでは値の側 `R` と証人の側 `S`）の倍の間を写像 `ι` が
`ι (n • x) = (φ n) • ι x` の形で交換すること、`φ` が積を保つこと、および `R` の倍の結合則
（`IsScalarTower`／`MulAction` の `mul_smul`）だけである。有理数・整数・素数・有限台は本質でない。
具体版は `R = ℚ`、`S = ℤ`、`φ = Int.cast ∘ Nat.cast`、`ι = toRational` の特殊化である。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {R S M M' : Type*} [Monoid R] [MulAction R M'] [SMul S M]

theorem multiple_clears_necSuf
    (ι : M → M') (φ : ℕ → R) (ψ : ℕ → S)
    (hφ_mul : ∀ a b : ℕ, φ (a * b) = φ a * φ b)
    (hcomm : ∀ (n : ℕ) (x : M), ι (ψ n • x) = φ n • ι x)
    (k N : ℕ) (l : M') (lN : M)
    (h : φ N • l = ι lN) :
    φ (k * N) • l = ι (ψ k • lN) := by
  calc
    φ (k * N) • l = (φ k * φ N) • l := by rw [hφ_mul]
    _ = φ k • (φ N • l) := mul_smul _ _ _          -- 倍の結合則
    _ = φ k • ι lN := by rw [h]                    -- N は共通分母
    _ = ι (ψ k • lN) := (hcomm k lN).symm          -- 倍と ι の交換

end Ising2DLambda.NecSuf.ThermodynamicLimit
