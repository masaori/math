/-
# `ε` は不動点をもたない対合の置換行列（具体版。形式化の記録）

対応する人手の主張は、章 019 ごと本文から参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ退避した
もと `sector_001_claim_epsilon_is_permutation`（ラベル `epsilon_is_sign_flip_permutation`）である。
本ファイルは形式化の記録として残し、ビルドは通し続ける。

本文の主張も使う部分（`π`（`flipConf`）、実行列 `epsilonR`、`ε` の成分表示 `epsilon_apply`、
`epsilon_eq_ofReal_epsilonR`、`epsilonR_isSymm`、`epsilonR_mul_self`、`epsilonR_mulVec_apply`）は
`Ising2D/Part011/ClaimEpsilonIsRealSymmetric.lean` へ移した。本ファイルに残したのは
「`π` は不動点をもたない」と奇セクターの単位ベクトル `x_0` など、`(−)` セクターにだけ効く部分である。

必要十分版は `Ising2D/NecSuf/PermSector.lean`（同じラベル）。
本ファイルの (1)(3)(4) は必要十分版 `Ising2D.NecSuf.permMat_*` の**系として**導いてある。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| `π(k) =`（スピン配置 `-s_k` の番号） | `Ising2D.flipConf`（`Conf M = Fin M → Fin 2` の全成分反転） |
| (1) `ε e_k = e_{π(k)}`、成分は `0/1` | `epsilon_apply` / `epsilon_mulVec_basisVec` / `epsilonR_entry_zero_or_one` |
| (2) `π∘π = id`、`π(k) ≠ k` | `flipConf_involutive` / `flipConf_ne_self` |
| (3) `(εx)_k = x_{π(k)}` | `epsilonR_mulVec_apply` |
| (4) `x_0 = (1/√2)(e_1 - e_{π(1)}) ∈ 𝓕^{(-)}∩ℝ^{2^M}`、`‖x_0‖ = 1` | `oddUnit` / `epsilonR_mulVec_oddUnit` / `vecNormSq_oddUnit` |

## 実行列としての `ε`（`epsilonR`）を別に置く理由

章 011 の Rayleigh 商・セクター分解（`Ising2D.rayleighSup` / `sectorRayleighSup`）は
**実行列 `Matrix n n ℝ` と実ベクトル `n → ℝ`** の上で述べられている
（人手証明 `def_rayleigh_sup` が実ベクトルで上限を取っているため）。
一方、章 004 で定義した `Ising2D.epsilon M` は複素行列 `TensorPow M` の元である。
そこで本ファイルでは実行列版 `Ising2D.epsilonR M` を置き、
**両者の成分が一致すること**（`epsilon_eq_ofReal_epsilonR`）を証明して橋渡しする。
`ε` の成分が `0` と `1` しかない（人手証明 (1)）ので、この橋渡しは値の落ちない同一視である。
-/
import Ising2D.NecSuf.PermSector
import Ising2D.Part011.ClaimEpsilonIsRealSymmetric

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## スピン配置の符号反転 `π` -/

theorem flipIdx_ne_self (i : Fin 2) : flipIdx i ≠ i := by
  fin_cases i <;> decide

/-- **人手証明 (2) の後半 `π(k) ≠ k`**（`M ≥ 1` が要る。`M = 0` では配置が 1 つしかない）。 -/
theorem flipConf_ne_self (hM : 0 < M) (s : Conf M) : flipConf s ≠ s := by
  intro h
  exact flipIdx_ne_self (s ⟨0, hM⟩) (congrFun h ⟨0, hM⟩)

/-! ## 実行列としての `ε` の成分 -/

/-- **人手証明 (1) の「成分はすべて `0` か `1`」。** -/
theorem epsilonR_entry_zero_or_one (l k : Conf M) :
    epsilonR M l k = 0 ∨ epsilonR M l k = 1 :=
  NecSuf.permMat_entry_zero_or_one _ l k

/-- **人手証明 (1) の「各行にちょうど 1 個の `1`」。** -/
theorem epsilonR_row_sum (l : Conf M) : ∑ k, epsilonR M l k = 1 :=
  NecSuf.permMat_row_sum _ l

/-- **人手証明 (1) の「各列にちょうど 1 個の `1`」。** -/
theorem epsilonR_col_sum (k : Conf M) : ∑ l, epsilonR M l k = 1 := by
  have h : ∀ l : Conf M, epsilonR M l k = if l = flipConf k then 1 else 0 := by
    intro l
    rw [epsilonR_apply]
    by_cases hlk : k = flipConf l
    · rw [if_pos hlk, if_pos (by rw [hlk, flipConf_involutive])]
    · rw [if_neg hlk, if_neg (fun hc => hlk (by rw [hc, flipConf_involutive]))]
  simp [h]

/-! ## (4) 奇セクターの単位ベクトル `x_0` -/

/-- 人手証明の `e_1` にあたる基準配置（全サイトで `+1`）。 -/
def refConf (M : ℕ) : Conf M := fun _ => 0

/-- **人手証明 (4) の `x_0 = (1/√2)(e_1 - e_{π(1)})`。** -/
noncomputable def oddUnit (M : ℕ) : Conf M → ℝ :=
  (Real.sqrt 2)⁻¹ • (Pi.single (refConf M) (1 : ℝ) - Pi.single (flipConf (refConf M)) 1)

/-- **人手証明 (4) の `ε x_0 = -x_0`**（すなわち `x_0 ∈ 𝓕^{(-)}`）。 -/
theorem epsilonR_mulVec_oddUnit : epsilonR M *ᵥ oddUnit M = (-1 : ℝ) • oddUnit M := by
  rw [oddUnit, Matrix.mulVec_smul, Matrix.mulVec_sub, epsilonR_mulVec_single,
    epsilonR_mulVec_single, flipConf_involutive]
  rw [smul_comm]
  congr 1
  rw [neg_one_smul]
  abel

/-- 相異なる 2 つの標準基底ベクトルの差のノルムの 2 乗は `2`。 -/
theorem vecNormSq_single_sub_single {a b : Conf M} (hab : a ≠ b) :
    vecNormSq (Pi.single a (1 : ℝ) - Pi.single b 1) = 2 := by
  rw [vecNormSq, sub_dotProduct, single_dotProduct, single_dotProduct]
  simp only [Pi.sub_apply, Pi.single_eq_same, Pi.single_eq_of_ne hab,
    Pi.single_eq_of_ne (Ne.symm hab)]
  norm_num

/-- **人手証明 (4) の `‖x_0‖ = 1`**（ここでは `‖x_0‖² = 1` の形）。 -/
theorem vecNormSq_oddUnit (hM : 0 < M) : vecNormSq (oddUnit M) = 1 := by
  have hne : refConf M ≠ flipConf (refConf M) :=
    fun h => flipConf_ne_self hM (refConf M) h.symm
  rw [oddUnit, vecNormSq_smul, vecNormSq_single_sub_single hne]
  rw [inv_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]
  norm_num

/-- **人手証明 (4)**: `𝓕^{(-)} ∩ ℝ^{2^M}` は単位ベクトルを含む。
したがって人手証明 `c_minus_le_c_plus` Step 1 の `𝓡_- ≠ ∅` が言える。 -/
theorem sectorSet_neg_nonempty_epsilonR (hM : 0 < M) (W : Matrix (Conf M) (Conf M) ℝ) :
    (sectorSet W (epsilonR M) (-1 : ℝ)).Nonempty :=
  NecSuf.sectorSet_neg_nonempty W flipConf_involutive
    (flipConf_ne_self hM (refConf M))

/-- 人手証明 `c_minus_le_c_plus` Step 1 の `𝓡_+ ≠ ∅`。 -/
theorem sectorSet_pos_nonempty_epsilonR (W : Matrix (Conf M) (Conf M) ℝ) :
    (sectorSet W (epsilonR M) (1 : ℝ)).Nonempty :=
  NecSuf.sectorSet_pos_nonempty W flipConf_involutive

end Ising2D
