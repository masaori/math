/-
# クロネッカー積の各因子についての線型性（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000c_claim_kronecker_multilinear`、ラベル **`kronecker_multilinear`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備の `∏_{k≠j}(A_k)_{i_kj_k}`（`k ∈ {1,…,M}∖{j}` についての積） | `∏ k ∈ Finset.univ.erase j, x k (s k) (t k)` |
| 行列の成分の鎖の 5 行（`⊠` の定義 → 行列の和・スカラー倍は成分ごと → 複素数の分配律 → `⊠` の定義 → 行列の和・スカラー倍は成分ごと） | `siteProd_update_sum_smul_apply` の `calc` の 5 段 |
| 「`ν` は全単射だから、すべての成分が一致し両辺は等しい」 | `siteProd_update_sum_smul` の `Matrix.ext` |
| 「`r = 1, c_1 = c, B_1 = A_j` とすればスカラーを前に出す式を得る」 | `siteProd_update_smul` |
| 数ベクトルの場合（`(A_k)_{i_kj_k}` を `(v_k)_{i_k}` に置き換えた同じ 5 行） | `vecKron_update_sum_smul_apply` の `calc` の 5 段、`vecKron_update_sum_smul`、`vecKron_update_smul` |

- 人手の `A_1, …, A_M` は Lean の `x : Fin M → Mat(2, ℂ)`（人手の `A_k` は `x (k - 1)`）、人手の第 `j` 因子を `Σ_a c_aB_a` に
  置いた並びは Lean の `Function.update x j (∑ a ∈ t, c a • B a)` である。人手の `a = 1, …, r` は Lean の有限集合 `t` の元である
  （人手の `r ≥ 1` は Lean では使わない。`t` が空なら両辺とも零行列で、主張はそのまま成り立つ）。
- Lean の添字は `Conf M = Fin M → Fin 2` で、人手の `I = (i_1, …, i_M) ∈ 𝓘_M` をそのまま添字にするので、番号付け `ν` は
  Lean には現れない（`siteProd`（`Ising2D/Representation.lean`）の docstring）。
- 1 段目と 4 段目の「`⊠` の定義」は、`siteProd_apply`（人手 `def_kronecker` (2) の成分の式 `∏_k (A_k)_{i_kj_k}`）を引いた上で、
  積を第 `j` 因子とそれ以外の因子に分ける（`Finset.prod_erase_mul`）。人手は準備で `∏_{k≠j}` を置き、定義の積をこの形で読んでいる。
  第 `j` 因子以外が `A_k` のままであることは `Function.update_of_ne`、第 `j` 因子が置いた行列であることは `Function.update_self` である。
- 2 段目と 5 段目の「行列の和・スカラー倍は成分ごとの演算」（`finite_sum_of_matrices_entrywise`・`def_matrix_scalar_multiple`）は、
  既存の慣行どおり mathlib の `Matrix.sum_apply`・`Matrix.smul_apply`（数ベクトルは `Finset.sum_apply`・`Pi.smul_apply`）で閉じる。
- 3 段目の「複素数の分配律」は `Finset.mul_sum`（分配律を各項へ）と、`c_a` を前へ出す `mul_left_comm`（ℂ の可換律・結合律、
  `complex_numbers_form_a_field`）を各 `a` に当てたものである。

必要十分版は `Ising2D/NecSuf/KroneckerMultilinear.lean`、具体版をその特殊化として得るのは
`ClaimKroneckerMultilinearFromNecSuf.lean` である。
-/
import Ising2D.Representation
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionKroneckerProductOfVectors

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 1 段目・4 段目の「`⊠` の定義」: 第 `j` 因子を `C` に置いたクロネッカー積の成分は、
`∏_{k≠j}(A_k)_{i_kj_k}` と `C_{i_jj_j}` の積である。 -/
theorem siteProd_update_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M)
    (C : Matrix (Fin 2) (Fin 2) ℂ) (s t : Conf M) :
    siteProd M (Function.update x j C) s t
      = (∏ k ∈ Finset.univ.erase j, x k (s k) (t k)) * C (s j) (t j) := by
  rw [siteProd_apply, ← Finset.prod_erase_mul _ _ (Finset.mem_univ j), Function.update_self]
  congr 1
  exact Finset.prod_congr rfl fun k hk => by
    rw [Function.update_of_ne (Finset.ne_of_mem_erase hk)]

/-- **人手 `kronecker_multilinear` の成分の鎖**（5 行）:
`(A_1⊠⋯⊠(Σ_a c_aB_a)⊠⋯⊠A_M)_{I,J} = (Σ_a c_a(A_1⊠⋯⊠B_a⊠⋯⊠A_M))_{I,J}`。 -/
theorem siteProd_update_sum_smul_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M)
    {ι : Type*} (t : Finset ι) (c : ι → ℂ) (B : ι → Matrix (Fin 2) (Fin 2) ℂ) (s u : Conf M) :
    siteProd M (Function.update x j (∑ a ∈ t, c a • B a)) s u
      = (∑ a ∈ t, c a • siteProd M (Function.update x j (B a))) s u :=
  calc siteProd M (Function.update x j (∑ a ∈ t, c a • B a)) s u
      = (∏ k ∈ Finset.univ.erase j, x k (s k) (u k)) * (∑ a ∈ t, c a • B a) (s j) (u j) :=
        siteProd_update_apply x j _ s u                                     -- `⊠` の定義
    _ = (∏ k ∈ Finset.univ.erase j, x k (s k) (u k)) * (∑ a ∈ t, c a * B a (s j) (u j)) := by
        rw [Matrix.sum_apply]
        simp only [Matrix.smul_apply, smul_eq_mul]                           -- 行列の和・スカラー倍は成分ごとの演算
    _ = ∑ a ∈ t, c a * ((∏ k ∈ Finset.univ.erase j, x k (s k) (u k)) * B a (s j) (u j)) := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun a _ => mul_left_comm _ _ _            -- 複素数の分配律（と `c_a` を前へ出す可換律・結合律）
    _ = ∑ a ∈ t, c a * siteProd M (Function.update x j (B a)) s u :=
        Finset.sum_congr rfl fun a _ => by rw [siteProd_update_apply]        -- `⊠` の定義
    _ = (∑ a ∈ t, c a • siteProd M (Function.update x j (B a))) s u := by
        rw [Matrix.sum_apply]
        simp only [Matrix.smul_apply, smul_eq_mul]                           -- 行列の和・スカラー倍は成分ごとの演算

/-- **人手 `kronecker_multilinear`**（行列）:
`A_1⊠⋯⊠(Σ_a c_aB_a)⊠⋯⊠A_M = Σ_a c_a(A_1⊠⋯⊠B_a⊠⋯⊠A_M)`。 -/
theorem siteProd_update_sum_smul (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M)
    {ι : Type*} (t : Finset ι) (c : ι → ℂ) (B : ι → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (Function.update x j (∑ a ∈ t, c a • B a))
      = ∑ a ∈ t, c a • siteProd M (Function.update x j (B a)) :=
  Matrix.ext (siteProd_update_sum_smul_apply x j t c B)   -- すべての成分が一致する

/-- **人手 `kronecker_multilinear` の `r = 1` の場合**（行列）:
`A_1⊠⋯⊠(cA_j)⊠⋯⊠A_M = c(A_1⊠⋯⊠A_M)`。人手の「`r = 1, c_1 = c, B_1 = A_j` とすれば」は、
`siteProd_update_sum_smul` の `t` を `Fin 1` の全体、`c_1 := c`、`B_1 := A` としたものである
（Lean の第 `j` 因子 `A` は人手の `A_j`）。 -/
theorem siteProd_update_smul (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M) (c : ℂ)
    (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (Function.update x j (c • A)) = c • siteProd M (Function.update x j A) := by
  have h := siteProd_update_sum_smul x j (Finset.univ : Finset (Fin 1)) (fun _ => c) (fun _ => A)
  simpa only [Finset.univ_unique, Finset.sum_singleton] using h

/-- 数ベクトルの場合の「`⊠` の定義」: 第 `j` 因子を `w` に置いたクロネッカー積の成分は、
`∏_{k≠j}(v_k)_{i_k}` と `w_{i_j}` の積である。 -/
theorem vecKron_update_apply (v : Fin M → Fin 2 → ℂ) (j : Fin M) (w : Fin 2 → ℂ) (I : Conf M) :
    vecKron M (Function.update v j w) I
      = (∏ k ∈ Finset.univ.erase j, v k (I k)) * w (I j) := by
  rw [vecKron_apply, ← Finset.prod_erase_mul _ _ (Finset.mem_univ j), Function.update_self]
  congr 1
  exact Finset.prod_congr rfl fun k hk => by
    rw [Function.update_of_ne (Finset.ne_of_mem_erase hk)]

/-- **人手 `kronecker_multilinear` の数ベクトルの場合の成分の鎖**（行列の場合と同じ 5 行）。 -/
theorem vecKron_update_sum_smul_apply (v : Fin M → Fin 2 → ℂ) (j : Fin M)
    {ι : Type*} (t : Finset ι) (c : ι → ℂ) (w : ι → Fin 2 → ℂ) (I : Conf M) :
    vecKron M (Function.update v j (∑ a ∈ t, c a • w a)) I
      = (∑ a ∈ t, c a • vecKron M (Function.update v j (w a))) I :=
  calc vecKron M (Function.update v j (∑ a ∈ t, c a • w a)) I
      = (∏ k ∈ Finset.univ.erase j, v k (I k)) * (∑ a ∈ t, c a • w a) (I j) :=
        vecKron_update_apply v j _ I                                         -- `⊠` の定義
    _ = (∏ k ∈ Finset.univ.erase j, v k (I k)) * (∑ a ∈ t, c a * w a (I j)) := by
        rw [Finset.sum_apply]
        simp only [Pi.smul_apply, smul_eq_mul]                               -- 数ベクトルの和・スカラー倍は成分ごとの演算
    _ = ∑ a ∈ t, c a * ((∏ k ∈ Finset.univ.erase j, v k (I k)) * w a (I j)) := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun a _ => mul_left_comm _ _ _            -- 複素数の分配律（と `c_a` を前へ出す可換律・結合律）
    _ = ∑ a ∈ t, c a * vecKron M (Function.update v j (w a)) I :=
        Finset.sum_congr rfl fun a _ => by rw [vecKron_update_apply]         -- `⊠` の定義
    _ = (∑ a ∈ t, c a • vecKron M (Function.update v j (w a))) I := by
        rw [Finset.sum_apply]
        simp only [Pi.smul_apply, smul_eq_mul]                               -- 数ベクトルの和・スカラー倍は成分ごとの演算

/-- **人手 `kronecker_multilinear`**（数ベクトル）:
`v_1⊠⋯⊠(Σ_a c_aw_a)⊠⋯⊠v_M = Σ_a c_a(v_1⊠⋯⊠w_a⊠⋯⊠v_M)`。 -/
theorem vecKron_update_sum_smul (v : Fin M → Fin 2 → ℂ) (j : Fin M)
    {ι : Type*} (t : Finset ι) (c : ι → ℂ) (w : ι → Fin 2 → ℂ) :
    vecKron M (Function.update v j (∑ a ∈ t, c a • w a))
      = ∑ a ∈ t, c a • vecKron M (Function.update v j (w a)) :=
  funext (vecKron_update_sum_smul_apply v j t c w)   -- すべての成分が一致する

/-- **人手 `kronecker_multilinear` の `r = 1` の場合**（数ベクトル）:
`v_1⊠⋯⊠(cv_j)⊠⋯⊠v_M = c(v_1⊠⋯⊠v_M)`。 -/
theorem vecKron_update_smul (v : Fin M → Fin 2 → ℂ) (j : Fin M) (c : ℂ) (w : Fin 2 → ℂ) :
    vecKron M (Function.update v j (c • w)) = c • vecKron M (Function.update v j w) := by
  have h := vecKron_update_sum_smul v j (Finset.univ : Finset (Fin 1)) (fun _ => c) (fun _ => w)
  simpa only [Finset.univ_unique, Finset.sum_singleton] using h

end Ising2D
