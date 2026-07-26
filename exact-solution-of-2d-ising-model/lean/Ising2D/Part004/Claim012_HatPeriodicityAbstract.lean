/-
# `<hatZ_hatY_M_periodicity>` — 具体版を抽象版の特殊化として導出する

対応する人手証明:
`parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ` (`<hatZ_hatY_M_periodicity>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.hatZ_periodic` / `Ising2D.hatY_periodic`（`Claim012_HatPeriodicity.lean`） | 複素指数関数 `exp(-2π√-1 k/M)` と `Z_j, Y_j` |
| **抽象版** | `Abstract.transform_periodic`（`Abstract/DiscreteFourier.lean`） | 任意の体 `K`、`ζ^M = 1`、任意の `K`-加群 |

特殊化で埋めるべきなのは「原文の位相因子が `zetaM M` の整数べきであること」だけである。
したがって原文の周期性に効いているのは **`ζ^M = 1` の一点のみ**で、
`Z_j, Y_j` の代数的性質も、`hat(Z)^{(±)}` の重み `firstSign` も、複素指数関数の解析的性質も
一切効いていない。
-/
import Ising2D.Abstract.DiscreteFourier
import Ising2D.Part004.Claim008_ExpSumAbstract
import Ising2D.Part004.Claim012_HatPeriodicity

namespace Ising2D

variable {M : ℕ}

/-- 原文の位相因子を、抽象版が要求する形 `ζ^{a μ}` に書き換える
（周波数 `a = -(j+1)` として `zetaM M` のべきにする）。 -/
theorem expPhase_eq_zetaM_zpow_freq (M : ℕ) (a μ : ℤ) :
    expPhase M (a * μ) = zetaM M ^ ((-a) * μ) := by
  rw [expPhase_eq_zetaM_zpow]
  congr 1
  ring

/-- **`hat(Z)` の `M` 周期性を抽象版の特殊化として導出した形**:
`hat(Z)_{μ+M}^{(η)} = hat(Z)_μ^{(η)}`。 -/
theorem hatZ_periodic_of_abstract (hM : M ≠ 0) (η : ℂ) (μ : ℤ) :
    hatZ M η (μ + M) = hatZ M η μ := by
  simp_rw [hatZ, expPhase_eq_zetaM_zpow_freq]
  exact Abstract.transform_periodic hM (isPrimitiveRoot_zetaM hM)
    (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) (firstSign η) Z μ

/-- **`hat(Y)` の `M` 周期性を抽象版の特殊化として導出した形**:
`hat(Y)_{μ+M} = hat(Y)_μ`。 -/
theorem hatY_periodic_of_abstract (hM : M ≠ 0) (μ : ℤ) :
    hatY M (μ + M) = hatY M μ := by
  have h := Abstract.transform_periodic hM (isPrimitiveRoot_zetaM hM)
    (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) (fun _ : Fin M => (1 : ℂ)) Y μ
  simp only [one_mul] at h
  simpa only [hatY, expPhase_eq_zetaM_zpow_freq] using h

/-- **`<hatZ_hatY_M_periodicity>` の主張（`hat(Z)^{(-)}` の側）を抽象版から導出した形**:
`hat(Z)_M^{(-)} = hat(Z)_{-M}^{(-)}`。 -/
theorem hatZMinus_M_eq_neg_M_of_abstract (hM : M ≠ 0) :
    hatZMinus M (M : ℤ) = hatZMinus M (-(M : ℤ)) := by
  have h1 : hatZ M 1 ((0 : ℤ) + M) = hatZ M 1 0 := hatZ_periodic_of_abstract hM 1 0
  have h2 : hatZ M 1 ((-(M : ℤ)) + M) = hatZ M 1 (-(M : ℤ)) :=
    hatZ_periodic_of_abstract hM 1 _
  rw [neg_add_cancel] at h2
  rw [hatZMinus_def, hatZMinus_def, ← h2, ← h1, zero_add]

/-- **`<hatZ_hatY_M_periodicity>` の主張（`hat(Y)` の側）を抽象版から導出した形**:
`hat(Y)_M = hat(Y)_{-M}`。 -/
theorem hatY_M_eq_neg_M_of_abstract (hM : M ≠ 0) :
    hatY M (M : ℤ) = hatY M (-(M : ℤ)) := by
  have h1 : hatY M ((0 : ℤ) + M) = hatY M 0 := hatY_periodic_of_abstract hM 0
  have h2 : hatY M ((-(M : ℤ)) + M) = hatY M (-(M : ℤ)) := hatY_periodic_of_abstract hM _
  rw [neg_add_cancel] at h2
  rw [← h2, ← h1, zero_add]

end Ising2D
