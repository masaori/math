/-
# `<Z_Y_generate_algebra>` — 具体版を必要十分版の特殊化として導出する

対応する人手証明:
`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の `Z_Y_generate_algebra`

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.Z_Y_generate_algebra`（`ClaimZYGenerateAlgebra.lean`） | 複素行列・クロネッカー積・Pauli 行列 |
| **必要十分版** | `NecSuf.string_mem` / `NecSuf.local_mem` / `NecSuf.map_mem_of_mulSingle_mem` / `NecSuf.eq_top_of_span_eq_top`（`NecSuf/GeneratedByBasis.lean`） | 可換半環 `R` 上の代数、`Fin n` 添字の直積への積を保つ写像（`0 < n`）、全体を張る集合 |

本ファイルは、同じ結論 `Algebra.adjoin ℂ (ZYSet M) = ⊤` を
**必要十分版だけを論法として使って**導き直す（`Z_Y_generate_algebra_of_necSuf`）。

## 特殊化で埋めた「具体的な部分」

必要十分版に渡す具体的な部分は次の 3 つである（1 は具体版のファイルと `TheoremTensorBasisFromNecSuf.lean` の定義を使う）。
このうち複素 2×2 行列に依存しているのは 1 の `𝓑` が `Mat(2, ℂ)` を張ること（`matrix_two_decomp`）だけで、
`<tensor_basis>` (2) は `Mat(2, ℂ)` の任意の基底で、3 は `siteOp_one` と Step 2 だけで成り立つ。

1. `kroneckerTensorPowBasisOf M pauliBasis`（具体版の `ClaimZYGenerateAlgebra.lean` と
   `TheoremTensorBasisFromNecSuf.lean`）: `𝓑 = {I, σ^x, σ^y, σ^z}` が `Mat(2, ℂ)` の基底であること
   （原文 Step 3 前半の成分比較 `matrix_two_decomp` と `dim Mat(2,ℂ) = 4`）と、
   `<tensor_basis>` (2) を `𝓑` に適用した `𝓑^{⊠M}` が `Mat(2^M, ℂ)` の基底であること。
2. `siteProdHom`: クロネッカー積 `siteProd` が積を保つこと（`siteProd_mul`。`kronecker_product_rule` (1)）。
   必要十分版の帰納法は `P_1 := E_1` から始まるので `siteProd_one` は要らない。
   ただし `M = 0`（人手に現れない場合）は必要十分版の `0 < n` を満たさないので、具体版と同じく
   `siteProd_one` と (ii) で別に閉じる。
3. 各 `E_k = siteOp k e_k`（`e_k ∈ 𝓑`）が `𝒜` に入ること: `e_k = I` なら `siteOp_one`、
   `e_k = σ^x, σ^y, σ^z` なら `σ_k^x, σ_k^y, σ_k^z` の定義と、Step 2 の必要十分版の結論。

Step 2（Jordan–Wigner 文字列の帰納法）は、`P_m P_m = I` から得られる分解
`σ^z_m = P_m Z_m`, `σ^y_m = P_m Y_m` と漸化式 `P_{m+1} = P_m σ^x_m` を渡すだけで、
帰納法そのものは必要十分版 `NecSuf.string_mem` が担う。

## 必要十分版へ渡すための ℕ 添字化

必要十分版はサイト添字を `ℕ` にとり、仮定を `n < N` の範囲でだけ課す。
具体版のサイト添字は `Fin M` なので、`M` 未満では対応する元、`M` 以上では `1` を返す
族（`ZNat` 等）を作って渡す。範囲外の値は必要十分版の仮定にも結論にも現れない。
-/
import Ising2D.NecSuf.GeneratedByBasis
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimZYGenerateAlgebra

namespace Ising2D

variable {M : ℕ}

/-! ## ℕ 添字への読み替え -/

/-- 必要十分版へ渡すための `Z` の ℕ 添字版（`M` 以上では単位元）。 -/
noncomputable def ZNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Z ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `Y` の ℕ 添字版。 -/
noncomputable def YNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Y ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `σ^z` の ℕ 添字版。 -/
noncomputable def sigmaZNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaZ ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `σ^y` の ℕ 添字版。 -/
noncomputable def sigmaYNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaY ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `σ^x` の ℕ 添字版。 -/
noncomputable def sigmaXNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaX ⟨n, h⟩ else 1

/-! ## Step 2 を必要十分版から導出する -/

/-- **原文 Step 2（`P_m ∈ 𝒜`）を必要十分版 `NecSuf.string_mem` の特殊化として導出した形**。 -/
theorem xString_mem_adjoin_of_necSuf (n : ℕ) (hn : n ≤ M) :
    xString M n ∈ Algebra.adjoin ℂ (ZYSet M) := by
  refine NecSuf.string_mem (S := Algebra.adjoin ℂ (ZYSet M)) (p := xString M)
    (z := ZNat M) (y := YNat M) (zl := sigmaZNat M) (yl := sigmaYNat M) (xl := sigmaXNat M)
    (r := -Complex.I) (N := M) (xString_zero) ?_ ?_ ?_ ?_ ?_ ?_ n hn
  · intro k hk
    rw [sigmaZNat, dif_pos hk, ZNat, dif_pos hk, sigmaZ_eq_xString_mul]
  · intro k hk
    rw [sigmaYNat, dif_pos hk, YNat, dif_pos hk, sigmaY_eq_xString_mul]
  · intro k hk
    rw [sigmaXNat, dif_pos hk, sigmaYNat, dif_pos hk, sigmaZNat, dif_pos hk, sigmaX_eq]
  · intro k hk
    rw [sigmaXNat, dif_pos hk, xString_succ k hk]
  · intro k hk
    rw [ZNat, dif_pos hk]
    exact Z_mem_adjoin _
  · intro k hk
    rw [YNat, dif_pos hk]
    exact Y_mem_adjoin _

/-- 必要十分版 `NecSuf.local_mem` の特殊化: `σ^z_k, σ^y_k, σ^x_k ∈ 𝒜`。 -/
theorem sigma_mem_adjoin_of_necSuf (k : Fin M) :
    sigmaZ k ∈ Algebra.adjoin ℂ (ZYSet M) ∧ sigmaY k ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaX k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  have h := NecSuf.local_mem (S := Algebra.adjoin ℂ (ZYSet M)) (p := xString M)
    (z := ZNat M) (y := YNat M) (zl := sigmaZNat M) (yl := sigmaYNat M) (xl := sigmaXNat M)
    (r := -Complex.I) (N := M) (xString_zero)
    (by intro n hn; rw [sigmaZNat, dif_pos hn, ZNat, dif_pos hn, sigmaZ_eq_xString_mul])
    (by intro n hn; rw [sigmaYNat, dif_pos hn, YNat, dif_pos hn, sigmaY_eq_xString_mul])
    (by intro n hn; rw [sigmaXNat, dif_pos hn, sigmaYNat, dif_pos hn, sigmaZNat, dif_pos hn,
      sigmaX_eq])
    (by intro n hn; rw [sigmaXNat, dif_pos hn, xString_succ n hn])
    (by intro n hn; rw [ZNat, dif_pos hn]; exact Z_mem_adjoin _)
    (by intro n hn; rw [YNat, dif_pos hn]; exact Y_mem_adjoin _)
    (k : ℕ) k.isLt
  rw [sigmaZNat, dif_pos k.isLt, sigmaYNat, dif_pos k.isLt, sigmaXNat, dif_pos k.isLt] at h
  simpa using h

/-! ## Step 3 後半: 各 `E_k` は `𝒜` に属する -/

/-- 人手 Step 3 後半の「各 `E_k = I ⊠ ⋯ ⊠ e_k ⊠ ⋯ ⊠ I`（`e_k ∈ 𝓑`）は `𝒜` に属する」を、
Step 2 の必要十分版の結論 `sigma_mem_adjoin_of_necSuf` から得た形（場合分けは具体版
`siteOp_pauliFamily_mem_adjoin` と同じ）。 -/
theorem siteOp_pauliFamily_mem_adjoin_of_necSuf (k : Fin M) (j : Fin 4) :
    siteOp k (pauliFamily j) ∈ Algebra.adjoin ℂ (ZYSet M) := by
  obtain ⟨hz, hy, hx⟩ := sigma_mem_adjoin_of_necSuf k
  fin_cases j
  · change siteOp k (1 : Matrix (Fin 2) (Fin 2) ℂ) ∈ Algebra.adjoin ℂ (ZYSet M)
    rw [siteOp_one]; exact one_mem _
  · exact hx
  · exact hy
  · exact hz

/-! ## Step 3 後半: サイトごとの積 -/

/-- クロネッカー積 `siteProd` を積を保つ写像として束ねたもの（`kronecker_product_rule` (1)）。
必要十分版 `NecSuf.map_mem_of_mulSingle_mem` へ渡すのはこの性質だけである。 -/
noncomputable def siteProdHom (M : ℕ) :
    (Fin M → Matrix (Fin 2) (Fin 2) ℂ) →ₙ* TensorPow M where
  toFun := siteProd M
  map_mul' := siteProd_mul M

@[simp]
theorem siteProdHom_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProdHom M x = siteProd M x := rfl

/-- 「1 サイトだけ動かした族」を送ると、そのサイトのサイト作用素になる（`E_k` の定義）。 -/
theorem siteProdHom_mulSingle (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProdHom M (Pi.mulSingle k A) = siteOp k A := by
  rw [siteProdHom_apply, siteOp_apply]
  rfl

/-- **必要十分版 `NecSuf.map_mem_of_mulSingle_mem` の特殊化**:
クロネッカー積 `e_1 ⊠ ⋯ ⊠ e_M` は、各 `E_k` を含む部分多元環に属する
（具体版の `Ising2D.siteProd_mem` と同じ主張。`P_s` の帰納法は必要十分版 `NecSuf.prefixProduct_eq_and_mem` の中にある）。
`M = 0` は具体版の `siteProd_mem` と同じく `siteProd_one` と (ii) で閉じる（人手に現れない場合）。 -/
theorem siteProd_mem_of_necSuf (A : Subalgebra ℂ (TensorPow M))
    (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (h : ∀ k, siteOp k (x k) ∈ A) :
    siteProd M x ∈ A := by
  rcases Nat.eq_zero_or_pos M with hM | hM
  · subst hM
    have hx : x = 1 := funext fun i => i.elim0
    rw [hx, siteProd_one]
    exact one_mem A
  · have := NecSuf.map_mem_of_mulSingle_mem hM (siteProdHom M) A.toSubmonoid.toSubsemigroup x
      (fun k => by rw [siteProdHom_mulSingle]; exact h k)
    rwa [siteProdHom_apply] at this

/-! ## 結論 -/

/-- **`<Z_Y_generate_algebra>` を必要十分版から導出した形**:
`{Z_1, …, Z_M, Y_1, …, Y_M}` が生成する ℂ-部分多元環は `Mat(2^M, ℂ)` 全体である。

具体版 `Ising2D.Z_Y_generate_algebra` と**同じ形の主張**で、具体版と同じく基底 `𝓑^{⊠M}` の元
`e_1 ⊠ ⋯ ⊠ e_M` が `𝒜` に入ることから結論する。論法は `NecSuf/GeneratedByBasis.lean` の
必要十分版（`eq_top_of_span_eq_top`・`map_mem_of_mulSingle_mem`・`string_mem`・`local_mem`）に委ねている。
必要十分版へ渡すのは `𝓑^{⊠M}` が全体を張ること（`Basis.span_eq`）だけで、基底であること（線型独立性）は使わない。 -/
theorem Z_Y_generate_algebra_of_necSuf (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  refine NecSuf.eq_top_of_span_eq_top _ ?_ (kroneckerTensorPowBasisOf M pauliBasis).span_eq
  rintro _ ⟨p, rfl⟩
  rw [kroneckerTensorPowBasisOf_apply, coe_pauliBasis]
  exact siteProd_mem_of_necSuf _ _ fun k => siteOp_pauliFamily_mem_adjoin_of_necSuf k (p k)

end Ising2D
