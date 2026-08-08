/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

加法性: 必要十分版 `NecSuf.FreeEntropy.sub_add_sub_of_mul` に
  G := Λ（`LogOrderGroup`）
  e := logNat（1 以上の整数の対数）
を代入すると、具体版 `FreeEntropy.logRat_mul` の第 4・第 5 の等号が出る。
残るのは前置きと第 2 の等号（表示を取り、積の表示を作ること）で、これは必要十分版が仮定として
受け取っている部分である。

冪の法則: 必要十分版 `NecSuf.FreeEntropy.map_pow_eq_nsmul` に
  M := ℚ、G := Λ、f := logRat、P := (0 < ·)
を代入すると、具体版 `FreeEntropy.logRat_pow` が出る。
述語 `P` の閉性は「正の有理数の積は正の有理数」（`mul_pos`）である。

このことは、具体版の証明が「素数であること」「素因数分解であること」「値が Λ に住むこと」
「有理数であること」を使っていないという主張の裏取りになっている。

住処: ℕ / ℚ / Λ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.Additivity
import Ising2DLambda.NecSuf.FreeEntropy.Additivity

namespace Ising2DLambda.FreeEntropy

/-- 加法性の具体版を、必要十分版から導いたもの。 -/
theorem logRat_mul_from_necSuf {q₁ q₂ : ℚ} (h₁ : 0 < q₁) (h₂ : 0 < q₂) :
    logRat (q₁ * q₂) = logRat q₁ + logRat q₂ := by
  have hnum₁ : q₁.num.natAbs ≠ 0 := num_natAbs_ne_zero h₁
  have hnum₂ : q₂.num.natAbs ≠ 0 := num_natAbs_ne_zero h₂
  have hrepr₁ := repr_of_pos h₁
  have hrepr₂ := repr_of_pos h₂
  have hrepr : ((q₁.num.natAbs * q₂.num.natAbs : ℕ) : ℚ) / ((q₁.den * q₂.den : ℕ) : ℚ)
      = q₁ * q₂ := by
    push_cast
    rw [← div_mul_div_comm, hrepr₁, hrepr₂]
  rw [logRat_eq_of_repr (mul_pos h₁ h₂) (Nat.mul_ne_zero hnum₁ hnum₂)
      (Nat.mul_ne_zero q₁.den_nz q₂.den_nz) hrepr,
    logRat_eq_of_repr h₁ hnum₁ q₁.den_nz hrepr₁, logRat_eq_of_repr h₂ hnum₂ q₂.den_nz hrepr₂]
  exact NecSuf.FreeEntropy.sub_add_sub_of_mul logNat
    (fun {m n} hm hn => logNat_mul hm hn) hnum₁ q₁.den_nz hnum₂ q₂.den_nz

/-- 冪の法則の具体版を、必要十分版から導いたもの。 -/
theorem logRat_pow_from_necSuf {q : ℚ} (hq : 0 < q) (k : ℕ) :
    logRat (q ^ k) = k • logRat q :=
  NecSuf.FreeEntropy.map_pow_eq_nsmul logRat (fun r : ℚ => 0 < r)
    (by norm_num) (fun hx hy => mul_pos hx hy)
    logRat_one (fun hx hy => logRat_mul hx hy) hq k

end Ising2DLambda.FreeEntropy
