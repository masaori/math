/-
# 抽象版: 対合の置換行列がつくるセクターと「成分の絶対値を取る」操作

人手証明のラベル（具体版と共通）:

* **`epsilon_is_sign_flip_permutation`**（正本 `structured-latex/content/019_max_eigenvalue_sector.ts`）
* **`abs_vector_moves_to_even_sector`**
* **`c_minus_le_c_plus`**
* **`c_equals_c_plus`**

具体版は `Ising2D/Part019/`（`Claim001_EpsilonSignFlipPermutation.lean`,
`Claim002_AbsVectorEvenSector.lean`, `Theorem003_CMinusLeCPlus.lean`,
`Theorem004_CEqualsCPlus.lean`）。具体版はすべて本ファイルの定理の**系として**導いてある。

## この主張に本質的に効いている構造（具体版が過剰な構造を要求していないかの検査）

章 019 の議論に効いているのは次の 3 つだけである。

1. **`ε` が「ある対合 `π : n → n` の置換行列」であること。**
   `ε` が `σ^x_1 ⋯ σ^x_M` であることも、`n` が `Conf M = Fin M → Fin 2` であることも、
   スピン配置の符号反転であることも効いていない。効くのは
   `(ε x)_k = x_{π(k)}` という成分表示ただ 1 つである。
2. **`W` の成分が非負であること。** 人手証明は `W_has_positive_entries`（**正**）を引くが、
   三角不等式 `|Σ x_k x_l W_{kl}| ≤ Σ |x_k||x_l|W_{kl}` に必要なのは `0 ≤ W_{kl}` だけで、
   **狭義の正値性は使っていない**（本ファイルの `quad_absVec_ge` の仮定は `0 ≤ W i j`）。
   `W` が転送行列であることも、指数関数で書けることも効いていない。
3. **`W` が実対称半正定値であること。** これは `c_±(M)` が上に有界であること
   （章 011 の `sectorSet_bddAbove`）を出すためだけに使う。

逆に、**人手証明 `epsilon_is_sign_flip_permutation` (2) の「`π` は不動点をもたない」は
`c_-(M) ≤ c_+(M)` には効いていない。** 不動点があってもよい。不動点をもたないことが
効くのは「`𝓡_-` が空でない」（人手証明 (4)、`c_-(M)` が意味をもつこと）の部分だけであり、
不等式そのものには不要である（`𝓡_-` が空なら `sSup ∅ = 0 ≤ c_+(M)` で自動的に成り立つ）。
本ファイルではこの切り分けを、`sectorRayleighSup_neg_le_pos`（不動点の仮定なし）と
`sectorSet_neg_nonempty`（不動点をもたない点だけを使う）に分けて明示した。

また、Perron–Frobenius 系の定理・スペクトル定理・行列の対角化可能性は一切使っていない
（章 011 と同じ方針）。使うのは有限個の実数の和・積・絶対値と三角不等式、
および実数の上限（`sSup`）だけである。

## 「抽象版」がなぜ章 011 の定義の上に乗っているか

章 011 の Lean 形式化（`Ising2D.rayleighSup` / `sectorRayleighSup`）は、すでに
**任意の実行列 `W : Matrix n n ℝ` と任意の実行列 `ε`** について述べられており、
Ising 模型の構造を含んでいない。したがって本章の抽象版は、その上に
「`ε` が対合の置換行列である」という仮定だけを追加した形になる。
-/
import Ising2D.Part011.Claim010_SectorDecomposition

set_option linter.unusedSectionVars false

namespace Ising2D.Abstract

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ## 対合の置換行列 -/

/-- 写像 `π : n → n` の置換行列 `(permMat π)_{i j} = δ_{j, π(i)}`（成分は `0` か `1`）。

人手証明 `epsilon_is_sign_flip_permutation` (1) の `ε_{l,k} = δ_{l,π(k)}` の抽象版。
（人手証明は列で書いているが、`π` が対合なので行で書いたこの形と一致する。） -/
def permMat (π : n → n) : Matrix n n ℝ := fun i j => if j = π i then 1 else 0

theorem permMat_apply (π : n → n) (i j : n) :
    permMat π i j = if j = π i then 1 else 0 := rfl

/-- 成分は `0` か `1` のいずれか。 -/
theorem permMat_entry_zero_or_one (π : n → n) (i j : n) :
    permMat π i j = 0 ∨ permMat π i j = 1 := by
  by_cases h : j = π i
  · exact Or.inr (by rw [permMat_apply, if_pos h])
  · exact Or.inl (by rw [permMat_apply, if_neg h])

/-- 各行の成分の和はちょうど `1`（各行にちょうど 1 個の `1` がある）。 -/
theorem permMat_row_sum (π : n → n) (i : n) : ∑ j, permMat π i j = 1 := by
  simp [permMat_apply]

/-- **人手証明 (3) `(ε x)_k = x_{π(k)}` の抽象版。** -/
theorem permMat_mulVec (π : n → n) (x : n → ℝ) (i : n) :
    (permMat π *ᵥ x) i = x (π i) := by
  rw [Matrix.mulVec, dotProduct]
  rw [Finset.sum_eq_single (π i)]
  · rw [permMat_apply, if_pos rfl, one_mul]
  · intro j _ hj
    rw [permMat_apply, if_neg hj, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-- **人手証明 (1) `ε e_k = e_{π(k)}` の抽象版。** -/
theorem permMat_mulVec_single (π : n → n) (hπ : Function.Involutive π) (k : n) :
    permMat π *ᵥ (Pi.single k (1 : ℝ)) = Pi.single (π k) 1 := by
  funext i
  rw [permMat_mulVec]
  by_cases h : i = π k
  · rw [h, hπ k, Pi.single_eq_same, Pi.single_eq_same]
  · rw [Pi.single_eq_of_ne (fun hc => h (by rw [← hc, hπ])), Pi.single_eq_of_ne h]

/-- 対合の置換行列は対称。 -/
theorem permMat_isSymm {π : n → n} (hπ : Function.Involutive π) : (permMat π).IsSymm := by
  ext i j
  show permMat π j i = permMat π i j
  rw [permMat_apply, permMat_apply]
  by_cases h : j = π i
  · rw [if_pos h, if_pos (by rw [h, hπ])]
  · rw [if_neg h, if_neg (fun hc => h (by rw [hc, hπ]))]

/-- 対合の置換行列は対合（`ε² = I`）。 -/
theorem permMat_mul_self {π : n → n} (hπ : Function.Involutive π) :
    permMat π * permMat π = 1 := by
  ext i k
  rw [Matrix.mul_apply, Finset.sum_eq_single (π i)]
  · rw [permMat_apply, if_pos rfl, one_mul, permMat_apply, hπ, Matrix.one_apply]
    simp [eq_comm]
  · intro j _ hj
    rw [permMat_apply, if_neg hj, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-! ## 成分ごとの絶対値 -/

/-- 人手証明の `u_k := |x_k|`。 -/
def absVec (x : n → ℝ) : n → ℝ := fun i => |x i|

@[simp] theorem absVec_apply (x : n → ℝ) (i : n) : absVec x i = |x i| := rfl

/-- **人手証明 `abs_vector_moves_to_even_sector` (1) の抽象版**:
奇セクターのベクトルの成分ごとの絶対値は偶セクターに入る。 -/
theorem permMat_mulVec_absVec {π : n → n} {x : n → ℝ}
    (hx : permMat π *ᵥ x = (-1 : ℝ) • x) :
    permMat π *ᵥ absVec x = (1 : ℝ) • absVec x := by
  funext k
  have hcomp : x (π k) = -x k := by
    have := congrFun hx k
    rwa [permMat_mulVec, Pi.smul_apply, smul_eq_mul, neg_one_mul] at this
  rw [permMat_mulVec, Pi.smul_apply, smul_eq_mul, one_mul, absVec_apply, absVec_apply,
    hcomp, abs_neg]

/-- **人手証明 `abs_vector_moves_to_even_sector` (2) の抽象版** `‖u‖ = ‖x‖`
（ここでは `‖·‖²` の形で述べる）。 -/
theorem vecNormSq_absVec (x : n → ℝ) : vecNormSq (absVec x) = vecNormSq x := by
  rw [vecNormSq_eq_sum, vecNormSq_eq_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [absVec_apply, sq_abs]

/-- 二次形式の成分表示 `xᵀWx = Σ_k Σ_l x_k W_{kl} x_l`。 -/
theorem quad_eq_sum (W : Matrix n n ℝ) (x : n → ℝ) :
    x ⬝ᵥ W *ᵥ x = ∑ k, ∑ l, x k * W k l * x l := by
  rw [dotProduct]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Matrix.mulVec, dotProduct, Finset.mul_sum]
  exact Finset.sum_congr rfl fun l _ => by ring

/-- **人手証明 `abs_vector_moves_to_even_sector` (3) の抽象版**
`uᵀWu ≥ |xᵀWx| ≥ xᵀWx`。

**仮定は `0 ≤ W_{kl}` だけ**（人手証明が引く `W_has_positive_entries` の狭義の正値性は不要）。 -/
theorem abs_quad_le_quad_absVec {W : Matrix n n ℝ} (hW : ∀ k l, 0 ≤ W k l) (x : n → ℝ) :
    |x ⬝ᵥ W *ᵥ x| ≤ absVec x ⬝ᵥ W *ᵥ absVec x := by
  rw [quad_eq_sum, quad_eq_sum]
  calc |∑ k, ∑ l, x k * W k l * x l|
      ≤ ∑ k, |∑ l, x k * W k l * x l| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ k, ∑ l, |x k * W k l * x l| :=
        Finset.sum_le_sum fun k _ => Finset.abs_sum_le_sum_abs _ _
    _ = ∑ k, ∑ l, absVec x k * W k l * absVec x l := by
        refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
        rw [abs_mul, abs_mul, abs_of_nonneg (hW k l)]
        rfl

theorem quad_le_quad_absVec {W : Matrix n n ℝ} (hW : ∀ k l, 0 ≤ W k l) (x : n → ℝ) :
    x ⬝ᵥ W *ᵥ x ≤ absVec x ⬝ᵥ W *ᵥ absVec x :=
  le_trans (le_abs_self _) (abs_quad_le_quad_absVec hW x)

/-! ## セクターの上限の比較 -/

/-- セクターに非零ベクトルが 1 つでもあれば、正規化して `𝓡_s` の元が作れる。 -/
theorem sectorSet_nonempty_of_mem [Nonempty n] {W ε : Matrix n n ℝ} {s : ℝ} {v : n → ℝ}
    (hv : ε *ᵥ v = s • v) (hv0 : v ≠ 0) : (sectorSet W ε s).Nonempty := by
  have ha : 0 < vecNormSq v := vecNormSq_pos hv0
  set c : ℝ := (Real.sqrt (vecNormSq v))⁻¹ with hc
  have hc2 : c ^ 2 = (vecNormSq v)⁻¹ := by
    rw [hc, inv_pow, Real.sq_sqrt ha.le]
  have hunit : vecNormSq (c • v) = 1 := by
    rw [vecNormSq_smul, hc2, inv_mul_cancel₀ ha.ne']
  exact ⟨_, ⟨c • v, sector_smul hv, hunit, rfl⟩⟩

/-- 偶セクター `𝓡_+` は空でない。

`π` に不動点があってもなくても、`e_i + e_{π(i)}` は `π` で不変な非零ベクトルである。 -/
theorem sectorSet_pos_nonempty [hn : Nonempty n] (W : Matrix n n ℝ) {π : n → n}
    (hπ : Function.Involutive π) :
    (sectorSet W (permMat π) (1 : ℝ)).Nonempty := by
  obtain ⟨i⟩ := id hn
  set v : n → ℝ := Pi.single i 1 + Pi.single (π i) 1 with hv
  have hinv : permMat π *ᵥ v = (1 : ℝ) • v := by
    rw [hv, Matrix.mulVec_add, permMat_mulVec_single π hπ, permMat_mulVec_single π hπ,
      hπ i, one_smul]
    abel
  have hv0 : v ≠ 0 := by
    intro h
    have hi : v i = 0 := by rw [h]; rfl
    rw [hv] at hi
    simp only [Pi.add_apply, Pi.single_eq_same] at hi
    rcases eq_or_ne (π i) i with he | he
    · rw [he, Pi.single_eq_same] at hi; norm_num at hi
    · rw [Pi.single_eq_of_ne (fun hc => he hc.symm)] at hi; norm_num at hi
  exact sectorSet_nonempty_of_mem hinv hv0

/-- 奇セクター `𝓡_-` は、`π` が不動点をもたなければ空でない
（人手証明 `epsilon_is_sign_flip_permutation` (4) の抽象版）。

`x_0 = (1/√2)(e_i - e_{π(i)})` が単位ベクトルとして取れる。 -/
theorem sectorSet_neg_nonempty [Nonempty n] (W : Matrix n n ℝ) {π : n → n} (hπ : Function.Involutive π)
    {i : n} (hfix : π i ≠ i) :
    (sectorSet W (permMat π) (-1 : ℝ)).Nonempty := by
  set v : n → ℝ := Pi.single i 1 - Pi.single (π i) 1 with hv
  have hinv : permMat π *ᵥ v = (-1 : ℝ) • v := by
    rw [hv, Matrix.mulVec_sub, permMat_mulVec_single π hπ, permMat_mulVec_single π hπ,
      hπ i, neg_one_smul]
    abel
  have hv0 : v ≠ 0 := by
    intro h
    have hi : v i = 0 := by rw [h]; rfl
    rw [hv] at hi
    simp only [Pi.sub_apply, Pi.single_eq_same] at hi
    rw [Pi.single_eq_of_ne (Ne.symm hfix)] at hi
    norm_num at hi
  exact sectorSet_nonempty_of_mem hinv hv0

theorem sectorRayleighSup_nonneg [Nonempty n] {W ε : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) {s : ℝ}
    (hne : (sectorSet W ε s).Nonempty) : 0 ≤ sectorRayleighSup W ε s := by
  obtain ⟨r, hr⟩ := hne
  obtain ⟨x, _, _, rfl⟩ := hr
  exact le_trans (hpsd x) (le_csSup (sectorSet_bddAbove hW hpsd ε s) ⟨x, ‹_›, ‹_›, rfl⟩)

/-- **人手証明 `c_minus_le_c_plus` の抽象版** `c_-(M) ≤ c_+(M)`。

仮定は「`W` が実対称半正定値で成分が非負」「`ε` が対合 `π` の置換行列」だけ。
**`π` が不動点をもたないことは仮定していない。** -/
theorem sectorRayleighSup_neg_le_pos [Nonempty n] {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hWnn : ∀ k l, 0 ≤ W k l)
    {π : n → n} (hπ : Function.Involutive π) :
    sectorRayleighSup W (permMat π) (-1 : ℝ) ≤ sectorRayleighSup W (permMat π) 1 := by
  rcases Set.eq_empty_or_nonempty (sectorSet W (permMat π) (-1 : ℝ)) with hemp | hne
  · rw [sectorRayleighSup, hemp, Real.sSup_empty]
    exact sectorRayleighSup_nonneg hW hpsd (sectorSet_pos_nonempty W hπ)
  · refine csSup_le hne ?_
    rintro r ⟨x, hx, hx1, rfl⟩
    have h1 : permMat π *ᵥ absVec x = (1 : ℝ) • absVec x := permMat_mulVec_absVec hx
    have h2 : vecNormSq (absVec x) = 1 := by rw [vecNormSq_absVec, hx1]
    refine le_trans (quad_le_quad_absVec hWnn x) ?_
    exact le_csSup (sectorSet_bddAbove hW hpsd _ _) ⟨absVec x, h1, h2, rfl⟩

/-- **人手証明 `c_equals_c_plus` Step 1 の抽象版** `c(M) = c_+(M)`。 -/
theorem rayleighSup_eq_sectorRayleighSup_pos [Nonempty n] {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hWnn : ∀ k l, 0 ≤ W k l)
    {π : n → n} (hπ : Function.Involutive π)
    (hcomm : permMat π * W = W * permMat π) :
    rayleighSup W = sectorRayleighSup W (permMat π) 1 := by
  rw [sector_decomposition_of_rayleigh_sup hW hpsd (permMat_isSymm hπ)
    (permMat_mul_self hπ) hcomm]
  exact max_eq_left (sectorRayleighSup_neg_le_pos hW hpsd hWnn hπ)

end Ising2D.Abstract
