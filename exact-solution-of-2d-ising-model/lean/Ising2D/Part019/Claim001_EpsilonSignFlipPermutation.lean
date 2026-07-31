/-
# `ε` は不動点をもたない対合の置換行列（具体版）

正本: `structured-latex/content/019_max_eigenvalue_sector.ts`
（`sector_001_claim_epsilon_is_permutation`、ラベル **`epsilon_is_sign_flip_permutation`**）

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
import Ising2D.Part010.Claim010_EpsilonCommutes
import Ising2D.Part010.Definition001_ConfigBasisIso

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

theorem flipIdx_ne_self (i : Fin 2) : flipIdx i ≠ i := by
  fin_cases i <;> decide

/-- **人手証明の `π`**: スピン配置 `s` を `-s` へ写す写像（全成分の符号反転）。 -/
def flipConf (s : Conf M) : Conf M := fun m => flipIdx (s m)

@[simp] theorem flipConf_apply (s : Conf M) (m : Fin M) : flipConf s m = flipIdx (s m) := rfl

/-- **人手証明 (2) の前半 `π∘π = id`。** -/
theorem flipConf_involutive : Function.Involutive (flipConf (M := M)) := by
  intro s
  funext m
  rw [flipConf_apply, flipConf_apply, flipIdx_involutive]

/-- **人手証明 (2) の後半 `π(k) ≠ k`**（`M ≥ 1` が要る。`M = 0` では配置が 1 つしかない）。 -/
theorem flipConf_ne_self (hM : 0 < M) (s : Conf M) : flipConf s ≠ s := by
  intro h
  exact flipIdx_ne_self (s ⟨0, hM⟩) (congrFun h ⟨0, hM⟩)

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

/-! ## 複素行列 `ε` との一致 -/

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
