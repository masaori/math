/-
# 章 011 の実行列 `W` と複素行列としての物理的転送行列の同一視

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_001_definition_transfer_matrix_square_root`
  （ラベル **`def_transfer_matrix_square_root`**）
* `maxeig_001a_definition_symmetrized_transfer_matrix`
  （ラベル **`def_symmetrized_transfer_matrix`**）
* `maxeig_claim_symmetrized_transfer_matrix_on_sectors`
  （ラベル **`symmetrized_transfer_matrix_on_sectors`**、`W P^{(+)} = V^{(+)} P^{(+)}`）

章 011 の Rayleigh 商は実行列 `W` 上で述べる一方、転送行列は
`TensorPow M = Matrix (Conf M) (Conf M) ℂ` 上で定義されている。本ファイルでは、
実成分で定めた `V₁¹⁄²`, `V₂`, `W` を明示し、各成分を `ℂ` へ埋め込むと
人手の `V_1^{1/2} = exp(½K_1D)`（`def_transfer_matrix_square_root`、右辺の式 `V1PauliForm` の `K_1/2` での値）と
`V_2`（`def_transfer_matrix` の `Ising2D.V2`）から作る対称化転送行列そのものになることを示す。
`V_1^{1/2}` の成分は、`first_transfer_matrix_pauli_form` を結合定数 `K_1/2` で使って
`def_transfer_matrix` の成分定義から読む。

これは同じ具体的な行列の二つの係数体での表示を突き合わせる主張なので、必要十分版は置かない。
-/
import Ising2D.Part004.ClaimFirstTransferMatrixPauliForm
import Ising2D.Part004.ClaimV1RestrictionToEigenspaces
import Ising2D.Part011.Definition001_SymmetrizedTransferMatrix

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 実成分で定める物理的転送行列 -/

/-- `V₁¹⁄²` の実行列表示。

対角成分は `exp((K₁/2) ∑_m μ(m)μ(m+1))` であり、非対角成分は `0`。 -/
noncomputable def physicalV1halfR (M : ℕ) (K1 : ℝ) : Matrix (Conf M) (Conf M) ℝ :=
  Matrix.diagonal fun I : Conf M =>
    Real.exp ((K1 / 2) * ∑ m : Fin M, sgn (I m) * sgn (I (nextSite m)))

/-- `V₂` の実行列表示。成分は `exp(K₂ ∑_m μ(m)μ'(m))`。 -/
noncomputable def physicalV2R (M : ℕ) (K2 : ℝ) : Matrix (Conf M) (Conf M) ℝ :=
  Matrix.of fun I J : Conf M =>
    Real.exp (∑ m : Fin M, K2 * sgn (I m) * sgn (J m))

/-- 章 011 で実ベクトルへ作用させる対称化転送行列
`W = V₁¹⁄² V₂ V₁¹⁄²`。 -/
noncomputable def physicalSymTransferR (M : ℕ) (K1 K2 : ℝ) :
    Matrix (Conf M) (Conf M) ℝ :=
  symTransfer (physicalV1halfR M K1) (physicalV2R M K2)

/-! ## `TensorPow` 上の物理的転送行列 -/

/-- **人手 `def_transfer_matrix_square_root` の `V_1^{1/2} := exp(½ K_1 D)`**
（`first_transfer_matrix_pauli_form` の右辺の式 `V1PauliForm` を結合定数 `K_1/2` で評価したもの）。 -/
noncomputable def physicalV1halfC (M : ℕ) (K1 : ℝ) : TensorPow M :=
  V1PauliForm M (((K1 / 2 : ℝ) : ℂ))

/-- **人手 `def_symmetrized_transfer_matrix` の `W = V_1^{1/2} V_2 V_1^{1/2}`**
（`V_2` は `def_transfer_matrix` の `V_2`）。 -/
noncomputable def physicalSymTransferC (M : ℕ) (K1 K2 : ℝ) : TensorPow M :=
  physicalV1halfC M K1 * V2 M K2 * physicalV1halfC M K1

/-- 実行列表示の `V₁¹⁄²` を成分ごとに `ℂ` へ埋め込むと `exp(½K_1D)` に一致する
（`first_transfer_matrix_pauli_form` を結合定数 `K_1/2` で引き、`def_transfer_matrix` の成分を読む）。 -/
theorem physicalV1halfC_eq_map (K1 : ℝ) :
    physicalV1halfC M K1 = (physicalV1halfR M K1).map Complex.ofRealHom := by
  rw [physicalV1halfC, ← first_transfer_matrix_pauli_form]
  ext I J
  rw [V1_apply]
  by_cases h : I = J
  · subst h
    rw [if_pos rfl, physicalV1halfR, Matrix.map_apply, Matrix.diagonal_apply_eq,
      Complex.ofRealHom_eq_coe]
  · rw [if_neg h, physicalV1halfR, Matrix.map_apply, Matrix.diagonal_apply_ne _ h, map_zero]

/-- 実行列表示の `V₂` を成分ごとに `ℂ` へ埋め込むと `def_transfer_matrix` の `V_2` に一致する
（人手 `W_has_positive_entries` Step 2 の成分表示）。 -/
theorem physicalV2C_eq_map (K2 : ℝ) :
    V2 M K2 = (physicalV2R M K2).map Complex.ofRealHom := by
  ext I J
  rw [V2_apply, physicalV2R, Matrix.map_apply, Matrix.of_apply, Complex.ofRealHom_eq_coe,
    Finset.mul_sum]
  simp only [mul_assoc]

/-- **章 011 の実行列 `W` と複素 `TensorPow` 上の対称化転送行列は同じ成分を持つ。**

左辺は人手の `V_1^{1/2}`, `V_2` から作る行列、右辺は章 011 の
Rayleigh 商で使う実行列を成分ごとに `ℂ` へ埋め込んだ行列である。 -/
theorem physicalSymTransferC_eq_map (K1 K2 : ℝ) :
    physicalSymTransferC M K1 K2 =
      (physicalSymTransferR M K1 K2).map Complex.ofRealHom := by
  rw [physicalSymTransferC, physicalSymTransferR, symTransfer,
    Matrix.map_mul, Matrix.map_mul, ← physicalV1halfC_eq_map K1,
    ← physicalV2C_eq_map K2]

/-! ## セクター射影後の表示 -/

/-- **人手本文 `symmetrized_transfer_matrix_on_sectors`: `W P^{(+)} = V^{(+)} P^{(+)}`。**

左辺では章 011 の実行列 `W` を成分ごとに `ℂ` へ埋め込む。右辺の `V^{(+)}` は章 010
`def_V_plus` の `VPlusOfTransfer`（`V_2` は `def_transfer_matrix` の `V_2`）。
証明は本文と同じく、`V1_restriction_to_eigenspaces` に結合定数 `K_1/2` を代入して
`f ∈ 𝓕^{(+)}` で `B f = C f` を得、`epsilon_projector_properties` (2) の `P^{(+)} x ∈ 𝓕^{(+)}` から
`B P = C P` を作り、`P C = C P`, `P V₂ = V₂ P` を一行ずつ代入する。
この代入の鎖で使う構造だけを残した必要十分版は `Ising2D.NecSuf.sandwich_mul_proj_eq` である。 -/
theorem symmetrized_transfer_matrix_on_sectors {K2 : ℝ} (K1 : ℝ)
    (hM : 2 ≤ M) (hK2 : 0 < K2) :
    (physicalSymTransferR M K1 K2).map Complex.ofRealHom * epsProjPlus M
      = VPlusOfTransfer M K1 K2 * epsProjPlus M := by
  rw [← physicalSymTransferC_eq_map K1 K2]
  let B : TensorPow M := physicalV1halfC M K1
  let C : TensorPow M := V1plusHalf M (K1 : ℂ)
  let V : TensorPow M := V2 M K2
  let P : TensorPow M := epsProjPlus M
  -- `V1_restriction_to_eigenspaces` の右辺の指数の中身は、結合定数 `K_1/2` で `(i/2)K_1H_1^{(+)}`
  have hhalf : V1plus M (((K1 / 2 : ℝ) : ℂ)) = C := by
    dsimp [C]
    rw [V1plus_exponential_representation, V1plusHalf]
    congr 1
    rw [Complex.ofReal_div]
    norm_num
    module
  -- 任意の `f ∈ 𝓕^{(+)}` について `B f = C f`
  have hBf : ∀ f : Conf M → ℂ, epsilon M *ᵥ f = f → B *ᵥ f = C *ᵥ f := by
    intro f hf
    dsimp [B]
    rw [physicalV1halfC, ← first_transfer_matrix_pauli_form, ← hhalf]
    exact V1_restriction_to_eigenspaces hM hf
  -- `(BP)x = B(Px) = C(Px) = (CP)x`
  have hBP : B * P = C * P := by
    refine Matrix.ext_of_mulVec_single fun i => ?_
    rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec]
    exact hBf _ (epsProjPlus_mulVec_mem _)
  have hCP : C * P = P * C := (commute_V1plusHalf_epsProjPlus (M := M) (K1 : ℂ)).eq
  have hVP : V * P = P * V := (commute_V2_epsProjPlus (M := M) hK2).eq
  change B * V * B * P = C * V * C * P
  exact NecSuf.sandwich_mul_proj_eq hBP hCP hVP

end Ising2D
