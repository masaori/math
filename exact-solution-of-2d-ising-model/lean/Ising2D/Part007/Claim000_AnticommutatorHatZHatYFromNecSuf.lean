/-
# `hat(Z)`, `hat(Y)` の反交換関係 — 具体版を必要十分版の特殊化として導出する

対応する人手証明:
`parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ`
(`<anticommutator_of_hat_Z_and_hat_Y>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.acomm_hatZ_hatZ_same` / `acomm_hatZ_hatZ_opp` / `acomm_hatY_hatY`（`Claim000_AnticommutatorHatZHatY.lean`） | `TensorPow M` の `hat(Z), hat(Y)`（`Z_j, Y_j` の複素指数関数によるフーリエ和） |
| **必要十分版** | `NecSuf.acomm_fourier_clifford` / `acomm_fourier_clifford_flip`（`NecSuf/FourierClifford.lean`） | 体 `K` 上の任意の環 `A`、Clifford 関係、`ζ` が 1 の原始 `M` 乗根、両側の重みの積 |

本ファイルは、**具体版が必要十分版の特殊化にすぎないこと**を導出として書く。
特殊化で埋めるのは次の 3 点だけである。

* `Z, Y` が Clifford 関係を満たすこと（`acomm_Z_Z_clifford`, `acomm_Y_Y_clifford`。
  人手証明では `<anticommutator_of_Z_and_Y>`）
* 位相因子が `zetaM M = exp(2π√-1/M)` の整数べきであること（`expPhase_eq_zetaM_zpow_neg`）
* 重みの積 `firstSign η j * firstSign η' j` が `1`（複号同順）または
  `j = 1` でだけ `-1`（複号逆）になること

これにより「原文の 4 本の反交換関係に効いているのは Clifford 関係と
1 の原始 `M` 乗根の直交性だけで、行列であること・テンソル冪であること・
`Z, Y` の具体形・指数関数の解析的性質は効いていない」ことが確認できる。
-/
import Ising2D.NecSuf.FourierClifford
import Ising2D.Part004.Claim008_ExpSumFromNecSuf
import Ising2D.Part007.Claim000_AnticommutatorHatZHatY

namespace Ising2D

variable {M : ℕ}

/-! ## `hat(Z)`, `hat(Y)` を必要十分版の形（重み × 原始根のべき）に書き直す -/

/-- `hat(Z)_μ^{(±)}` を「重み `firstSign η` × `zetaM M` の整数べき」の形に書く。 -/
theorem hatZ_eq_weighted_zetaM (M : ℕ) (η : ℂ) (μ : ℤ) :
    hatZ M η μ = ∑ j : Fin M, (firstSign η j * zetaM M ^ ((((j : ℕ) : ℤ) + 1) * (-μ))) • Z j := by
  rw [hatZ]
  exact Finset.sum_congr rfl fun j _ => by
    rw [expPhase_eq_zetaM_zpow_neg M (((j : ℕ) : ℤ) + 1) μ]

/-- `hat(Y)_μ` を「重み `1` × `zetaM M` の整数べき」の形に書く。 -/
theorem hatY_eq_weighted_zetaM (M : ℕ) (μ : ℤ) :
    hatY M μ
      = ∑ j : Fin M, ((1 : ℂ) * zetaM M ^ ((((j : ℕ) : ℤ) + 1) * (-μ))) • Y j := by
  rw [hatY]
  exact Finset.sum_congr rfl fun j _ => by
    rw [one_mul, expPhase_eq_zetaM_zpow_neg M (((j : ℕ) : ℤ) + 1) μ]

/-- `deltaMod` を必要十分版の右辺（`if M ∣ (-μ + -ν) then 1 else 0`）と同一視する。 -/
theorem deltaMod_eq_ite_neg (M : ℕ) (μ ν : ℤ) :
    (if (M : ℤ) ∣ (-μ + -ν) then (1 : ℂ) else 0) = deltaMod M (μ + ν) 0 := by
  rw [deltaMod, sub_zero, show (-μ + -ν) = -(μ + ν) by ring]
  simp only [dvd_neg]

/-! ## 具体版を必要十分版の系として導出する -/

/-- **原文 1（複号同順）を必要十分版の特殊化として導いた形**:
`[hat(Z)_μ^{(±)}, hat(Z)_ν^{(±)}]₊ = 2M δ^M_{μ+ν,0} I`。

必要十分版 `NecSuf.acomm_fourier_clifford` に `K := ℂ`, `A := TensorPow M`, `x = y := Z`,
`ζ := zetaM M`, `u = v := firstSign η` を代入したもの。
重みについて使うのは `firstSign η j * firstSign η j = 1`（原文の `η^2 = 1`）だけである。 -/
theorem acomm_hatZ_hatZ_same_of_necSuf (hM : M ≠ 0) {η : ℂ} (hη : η * η = 1) (μ ν : ℤ) :
    acomm (hatZ M η μ) (hatZ M η ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) := by
  have huv : ∀ j : Fin M, firstSign η j * firstSign η j = 1 := by
    intro j
    rw [firstSign]
    split
    · exact hη
    · rw [one_mul]
  rw [hatZ_eq_weighted_zetaM, hatZ_eq_weighted_zetaM,
    NecSuf.acomm_fourier_clifford hM (isPrimitiveRoot_zetaM hM) Z Z acomm_Z_Z_clifford
      (firstSign η) (firstSign η) huv (-μ) (-ν),
    deltaMod_eq_ite_neg]

/-- **原文 4 を必要十分版の特殊化として導いた形**: `[hat(Y)_μ, hat(Y)_ν]₊ = 2M δ^M_{μ+ν,0} I`。 -/
theorem acomm_hatY_hatY_of_necSuf (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (hatY M μ) (hatY M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) := by
  rw [hatY_eq_weighted_zetaM, hatY_eq_weighted_zetaM,
    NecSuf.acomm_fourier_clifford hM (isPrimitiveRoot_zetaM hM) Y Y acomm_Y_Y_clifford
      (fun _ => (1 : ℂ)) (fun _ => (1 : ℂ)) (fun _ => one_mul 1) (-μ) (-ν),
    deltaMod_eq_ite_neg]

/-- **原文 2（複号逆）を必要十分版の特殊化として導いた形**:
`[hat(Z)_μ^{(+)}, hat(Z)_ν^{(-)}]₊ = (2M δ^M_{μ+ν,0} - 4 exp(-2π√-1(μ+ν)/M)) I`。

必要十分版 `NecSuf.acomm_fourier_clifford_flip` に同じ代入をしたもの。重みについて使うのは
「積が `j = 1` でだけ `-1`、他では `1`」（原文の「`j = 1` の項の符号だけが反転する」）だけ。 -/
theorem acomm_hatZPlus_hatZMinus_of_necSuf (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (hatZPlus M μ) (hatZMinus M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0 - 4 * expPhase M (μ + ν)) • (1 : TensorPow M) := by
  have hflip : ∀ j : Fin M,
      firstSign (-1 : ℂ) j * firstSign (1 : ℂ) j = if (j : ℕ) = 0 then -1 else 1 := by
    intro j
    by_cases hj : (j : ℕ) = 0
    · rw [firstSign_of_val_eq_zero hj, firstSign_of_val_eq_zero hj, if_pos hj, mul_one]
    · rw [firstSign_of_val_ne_zero hj, firstSign_of_val_ne_zero hj, if_neg hj, mul_one]
  rw [hatZPlus_def, hatZMinus_def, hatZ_eq_weighted_zetaM, hatZ_eq_weighted_zetaM,
    NecSuf.acomm_fourier_clifford_flip hM (isPrimitiveRoot_zetaM hM) Z Z acomm_Z_Z_clifford
      (firstSign (-1 : ℂ)) (firstSign (1 : ℂ)) hflip (-μ) (-ν),
    deltaMod_eq_ite_neg]
  congr 2
  rw [show (-μ + -ν) = -(μ + ν) by ring, ← expPhase_eq_zetaM_zpow]

end Ising2D
