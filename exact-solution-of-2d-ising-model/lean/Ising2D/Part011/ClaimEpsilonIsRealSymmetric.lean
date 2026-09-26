/-
# `ε^⊤ = ε`（全スピン反転行列は実対称）と、実行列としての `ε`

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_claim_epsilon_is_real_symmetric`、ラベル **`epsilon_is_real_symmetric`**）

人手の主張: `ε` の成分はすべて実数であり、`ε^⊤ = ε`。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| `σ^x` の成分は実数で、クロネッカー積の成分は各因子の成分の積 | `epsilon_apply`（`ε_{l,k} = ∏_m (σ^x)_{l_m k_m}` を計算した値）/ `epsilon_eq_ofReal_epsilonR` |
| `ε^⊤ = (σ^x⊠⋯⊠σ^x)^⊤ = (σ^x)^⊤⊠⋯⊠(σ^x)^⊤ = σ^x⊠⋯⊠σ^x = ε` | `epsilon_transpose`（`epsilon_eq_siteProd` → `siteProd_transpose`（`kronecker_transpose`）→ `pauliX_transpose`） |
| 主張 | `epsilon_is_real_symmetric` |

## 実行列としての `ε`（`epsilonR`）を置く理由

章 011 の Rayleigh 商（`Ising2D.rayleighSup` / `evenSectorRayleighSup`）は実行列と実ベクトルの上で
述べる（人手 `def_rayleigh_sup` が実ベクトルで上限を取っているため）。そこで `ε` の成分が実数である
ことを、実行列 `epsilonR M` を置いて `ε` がその成分の埋め込みであること（`epsilon_eq_ofReal_epsilonR`）
として述べる。`epsilonR M` は符号反転 `π`（`flipConf`）の置換行列として定義してある。これは人手
`trace_of_epsilon_V_plus` の証明 Step 3 の (b)（`ε` は各基底ベクトルを別の基底ベクトルへ写す置換行列）
であり、`onsager_exact_solution` の Step 3 が使う（`epsilonR_mulVec_apply`）。

以上の内容（`flipConf` から `epsilon_eq_ofReal_epsilonR` まで）は、もと
`Part019/Claim001_EpsilonSignFlipPermutation.lean`（章 019 ごとノートへ退避）にあった。

必要十分版は置かない。置換行列の一般的な性質（対称性・対合性）は `Ising2D/NecSuf/PermMatrix.lean`
にあり、`epsilonR_isSymm` / `epsilonR_mul_self` はその系である。
-/
import Ising2D.NecSuf.PermMatrix
import Ising2D.Part010.Claim010_EpsilonCommutes
import Ising2D.Part009.Claim013_PositiveDefinite
import Ising2D.Part004.DefinitionConfigBasisIso

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## スピン配置の符号反転 `π` -/

/-- 1 サイトの符号反転（`Fin 2` の 2 元の入れ替え）。
人手証明の `μ(m) ↦ -μ(m)` を、`def_config_basis_iso` の同一視
（`+1 ↦ 0`, `-1 ↦ 1`）で読み替えたもの。 -/
def flipIdx : Fin 2 → Fin 2 := fun i => if i = 0 then 1 else 0

@[simp] theorem flipIdx_zero : flipIdx 0 = 1 := rfl
@[simp] theorem flipIdx_one : flipIdx 1 = 0 := rfl

theorem flipIdx_involutive : Function.Involutive flipIdx := by
  intro i
  fin_cases i <;> rfl

/-- **人手証明の `π`**: スピン配置 `s` を `-s` へ写す写像（全成分の符号反転）。 -/
def flipConf (s : Conf M) : Conf M := fun m => flipIdx (s m)

@[simp] theorem flipConf_apply (s : Conf M) (m : Fin M) : flipConf s m = flipIdx (s m) := rfl

/-- **人手証明 (2) の前半 `π∘π = id`。** -/
theorem flipConf_involutive : Function.Involutive (flipConf (M := M)) := by
  intro s
  funext m
  rw [flipConf_apply, flipConf_apply, flipIdx_involutive]

/-- スピン配置の言葉での `π`: `ι` の同一視のもとで `flipConf` は `μ ↦ -μ` である
（人手証明の `(-s_k)(m) = -s_k(m)`）。 -/
theorem sgn_flipConf (s : Conf M) (m : Fin M) : sgn (flipConf s m) = -sgn (s m) := by
  rw [flipConf_apply]
  generalize s m = i
  fin_cases i <;> simp [flipIdx, sgn]

/-! ## 実行列としての `ε` -/

/-- **実行列版の `ε`**: 符号反転 `π` の置換行列。 -/
noncomputable def epsilonR (M : ℕ) : Matrix (Conf M) (Conf M) ℝ :=
  NecSuf.permMat (flipConf (M := M))

theorem epsilonR_apply (l k : Conf M) :
    epsilonR M l k = if k = flipConf l then 1 else 0 := rfl

theorem epsilonR_isSymm : (epsilonR M).IsSymm := NecSuf.permMat_isSymm flipConf_involutive

theorem epsilonR_mul_self : epsilonR M * epsilonR M = 1 :=
  NecSuf.permMat_mul_self flipConf_involutive

/-- **人手証明 (3) `(εx)_k = x_{π(k)}`。** -/
theorem epsilonR_mulVec_apply (x : Conf M → ℝ) (k : Conf M) :
    (epsilonR M *ᵥ x) k = x (flipConf k) :=
  NecSuf.permMat_mulVec _ x k

/-- **人手証明 (1) `ε e_k = e_{π(k)}` の実行列版。** -/
theorem epsilonR_mulVec_single (k : Conf M) :
    epsilonR M *ᵥ (Pi.single k (1 : ℝ)) = Pi.single (flipConf k) 1 :=
  NecSuf.permMat_mulVec_single _ flipConf_involutive k

/-! ## 複素行列 `ε` との一致（成分が実数であること） -/

/-- `σ^x` の成分は `1` サイトの符号反転の置換行列である。 -/
theorem pauliX_apply_eq_ite (a b : Fin 2) :
    pauliX a b = if b = flipIdx a then 1 else 0 := by
  fin_cases a <;> fin_cases b <;> simp [pauliX, flipIdx]

/-- **人手証明 (1) の成分表示** `ε_{l,k} = δ_{k, π(l)}`。

`ε = σ^x_1 ⋯ σ^x_M` の成分は `∏_m (σ^x)_{l_m k_m}` であり、
これが `0` でないのは全サイトで `k_m ≠ l_m`、すなわち `k = π(l)` のときに限る。 -/
theorem epsilon_apply (l k : Conf M) :
    epsilon M l k = if k = flipConf l then 1 else 0 := by
  rw [epsilon_eq_siteProd, siteProd_apply]
  by_cases h : k = flipConf l
  · rw [if_pos h]
    refine Finset.prod_eq_one fun m _ => ?_
    rw [pauliX_apply_eq_ite, if_pos (by rw [h, flipConf_apply])]
  · rw [if_neg h]
    have hm : ∃ m : Fin M, k m ≠ flipIdx (l m) := by
      by_contra hc
      exact h (funext fun m => by
        rw [flipConf_apply, not_ne_iff.mp (not_exists.mp hc m)])
    obtain ⟨m, hmne⟩ := hm
    refine Finset.prod_eq_zero (Finset.mem_univ m) ?_
    rw [pauliX_apply_eq_ite, if_neg hmne]

/-- **複素行列 `ε` と実行列 `ε` の成分の一致。** -/
theorem epsilon_eq_ofReal_epsilonR (l k : Conf M) :
    epsilon M l k = ((epsilonR M l k : ℝ) : ℂ) := by
  rw [epsilon_apply, epsilonR_apply]
  by_cases h : k = flipConf l <;> simp [h]

/-- **人手証明 (1) `ε e_k = e_{π(k)}`**（`def_config_basis_iso` の標準基底 `f_I` で述べた版）。 -/
theorem epsilon_mulVec_basisVec (I : Conf M) :
    epsilon M *ᵥ basisVec I = basisVec (flipConf I) := by
  funext l
  rw [Matrix.mulVec, dotProduct, basisVec, Finset.sum_eq_single I]
  · rw [Pi.single_eq_same, mul_one, epsilon_apply, basisVec]
    by_cases h : l = flipConf I
    · rw [if_pos (by rw [h, flipConf_involutive]), h, Pi.single_eq_same]
    · rw [if_neg (fun hc => h (by rw [hc, flipConf_involutive])),
        Pi.single_eq_of_ne h]
  · intro j _ hj
    rw [Pi.single_eq_of_ne hj, mul_zero]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-! ## `ε^⊤ = ε` -/

/-- **人手証明の転置の鎖** `ε^⊤ = (σ^x⊠⋯⊠σ^x)^⊤ = (σ^x)^⊤⊠⋯⊠(σ^x)^⊤ = σ^x⊠⋯⊠σ^x = ε`。 -/
theorem epsilon_transpose : (epsilon M)ᵀ = epsilon M := by
  rw [epsilon_eq_siteProd, siteProd_transpose]
  simp only [pauliX_transpose]

/-- **人手本文 `epsilon_is_real_symmetric`**: `ε` の成分はすべて実数（`ε` は実行列 `epsilonR M` の
成分の埋め込み）であり、`ε^⊤ = ε`。 -/
theorem epsilon_is_real_symmetric :
    epsilon M = (epsilonR M).map (fun r : ℝ => (r : ℂ)) ∧ (epsilon M)ᵀ = epsilon M :=
  ⟨Matrix.ext fun l k => by rw [Matrix.map_apply, epsilon_eq_ofReal_epsilonR],
    epsilon_transpose⟩

end Ising2D
