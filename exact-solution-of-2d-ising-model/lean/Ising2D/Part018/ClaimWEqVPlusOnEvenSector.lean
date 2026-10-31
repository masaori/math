/-
# `𝓕^{(+)}` の上で `W` と `V^{(+)}` は一致する（具体版）

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`closing_009_theorem_c_plus_equals_Lambda_half`、ラベル **`c_plus_equals_Lambda_half_integer`**）の
Step 0「`𝓕^{(+)}` の上で `W` と `V^{(+)}` が一致すること」。

`Ising2D.EvenSectorBridge`（`Theorem009_CPlusEqualsLambda.lean`）の欄 `hWV` を、
具体的な `W = physicalSymTransferR M K_1 K_2`（章 011）と `vPlusDataOf` の `V^{(+)}` の実行列表示 `VPlusR`
（`ClaimVPlusRealEntries.lean`）について与える。

## 人手証明との対応

| 人手 Step 0 の行 | Lean |
| --- | --- |
| `P^{(+)}x = ½(x + εx)`（`def_epsilon_projectors` の `P^{(+)}` の定義） | `epsProjPlus_mulVec_of_even` の 1 行目 |
| `= ½(x + x)`（`x ∈ 𝓕^{(+)}` より `εx = x`、`def_even_eigenvectors_of_epsilon`） | 同 2 行目 |
| `= x`（スカラー倍を整理する） | 同 3 行目 |
| `Wx = WP^{(+)}x`（直前の `P^{(+)}x = x`） | `W_mulVec_eq_VPlus_mulVec_of_even` の 1 行目 |
| `= V^{(+)}P^{(+)}x`（`symmetrized_transfer_matrix_on_sectors` の `WP^{(+)} = V^{(+)}P^{(+)}`） | 同 2 行目 |
| `= V^{(+)}x`（直前の `P^{(+)}x = x`） | 同 3 行目 |

人手 Step 0 は複素ベクトル `x ∈ 𝓕^{(+)}`（`def_even_eigenvectors_of_epsilon`）について述べ、
Step 1 でそれを実ベクトルへ `ℝ ⊂ ℂ` の包含を明示せずに適用する。Lean では実ベクトルを複素ベクトルへ送る写像 `cvec` と、
実行列を成分ごとに `ℂ` へ送る `map Complex.ofRealHom` を明示し、この 2 本だけで行き来する。
`hWV_physical` の `cvec` の往復は人手に無い段である。そこで使うのは次の補題である。

| 段 | Lean |
| --- | --- |
| 実行列 `ε` と複素行列 `ε`（章 011 `epsilon_is_real_symmetric`） | `epsilon_eq_ofReal_epsilonR` から `epsilon_eq_map_epsilonR` |
| `map Complex.ofRealHom` と `ℝ → ℂ` の埋め込みによる `map` の一致 | `map_ofRealHom_eq_map_coe`（`Complex.ofRealHom_eq_coe`） |
| `map Complex.ofRealHom` と `cvec` の両立 | `cvec_mulVec_ofRealHom`（`map_ofRealHom_eq_map_coe` と `Theorem009_CPlusEqualsLambda.lean` の `cvec_mulVec` から） |
| `V^{(+)} = VPlusOfTransfer` を `VPlus` の `s_2 = sinh 2K_2`, `K_2^*` での値へ（`def_V_plus`） | `VPlusOfTransfer_eq_VPlus`（`P.K2star := Kstar P.K2` は定義） |
| `V^{(+)}` は実行列 `VPlusR` の埋め込み（Step 2「`V^{(+)}` の成分は実である」） | `eq_map_reMat`, `VPlus_hasRealEntries` |
| `cvec` の単射性 | `cvec_injective` |

必要十分版は `NecSuf/EvenSectorAgreement.lean` に置く（`NecSuf.invProj_smul_of_fixed`、`NecSuf.smul_eq_of_mul_proj_eq`）。
具体版 `epsProjPlus_mulVec_of_even`・`W_mulVec_eq_VPlus_mulVec_of_even` がその特殊化として得られることは、
`epsProjPlus_mulVec_of_even_of_necSuf`・`W_mulVec_eq_VPlus_mulVec_of_even_of_necSuf` に書く
（行列 `A` を線型写像 `x ↦ A x` へ送り、`Conf M → ℂ` 上の線型写像の環の加群として作用させる）。
-/
import Ising2D.Part018.Theorem009_CPlusEqualsLambda
import Ising2D.Part018.ClaimVPlusRealEntries
import Ising2D.Part011.PhysicalSymTransferBridge
import Ising2D.Part011.ClaimEpsilonIsRealSymmetric
import Ising2D.NecSuf.EvenSectorAgreement

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 実ベクトルと複素ベクトルの行き来 -/

/-- 実行列の成分ごとの埋め込みを `Complex.ofRealHom` で書いても、`ℝ → ℂ` の埋め込みで書いても同じ行列
（`Complex.ofRealHom_eq_coe`）。 -/
theorem map_ofRealHom_eq_map_coe {n : Type*} (A : Matrix n n ℝ) :
    A.map Complex.ofRealHom = A.map (fun r : ℝ => (r : ℂ)) := by
  ext s t
  rw [Matrix.map_apply, Matrix.map_apply, Complex.ofRealHom_eq_coe]

/-- `map Complex.ofRealHom` で書いた `cvec_mulVec`。 -/
theorem cvec_mulVec_ofRealHom {n : Type*} [Fintype n] (A : Matrix n n ℝ) (x : n → ℝ) :
    A.map Complex.ofRealHom *ᵥ cvec x = cvec (A *ᵥ x) := by
  rw [map_ofRealHom_eq_map_coe]
  exact cvec_mulVec A x

/-- `cvec` は単射（成分ごとの `ℝ → ℂ` の埋め込みが単射）。 -/
theorem cvec_injective {n : Type*} : Function.Injective (cvec : (n → ℝ) → (n → ℂ)) := by
  intro x y h
  funext k
  have := congrFun h k
  simpa [cvec] using this

/-- 複素行列 `ε` は実行列 `ε` を成分ごとに `ℂ` へ埋め込んだもの（章 011 `epsilon_eq_ofReal_epsilonR`）。 -/
theorem epsilon_eq_map_epsilonR : epsilon M = (epsilonR M).map Complex.ofRealHom := by
  ext l k
  rw [Matrix.map_apply, Complex.ofRealHom_eq_coe]
  exact epsilon_eq_ofReal_epsilonR l k

/-- 実ベクトル `x` が `ε x = x`（実行列 `ε`）を満たせば、その複素化も `ε x = x`（複素行列 `ε`）を満たす。 -/
theorem epsilon_mulVec_cvec_of_even {x : Conf M → ℝ} (hx : epsilonR M *ᵥ x = x) :
    epsilon M *ᵥ cvec x = cvec x := by
  rw [epsilon_eq_map_epsilonR, cvec_mulVec_ofRealHom, hx]

/-! ## 人手 Step 0 -/

/-- **人手 `c_plus_equals_Lambda_half_integer` Step 0 の前半**: `x ∈ 𝓕^{(+)}` なら `P^{(+)}x = x`。 -/
theorem epsProjPlus_mulVec_of_even {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    epsProjPlus M *ᵥ f = f :=
  calc epsProjPlus M *ᵥ f
      = (1 / 2 : ℂ) • (f + epsilon M *ᵥ f) := by
        -- `def_epsilon_projectors` の `P^{(+)} := ½(I + ε)`
        rw [epsProjPlus, Matrix.smul_mulVec, Matrix.add_mulVec, Matrix.one_mulVec]
    _ = (1 / 2 : ℂ) • (f + f) := by
        -- `x ∈ 𝓕^{(+)}` より `εx = x`（`def_even_eigenvectors_of_epsilon`）
        rw [hf]
    _ = f := by
        -- スカラー倍を整理する
        rw [← two_smul ℂ f, smul_smul]
        norm_num

/-- **人手 `c_plus_equals_Lambda_half_integer` Step 0 の後半（複素ベクトル上）**:
`x ∈ 𝓕^{(+)}` なら `W x = V^{(+)} x`（`W` は章 011 の実行列を成分ごとに `ℂ` へ埋め込んだもの、
`V^{(+)}` は `def_V_plus` の `VPlusOfTransfer`）。 -/
theorem W_mulVec_eq_VPlus_mulVec_of_even {K2 : ℝ} (K1 : ℝ) (hM : 2 ≤ M) (hK2 : 0 < K2)
    {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    (physicalSymTransferR M K1 K2).map Complex.ofRealHom *ᵥ f
      = VPlusOfTransfer M K1 K2 *ᵥ f := by
  have hP : epsProjPlus M *ᵥ f = f := epsProjPlus_mulVec_of_even hf
  calc (physicalSymTransferR M K1 K2).map Complex.ofRealHom *ᵥ f
      = (physicalSymTransferR M K1 K2).map Complex.ofRealHom *ᵥ (epsProjPlus M *ᵥ f) := by
        -- 直前の `P^{(+)}x = x`
        rw [hP]
    _ = VPlusOfTransfer M K1 K2 *ᵥ (epsProjPlus M *ᵥ f) := by
        -- `symmetrized_transfer_matrix_on_sectors` の `WP^{(+)} = V^{(+)}P^{(+)}`
        rw [Matrix.mulVec_mulVec, symmetrized_transfer_matrix_on_sectors K1 hM hK2,
          ← Matrix.mulVec_mulVec]
    _ = VPlusOfTransfer M K1 K2 *ᵥ f := by
        -- 直前の `P^{(+)}x = x`
        rw [hP]

/-! ## 必要十分版からの導出 -/

/-- `Conf M → ℂ` 上の線型写像の環で `2` は可逆（逆元は複素数 `1/2` 倍の写像。`ℂ` での `2` の逆元を
スカラー倍の写像 `algebraMap` で送る）。 -/
noncomputable instance invertibleTwoEndConf : Invertible (2 : Module.End ℂ (Conf M → ℂ)) :=
  haveI : Invertible (2 : ℂ) := invertibleOfNonzero two_ne_zero
  (Invertible.map (algebraMap ℂ (Module.End ℂ (Conf M → ℂ))) (2 : ℂ)).copy _ (map_ofNat _ 2).symm

/-- `⅟2` は複素数 `1/2` 倍の写像。 -/
theorem invOf_two_endConf_apply (v : Conf M → ℂ) :
    (⅟(2 : Module.End ℂ (Conf M → ℂ))) v = (1 / 2 : ℂ) • v := by
  change (algebraMap ℂ (Module.End ℂ (Conf M → ℂ)) (⅟(2 : ℂ))) v = _
  rw [Module.algebraMap_end_apply, invOf_eq_inv, one_div]

/-- `P^{(+)}` を線型写像へ送ると、必要十分版の `invProj` を `ε` の線型写像で評価したもの。 -/
theorem mulVecLin_epsProjPlus :
    (epsProjPlus M).mulVecLin = NecSuf.invProj (epsilon M).mulVecLin := by
  refine LinearMap.ext fun v => ?_
  rw [NecSuf.invProj, Module.End.mul_apply, invOf_two_endConf_apply, LinearMap.add_apply,
    Module.End.one_apply, Matrix.mulVecLin_apply, Matrix.mulVecLin_apply, epsProjPlus,
    Matrix.smul_mulVec, Matrix.add_mulVec, Matrix.one_mulVec]

/-- **具体版 `epsProjPlus_mulVec_of_even` は必要十分版 `NecSuf.invProj_smul_of_fixed` の特殊化**
（環は `Conf M → ℂ` 上の線型写像の環、`e` は `ε` の線型写像）。 -/
theorem epsProjPlus_mulVec_of_even_of_necSuf {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    epsProjPlus M *ᵥ f = f := by
  have h := NecSuf.invProj_smul_of_fixed (R := Module.End ℂ (Conf M → ℂ))
    (e := (epsilon M).mulVecLin) (f := f) hf
  rw [← mulVecLin_epsProjPlus] at h
  exact h

/-- **具体版 `W_mulVec_eq_VPlus_mulVec_of_even` は必要十分版 `NecSuf.smul_eq_of_mul_proj_eq` の特殊化**
（半群は `Conf M → ℂ` 上の線型写像の環、`B, C, P` は `W, V^{(+)}, P^{(+)}` の線型写像）。 -/
theorem W_mulVec_eq_VPlus_mulVec_of_even_of_necSuf {K2 : ℝ} (K1 : ℝ) (hM : 2 ≤ M) (hK2 : 0 < K2)
    {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    (physicalSymTransferR M K1 K2).map Complex.ofRealHom *ᵥ f
      = VPlusOfTransfer M K1 K2 *ᵥ f := by
  have hBP : ((physicalSymTransferR M K1 K2).map Complex.ofRealHom).mulVecLin * (epsProjPlus M).mulVecLin
      = (VPlusOfTransfer M K1 K2).mulVecLin * (epsProjPlus M).mulVecLin := by
    rw [Module.End.mul_eq_comp, Module.End.mul_eq_comp, ← Matrix.mulVecLin_mul, ← Matrix.mulVecLin_mul,
      symmetrized_transfer_matrix_on_sectors K1 hM hK2]
  exact NecSuf.smul_eq_of_mul_proj_eq (R := Module.End ℂ (Conf M → ℂ)) hBP
    (epsProjPlus_mulVec_of_even_of_necSuf hf)

/-- **`Ising2D.EvenSectorBridge.hWV`（人手 Step 0 を実ベクトル上で）**:
`ε x = x` を満たす実ベクトル `x` について、具体的な `W` と `V^{(+)}` の実行列表示 `VPlusR` は `x` に同じく作用する。 -/
theorem hWV_physical (P : IsingParam) (hM : 2 ≤ M) (x : Conf M → ℝ)
    (hx : epsilonR M *ᵥ x = x) :
    physicalSymTransferR M P.K1 P.K2 *ᵥ x = VPlusR P M *ᵥ x := by
  apply cvec_injective
  have hf : epsilon M *ᵥ cvec x = cvec x := epsilon_mulVec_cvec_of_even hx
  calc cvec (physicalSymTransferR M P.K1 P.K2 *ᵥ x)
      = (physicalSymTransferR M P.K1 P.K2).map Complex.ofRealHom *ᵥ cvec x :=
        (cvec_mulVec_ofRealHom _ x).symm
    _ = VPlusOfTransfer M P.K1 P.K2 *ᵥ cvec x :=
        W_mulVec_eq_VPlus_mulVec_of_even P.K1 hM P.K2_pos hf
    _ = VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ) *ᵥ cvec x := by
        -- `def_V_plus` が引く `V2_exponential_representation`（`K_2^* := Kstar K_2` は定義）
        rw [VPlusOfTransfer_eq_VPlus P.K2_pos]
        rfl
    _ = (VPlusR P M).map Complex.ofRealHom *ᵥ cvec x := by
        -- Step 2「`V^{(+)}` の成分は実である」の実行列表示
        rw [map_ofRealHom_eq_map_coe, VPlusR, ← eq_map_reMat (VPlus_hasRealEntries _ _ _)]
    _ = cvec (VPlusR P M *ᵥ x) := cvec_mulVec_ofRealHom _ x

end Ising2D
