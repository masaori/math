/-
# `<recover_Z_Y_from_hatZ_hatY>` — 具体版を必要十分版の特殊化として導出する

対応する人手証明:
`parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ` (`<recover_Z_Y_from_hatZ_hatY>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.inverse_dft` / `recover_Y` / `recover_Z`（`Claim013_RecoverZY.lean`） | 複素指数関数と行列 `Z_j, Y_j` |
| **必要十分版** | `NecSuf.inverse_dft_necSuf`（`NecSuf/DiscreteFourier.lean`） | 任意の体 `K`、その中の 1 の原始 `M` 乗根 `ζ`、任意の `K`-加群 `V` |

特殊化で埋めるべきなのは「原文の位相因子が `zetaM M` の整数べきであること」だけである。
したがって原文の逆変換に効いているのは **1 の原始 `M` 乗根の直交性**と
**対象が係数体上の加群であること**だけで、
行列であること・積があること・`Z, Y` の反交換関係は一切効いていない。
-/
import Ising2D.NecSuf.DiscreteFourier
import Ising2D.Part004.Claim008_ExpSumFromNecSuf
import Ising2D.Part004.Claim013_RecoverZY

namespace Ising2D

variable {M : ℕ}

/-- **具体版 `inverse_dft` を必要十分版の特殊化として導出した形**。

必要十分版 `NecSuf.inverse_dft_necSuf` に `K := ℂ`, `ζ := zetaM M`, `V := TensorPow M` を
代入し、`expPhase M k = zetaM M ^ (-k)` で位相因子を書き換えるだけで得られる。 -/
theorem inverse_dft_of_necSuf (hM : M ≠ 0) (x : Fin M → TensorPow M) (m : Fin M) :
    ∑ μ : Fin M, expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        (∑ j : Fin M, expPhase M ((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)) • x j)
      = (M : ℂ) • x m := by
  have hback : ∀ μ : Fin M,
      expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)))
        = zetaM M ^ ((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)) := by
    intro μ; rw [expPhase_eq_zetaM_zpow, neg_neg]
  have hfwd : ∀ j μ : Fin M,
      expPhase M ((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))
        = zetaM M ^ (-((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) := by
    intro j μ; rw [expPhase_eq_zetaM_zpow]
  simp_rw [hback, hfwd]
  exact NecSuf.inverse_dft_necSuf hM (isPrimitiveRoot_zetaM hM) x m

/-- **`<recover_Z_Y_from_hatZ_hatY>` Step 1 を必要十分版から導出した形**:
`∑_{μ=1}^M hat(Y)_μ exp(√-1 m · 2πμ/M) = M Y_m`。 -/
theorem recover_Y_of_necSuf (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        hatY M ((((μ : ℕ)) : ℤ) + 1)
      = (M : ℂ) • Y m := by
  simp_rw [hatY]
  exact inverse_dft_of_necSuf hM Y m

/-- **`<recover_Z_Y_from_hatZ_hatY>` Step 2 を必要十分版から導出した形**:
`∑_{μ=1}^M hat(Z)_μ^{(-)} exp(√-1 m · 2πμ/M) = M Z_m`。

`hat(Z)^{(+)}` ではなく `hat(Z)^{(-)}` でしか言えない理由も必要十分版から読める:
必要十分版の仮定は「重みが一様（`w ≡ 1`）」であり、`hat(Z)^{(+)}` は `j = 1` の重みが `-1` である。 -/
theorem recover_Z_of_necSuf (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        hatZMinus M ((((μ : ℕ)) : ℤ) + 1)
      = (M : ℂ) • Z m := by
  simp_rw [hatZMinus_eq]
  exact inverse_dft_of_necSuf hM Z m

end Ising2D
