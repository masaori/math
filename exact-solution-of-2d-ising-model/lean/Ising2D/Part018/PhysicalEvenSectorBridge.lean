/-
# 具体的な `W` と `V^{(+)}` の橋渡し

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`closing_009_theorem_c_plus_equals_Lambda_half`、ラベル **`c_plus_equals_Lambda_half_integer`**）

`Ising2D.EvenSectorBridge`（`Theorem009_CPlusEqualsLambda.lean`）は、人手 `c_plus_equals_Lambda_half_integer` が
Step 1・Step 2 で使う `W` と `V^{(+)}` の事実を束ねた構造である。本ファイルは、その各欄を
具体的な `W = physicalSymTransferR M K_1 K_2`（章 011 の `V_1^{1/2} V_2 V_1^{1/2}`）と
`vPlusDataOf` の `V^{(+)}` について与え、構造 `Ising2D.physicalEvenSectorBridge` を立てる。

## 各欄と人手証明の対応

| 欄 | 人手 | Lean |
| --- | --- | --- |
| `W` | `def_symmetrized_transfer_matrix` の `W = V_1^{1/2} V_2 V_1^{1/2}` | `physicalSymTransferR M P.K1 P.K2` |
| `hWsymm` | `W_is_real_symmetric_positive_definite`（`W` は実対称） | `physicalSymTransferR_isSymm` |
| `hWpsd` | `W_is_real_symmetric_positive_definite`（`W` は正定値。`c_plus_equals_Lambda_half_integer` の Step 3 と `c_between_Lambda_half_and_twice_Lambda_half` の Step 1・Step 2 は、Rayleigh 上限の有界性のために `x^⊤Wx ≥ 0` だけを使う） | `physicalSymTransferR_nonneg` |
| `Vr`, `hVr` | Step 2「`V^{(+)}` の成分は実である」 | `VPlusR P M`, `vPlusDataOf_V_eq_map`（`ClaimVPlusRealEntries.lean`） |
| `hWV` | Step 0「`𝓕^{(+)}` の上で `W` と `V^{(+)}` は一致する」 | `hWV_physical`（`ClaimWEqVPlusOnEvenSector.lean`） |

`physicalSymTransferR_nonneg` の `x = 0` の場合分けは人手に無い段である。人手は Rayleigh 商を `‖x‖ = 1` の `x` についてしか
取らないので `x ≠ 0` の正定値性で足りるが、`EvenSectorBridge.hWpsd` はすべての `x` について述べているため、
`x = 0` では `0 ⬝ᵥ W *ᵥ 0 = 0` で閉じる。

## 仮定について

`2 ≤ M` は `hWV_physical`（章 011 `symmetrized_transfer_matrix_on_sectors`）が要求する。`M ≠ 0` は `checkFermiOf`・`vPlusDataOf`
（章 016・017）の型が要求する。`2 ≤ M` から従うが、`EvenSectorBridge` の型の添字に現れるので別に受け取る。
`K_2 > 0` は `IsingParam.K2_pos` から取る。

既に形式化した欄を具体的な行列について組み合わせただけなので、必要十分版は置かない
（各欄の必要十分な内容は `NecSuf/EvenSectorAgreement.lean` と `Ising2D/NecSuf/RayleighMoments.lean` にある）。
-/
import Ising2D.Part011.PhysicalPartitionFunctionSandwich
import Ising2D.Part018.ClaimWEqVPlusOnEvenSector

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 具体的な `W` は半正定値: すべての実ベクトル `x` について `x^⊤Wx ≥ 0`
（`x ≠ 0` なら `physicalSymTransferR_posDef`、`x = 0` なら `0^⊤W0 = 0`）。 -/
theorem physicalSymTransferR_nonneg (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (x : Conf M → ℝ) :
    0 ≤ x ⬝ᵥ physicalSymTransferR M K1 K2 *ᵥ x := by
  by_cases hx : x = 0
  · rw [hx, Matrix.mulVec_zero, dotProduct_zero]
  · exact (physicalSymTransferR_posDef K1 hK2 x hx).le

/-- **具体的な `W` と `vPlusDataOf` の `V^{(+)}` についての `Ising2D.EvenSectorBridge`**
（各欄の人手との対応はファイル冒頭の表）。 -/
noncomputable def physicalEvenSectorBridge (P : IsingParam) (hM2 : 2 ≤ M) (hM : M ≠ 0) :
    EvenSectorBridge M (checkFermiOf P hM) (vPlusDataOf P hM P.c2_mul_s2star_eq_c2star) where
  W := physicalSymTransferR M P.K1 P.K2
  hWsymm := physicalSymTransferR_isSymm P.K1 P.K2_pos
  hWpsd := physicalSymTransferR_nonneg P.K1 P.K2_pos
  Vr := VPlusR P M
  hVr := vPlusDataOf_V_eq_map P hM P.c2_mul_s2star_eq_c2star
  hWV := hWV_physical P hM2

/-- 橋渡しの `W` は具体的な `W = V_1^{1/2} V_2 V_1^{1/2}` である（定義）。 -/
theorem physicalEvenSectorBridge_W (P : IsingParam) (hM2 : 2 ≤ M) (hM : M ≠ 0) :
    (physicalEvenSectorBridge P hM2 hM).W = physicalSymTransferR M P.K1 P.K2 :=
  rfl

end Ising2D
