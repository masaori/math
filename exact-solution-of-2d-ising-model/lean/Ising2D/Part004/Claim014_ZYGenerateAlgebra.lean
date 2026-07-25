/-
# `Z, Y` は `Mat(2, ℂ)^{⊗M}` を環として生成する

対応する人手証明:
`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` (`<Z_Y_generate_algebra>`)

原文の主張: `S = {Z_1, …, Z_M, Y_1, …, Y_M}` を含む最小の ℂ-部分多元環 `𝒜` は
`Mat(2, ℂ)^{⊗M}` 全体に一致する。

Lean では「`S` を含む最小の ℂ-部分多元環」を mathlib の `Algebra.adjoin ℂ S`
（`Subalgebra ℂ (TensorPow M)`）とし、結論を `Algebra.adjoin ℂ (ZYSet M) = ⊤` と述べる。

## 原文の証明との対応

| 原文 | Lean |
| --- | --- |
| Step 1（単一サイトの積公式・異サイト可換性） | `Ising2D/Part004/Definition000_...` の `pauli*`, `siteOp_mul_same`, `siteOp_mul_comm` |
| Step 2（帰納法で `σ^x_m, σ^y_m, σ^z_m ∈ 𝒜`） | `xString_mem_adjoin`, `sigmaX_mem_adjoin` ほか |
| Step 3 前半（`{I, σ^x, σ^y, σ^z}` は `Mat(2,ℂ)` の基底） | `matrix_two_decomp`（原文の成分比較の式そのもの） |
| Step 3 後半（基底のテンソル積が全体を張る） | `matrixUnitBasis`（`Ising2D/Representation.lean`）+ `E_eq_siteProd` |

Step 3 後半だけ原文と経路が違う。原文は基底として `{I, σ^x, σ^y, σ^z}^{⊗M}` を取り
`<tensor_basis>` を引くが、Lean では既に形式化済みの**行列単位の基底**
`matrixUnitBasis`（これも `<tensor_basis>` の帰結）を使うほうが短い。
どちらも「`𝒜` は ℂ-線型結合で閉じた部分空間で、ある基底を全部含むから全体」という論法で同じ。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols

namespace Ising2D

variable {M : ℕ}

/-! ## 生成元の集合 -/

/-- 原文の `S = {Z_1, …, Z_M, Y_1, …, Y_M}`。 -/
noncomputable def ZYSet (M : ℕ) : Set (TensorPow M) :=
  Set.range (Z : Fin M → TensorPow M) ∪ Set.range (Y : Fin M → TensorPow M)

theorem Z_mem_adjoin (m : Fin M) : Z m ∈ Algebra.adjoin ℂ (ZYSet M) :=
  Algebra.subset_adjoin (Or.inl ⟨m, rfl⟩)

theorem Y_mem_adjoin (m : Fin M) : Y m ∈ Algebra.adjoin ℂ (ZYSet M) :=
  Algebra.subset_adjoin (Or.inr ⟨m, rfl⟩)

/-! ## Step 2: `σ^x_k, σ^y_k, σ^z_k ∈ 𝒜`

原文の帰納法（`P_{m-1} = σ^x_1 ⋯ σ^x_{m-1} ∈ 𝒜` を仮定して
`σ^z_m = P_{m-1} Z_m`, `σ^y_m = P_{m-1} Y_m`, `σ^x_m = -√-1 σ^y_m σ^z_m` を得る）
をそのまま写したもの。 -/

/-- 原文 Step 2 の `σ^z_m = P_{m-1} Z_m`（`P_{m-1} P_{m-1} = I` を使う）。 -/
theorem sigmaZ_eq_xString_mul (k : Fin M) : sigmaZ k = xString M (k : ℕ) * Z k := by
  rw [Z_eq_xString_mul, ← mul_assoc, xString_mul_self, one_mul]

/-- 原文 Step 2 の `σ^y_m = P_{m-1} Y_m`。 -/
theorem sigmaY_eq_xString_mul (k : Fin M) : sigmaY k = xString M (k : ℕ) * Y k := by
  rw [Y_eq_xString_mul, ← mul_assoc, xString_mul_self, one_mul]

/-- 原文 Step 2 の帰納法の本体: `P_m = σ^x_1 ⋯ σ^x_m ∈ 𝒜`。 -/
theorem xString_mem_adjoin : ∀ n : ℕ, n ≤ M → xString M n ∈ Algebra.adjoin ℂ (ZYSet M) := by
  intro n
  induction n with
  | zero =>
      intro _
      rw [xString_zero]
      exact one_mem _
  | succ n ih =>
      intro hn
      have hnM : n < M := hn
      have hx : xString M n ∈ Algebra.adjoin ℂ (ZYSet M) := ih (le_of_lt hnM)
      have hZ : sigmaZ (⟨n, hnM⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
        rw [sigmaZ_eq_xString_mul]
        exact mul_mem hx (Z_mem_adjoin _)
      have hY : sigmaY (⟨n, hnM⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
        rw [sigmaY_eq_xString_mul]
        exact mul_mem hx (Y_mem_adjoin _)
      have hX : sigmaX (⟨n, hnM⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
        rw [sigmaX_eq]
        exact Subalgebra.smul_mem _ (mul_mem hY hZ) _
      rw [xString_succ n hnM]
      exact mul_mem hx hX

theorem sigmaZ_mem_adjoin (k : Fin M) : sigmaZ k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaZ_eq_xString_mul]
  exact mul_mem (xString_mem_adjoin _ (le_of_lt k.isLt)) (Z_mem_adjoin k)

theorem sigmaY_mem_adjoin (k : Fin M) : sigmaY k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaY_eq_xString_mul]
  exact mul_mem (xString_mem_adjoin _ (le_of_lt k.isLt)) (Y_mem_adjoin k)

theorem sigmaX_mem_adjoin (k : Fin M) : sigmaX k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaX_eq]
  exact Subalgebra.smul_mem _ (mul_mem (sigmaY_mem_adjoin k) (sigmaZ_mem_adjoin k)) _

/-! ## Step 3 前半: `{I, σ^x, σ^y, σ^z}` は `Mat(2, ℂ)` の基底 -/

/-- **原文 Step 3 の成分比較の式**:
任意の `B ∈ Mat(2, ℂ)` は `I, σ^x, σ^y, σ^z` の ℂ-線型結合で書ける。

  `B = ((b₁₁+b₂₂)/2) I + ((b₁₂+b₂₁)/2) σ^x + (√-1 (b₁₂-b₂₁)/2) σ^y + ((b₁₁-b₂₂)/2) σ^z`

（原文の添字 `1, 2` は Lean では `0, 1`。） -/
theorem matrix_two_decomp (B : Matrix (Fin 2) (Fin 2) ℂ) :
    B = ((B 0 0 + B 1 1) / 2) • (1 : Matrix (Fin 2) (Fin 2) ℂ)
      + ((B 0 1 + B 1 0) / 2) • pauliX
      + ((Complex.I * (B 0 1 - B 1 0)) / 2) • pauliY
      + ((B 0 0 - B 1 1) / 2) • pauliZ := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, pauliY, pauliZ] <;>
    ring_nf <;>
    simp only [Complex.I_sq] <;>
    ring

/-- 上をサイト `k` に載せた形。`siteOp k` が線型なのでそのまま持ち上がる。 -/
theorem siteOp_decomp (k : Fin M) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k B = ((B 0 0 + B 1 1) / 2) • (1 : TensorPow M)
      + ((B 0 1 + B 1 0) / 2) • sigmaX k
      + ((Complex.I * (B 0 1 - B 1 0)) / 2) • sigmaY k
      + ((B 0 0 - B 1 1) / 2) • sigmaZ k := by
  conv_lhs => rw [matrix_two_decomp B]
  rw [map_add, map_add, map_add, map_smul, map_smul, map_smul, map_smul, siteOp_one]
  rfl

/-- どんな `B ∈ Mat(2, ℂ)` を第 `k` 因子に載せても `𝒜` に入る。 -/
theorem siteOp_mem_adjoin (k : Fin M) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k B ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [siteOp_decomp]
  exact add_mem (add_mem (add_mem
    (Subalgebra.smul_mem _ (one_mem _) _)
    (Subalgebra.smul_mem _ (sigmaX_mem_adjoin k) _))
    (Subalgebra.smul_mem _ (sigmaY_mem_adjoin k) _))
    (Subalgebra.smul_mem _ (sigmaZ_mem_adjoin k) _)

/-! ## Step 3 後半: テンソル積が張る -/

/-- 単項テンソル `A_1 ⊗ ⋯ ⊗ A_M` は、各因子をサイト作用素として含む部分多元環に属する。

原文 Step 3 の「`σ_1^{a_1} ⋯ σ_M^{a_M} = e_1 ⊗ ⋯ ⊗ e_M`」（異サイト因子の積公式の反復）に対応。
Lean ではサイトの有限集合 `s` に関する帰納法で書く。 -/
theorem siteProd_mem (A : Subalgebra ℂ (TensorPow M)) (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ)
    (h : ∀ k, siteOp k (x k) ∈ A) : siteProd M x ∈ A := by
  classical
  have aux : ∀ s : Finset (Fin M),
      siteProd M (fun i => if i ∈ s then x i else 1) ∈ A := by
    intro s
    induction s using Finset.induction_on with
    | empty =>
        have h0 : (fun i : Fin M => if i ∈ (∅ : Finset (Fin M)) then x i else 1) = 1 := by
          funext i; simp
        rw [h0, siteProd_one]
        exact one_mem A
    | @insert k s hk ih =>
        have hstep : siteProd M (fun i => if i ∈ insert k s then x i else 1)
            = siteOp k (x k) * siteProd M (fun i => if i ∈ s then x i else 1) := by
          rw [siteOp_apply, ← siteProd_mul]
          congr 1
          funext i
          simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply, Finset.mem_insert]
          by_cases hik : i = k
          · subst hik
            simp [hk]
          · by_cases his : i ∈ s <;> simp [hik, his]
        rw [hstep]
        exact mul_mem (h k) ih
  have hall : (fun i : Fin M => if i ∈ (Finset.univ : Finset (Fin M)) then x i else 1) = x := by
    funext i; simp
  have huniv := aux Finset.univ
  rwa [hall] at huniv

/-- 行列単位 `E_{IJ}` は、各サイトの `Mat(2, ℂ)` の行列単位のテンソル積である。 -/
theorem E_eq_siteProd (I J : Conf M) :
    E I J = siteProd M (fun i => Matrix.single (I i) (J i) (1 : ℂ)) := by
  ext s t
  simp only [siteProd_apply, Matrix.single_apply, E]
  rw [Finset.prod_boole]
  simp [funext_iff, forall_and]

/-! ## 結論 -/

/-- **`<Z_Y_generate_algebra>` の形式化**:
`{Z_1, …, Z_M, Y_1, …, Y_M}` が生成する ℂ-部分多元環は `Mat(2, ℂ)^{⊗M}` 全体である。 -/
theorem Z_Y_generate_algebra (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  classical
  have hbasis : ∀ IJ : Conf M × Conf M,
      (matrixUnitBasis M) IJ ∈ Algebra.adjoin ℂ (ZYSet M) := by
    intro IJ
    rw [matrixUnitBasis_apply, E_eq_siteProd]
    exact siteProd_mem _ _ fun k => siteOp_mem_adjoin k _
  have hle : Submodule.span ℂ (Set.range (matrixUnitBasis M)) ≤
      Subalgebra.toSubmodule (Algebra.adjoin ℂ (ZYSet M)) := by
    rw [Submodule.span_le]
    rintro _ ⟨IJ, rfl⟩
    exact hbasis IJ
  rw [(matrixUnitBasis M).span_eq] at hle
  refine eq_top_iff.2 fun v _ => ?_
  exact hle (Submodule.mem_top)

end Ising2D
