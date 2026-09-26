/-
# 必要十分版: `c(M) ≤ 2 c_+(M)`（成分が非負の `W` と、対合の置換行列 `ε`）

人手証明のラベル: **`onsager_exact_solution`** の Step 3
（正本 `structured-latex/content/018_even_sector_closing.ts`）。
具体版は `Ising2D.onsager_step3_c_le_two_c_plus`（`Ising2D/Part018/Theorem010_OnsagerExactSolution.lean`）で、
本ファイルの `rayleighSup_le_two_mul_evenSectorRayleighSup` を `π = flipConf`
（`epsilonR M = permMat flipConf`）で特殊化したものである。

## 証明の手順（人手 Step 3 と同じ）

`x`（`‖x‖ = 1`）を任意に取り、`u_k := |x_k|`, `v := u + εu` とおく。

1. `uᵀWu ≥ |xᵀWx| ≥ xᵀWx`（三角不等式と `W_{kl} ≥ 0`）— `quad_le_quad_absVec`
2. `‖εu‖ = ‖u‖ = ‖x‖ = 1`（`ε` は置換行列）— `vecNormSq_permMat_mulVec`, `vecNormSq_absVec`
3. `εv = v`（`ε² = I`）、`v ≠ 0`（`v ≥ u ≥ 0`, `u ≠ 0`）
4. `‖v‖² = 2 + 2uᵀεu ≤ 4`（Cauchy–Schwarz `uᵀεu ≤ ‖u‖‖εu‖ = 1`）
5. `vᵀWv = 2uᵀWu + 2uᵀWεu ≥ 2uᵀWu`（`εᵀ = ε`, `εW = Wε`, `ε² = I`, `u, εu ≥ 0`, `W_{kl} ≥ 0`）
6. `c_+ ≥ v̂ᵀWv̂ = vᵀWv/‖v‖² ≥ 2uᵀWu/‖v‖² ≥ 2uᵀWu/4 = uᵀWu/2 ≥ xᵀWx/2`

## この主張に本質的に効いている構造

* `ε` が対合 `π` の置換行列であること（`(εx)_k = x_{π(k)}`、`εᵀ = ε`、`ε² = I`、ノルムを保つ）。
  `ε` が `σ^x_1 ⋯ σ^x_M` であることも、添字集合がスピン配置であることも効いていない。
* `W` が実対称半正定値であること（`c(M)`, `c_+(M)` の上限が定まることに使う）、`εW = Wε`、
  成分が**非負**であること。人手は `W_has_positive_entries`（正）を引くが、使うのは
  `0 ≤ W_{kl}`（三角不等式と `uᵀWεu ≥ 0`）だけである。
* `π` が不動点をもたないことは使っていない。
-/
import Ising2D.NecSuf.PermMatrix
import Ising2D.Part011.DefinitionSectorRayleighSup
import Ising2D.Part011.Claim005_PsdCauchySchwarz

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 置換行列の作用はノルムを保つ（成分の並べ替えは二乗和を変えない）。 -/
theorem vecNormSq_permMat_mulVec {π : n → n} (hπ : Function.Involutive π) (x : n → ℝ) :
    vecNormSq (permMat π *ᵥ x) = vecNormSq x := by
  rw [vecNormSq_eq_sum, vecNormSq_eq_sum]
  simp only [permMat_mulVec]
  exact Equiv.sum_comp (Function.Involutive.toPerm π hπ) (fun i => x i ^ 2)

/-- 成分が非負の行列と、成分が非負の 2 つのベクトルについて `aᵀWb ≥ 0`。 -/
theorem bilin_nonneg_of_nonneg {W : Matrix n n ℝ} (hW : ∀ k l, 0 ≤ W k l) {a b : n → ℝ}
    (ha : ∀ i, 0 ≤ a i) (hb : ∀ i, 0 ≤ b i) : 0 ≤ a ⬝ᵥ W *ᵥ b := by
  refine Finset.sum_nonneg fun i _ => mul_nonneg (ha i) ?_
  exact Finset.sum_nonneg fun j _ => mul_nonneg (hW i j) (hb j)

/-- **人手 `onsager_exact_solution` Step 3 の必要十分版**: `c(M) ≤ 2 c_+(M)`。 -/
theorem rayleighSup_le_two_mul_evenSectorRayleighSup [Nonempty n] {W : Matrix n n ℝ}
    (hW : W.IsSymm) (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hWnn : ∀ k l, 0 ≤ W k l)
    {π : n → n} (hπ : Function.Involutive π) (hcomm : permMat π * W = W * permMat π) :
    rayleighSup W ≤ 2 * evenSectorRayleighSup W (permMat π) := by
  refine csSup_le (rayleighSet_nonempty W) ?_
  rintro r ⟨x, hx, rfl⟩
  set ε : Matrix n n ℝ := permMat π with hεdef
  set u : n → ℝ := absVec x with hudef
  set v : n → ℝ := u + ε *ᵥ u with hvdef
  have hεsymm : ε.IsSymm := permMat_isSymm hπ
  have hεε : ε * ε = 1 := permMat_mul_self hπ
  -- `u ≥ 0` と `εu ≥ 0`（`ε` は置換行列）
  have hu0 : ∀ i, 0 ≤ u i := fun i => abs_nonneg _
  have hεu0 : ∀ i, 0 ≤ (ε *ᵥ u) i := fun i => by
    rw [hεdef, permMat_mulVec]
    exact hu0 _
  -- `‖u‖ = ‖x‖ = 1`、`‖εu‖ = ‖u‖ = 1`
  have hun : vecNormSq u = 1 := by rw [hudef, vecNormSq_absVec, hx]
  have hεun : vecNormSq (ε *ᵥ u) = 1 := by rw [hεdef, vecNormSq_permMat_mulVec hπ, hun]
  -- `εv = εu + ε²u = εu + u = v`
  have hεv : ε *ᵥ v = v := by
    rw [hvdef, Matrix.mulVec_add, Matrix.mulVec_mulVec, hεε, Matrix.one_mulVec, add_comm]
  -- `v ≥ u ≥ 0` かつ `u ≠ 0` より `v ≠ 0`（ここでは `‖v‖² ≥ ‖u‖² = 1 > 0` の形）
  have hvpos : 0 < vecNormSq v := by
    have hle : vecNormSq u ≤ vecNormSq v := by
      rw [vecNormSq_eq_sum, vecNormSq_eq_sum]
      refine Finset.sum_le_sum fun i _ => ?_
      have hi : u i ≤ v i := by
        rw [hvdef, Pi.add_apply]
        linarith [hεu0 i]
      exact pow_le_pow_left₀ (hu0 i) hi 2
    linarith
  -- Cauchy–Schwarz: `uᵀεu ≤ ‖u‖‖εu‖ = 1`
  have hcs : u ⬝ᵥ (ε *ᵥ u) ≤ 1 := by
    have h := Ising2D.psd_cauchy_schwarz (P := (1 : Matrix n n ℝ)) Matrix.isSymm_one
      (fun y => by simpa [vecNormSq] using vecNormSq_nonneg y) (ε *ᵥ u) u
    simp only [Matrix.one_mulVec] at h
    rw [show (ε *ᵥ u) ⬝ᵥ (ε *ᵥ u) = 1 from hεun, show u ⬝ᵥ u = 1 from hun, one_mul] at h
    exact le_of_abs_le ((sq_le_one_iff_abs_le_one _).1 h)
  -- `‖v‖² = ‖u‖² + 2uᵀεu + ‖εu‖² = 2 + 2uᵀεu ≤ 4`
  have hvn : vecNormSq v = 2 + 2 * (u ⬝ᵥ (ε *ᵥ u)) := by
    have h1 : u ⬝ᵥ u = 1 := hun
    have h2 : (ε *ᵥ u) ⬝ᵥ (ε *ᵥ u) = 1 := hεun
    rw [vecNormSq, hvdef, add_dotProduct, dotProduct_add, dotProduct_add,
      dotProduct_comm (ε *ᵥ u) u, h1, h2]
    ring
  have hv4 : vecNormSq v ≤ 4 := by rw [hvn]; linarith
  -- `(εu)ᵀW(εu) = uᵀεWεu = uᵀWε²u = uᵀWu`
  have hεWε : (ε *ᵥ u) ⬝ᵥ W *ᵥ (ε *ᵥ u) = u ⬝ᵥ W *ᵥ u := by
    rw [← mulVec_dotProduct_selfadjoint hεsymm u (W *ᵥ (ε *ᵥ u)), Matrix.mulVec_mulVec,
      Matrix.mulVec_mulVec, hcomm, Matrix.mul_assoc, hεε, Matrix.mul_one]
  have hcross : (ε *ᵥ u) ⬝ᵥ W *ᵥ u = u ⬝ᵥ W *ᵥ (ε *ᵥ u) := dotProduct_mulVec_comm hW _ _
  -- `vᵀWv = 2uᵀWu + 2uᵀWεu ≥ 2uᵀWu`
  have hvW : v ⬝ᵥ W *ᵥ v = 2 * (u ⬝ᵥ W *ᵥ u) + 2 * (u ⬝ᵥ W *ᵥ (ε *ᵥ u)) := by
    rw [hvdef, Matrix.mulVec_add, add_dotProduct, dotProduct_add, dotProduct_add, hεWε, hcross]
    ring
  have hcrossnn : 0 ≤ u ⬝ᵥ W *ᵥ (ε *ᵥ u) := bilin_nonneg_of_nonneg hWnn hu0 hεu0
  have huWu : 0 ≤ u ⬝ᵥ W *ᵥ u := bilin_nonneg_of_nonneg hWnn hu0 hu0
  have hvW2 : 2 * (u ⬝ᵥ W *ᵥ u) ≤ v ⬝ᵥ W *ᵥ v := by rw [hvW]; linarith
  -- `v̂ := v/‖v‖` は `𝓕^{(+)}` の単位ベクトル
  set a : ℝ := vecNormSq v with hadef
  set c : ℝ := (Real.sqrt a)⁻¹ with hcdef
  have hc2 : c ^ 2 = a⁻¹ := by rw [hcdef, inv_pow, Real.sq_sqrt hvpos.le]
  have hunit : vecNormSq (c • v) = 1 := by
    rw [vecNormSq_smul, ← hadef, hc2, inv_mul_cancel₀ hvpos.ne']
  have hsec : ε *ᵥ (c • v) = c • v := by rw [Matrix.mulVec_smul, hεv]
  have hmax : (c • v) ⬝ᵥ W *ᵥ (c • v) ≤ evenSectorRayleighSup W ε :=
    le_evenSectorRayleighSup hW hpsd hsec hunit
  have hchain : x ⬝ᵥ W *ᵥ x / 2 ≤ evenSectorRayleighSup W ε :=
    calc x ⬝ᵥ W *ᵥ x / 2
        ≤ u ⬝ᵥ W *ᵥ u / 2 := by linarith [quad_le_quad_absVec hWnn x]
      _ = 2 * (u ⬝ᵥ W *ᵥ u) / 4 := by ring
      _ ≤ 2 * (u ⬝ᵥ W *ᵥ u) / a :=
          div_le_div_of_nonneg_left (by linarith) hvpos hv4
      _ ≤ v ⬝ᵥ W *ᵥ v / a := div_le_div_of_nonneg_right hvW2 hvpos.le
      _ = (c • v) ⬝ᵥ W *ᵥ (c • v) := by rw [quad_smul, hc2, div_eq_inv_mul]
      _ ≤ evenSectorRayleighSup W ε := hmax
  linarith

end Ising2D.NecSuf
