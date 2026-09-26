/-
# 必要十分版: 対合の置換行列がつくるセクター（形式化の記録。人手の本文からは退避済み）

対応する人手の主張は、章 019 ごと本文から参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ退避した次の主張である
（`(−)` セクターを本文から外したため）。本ファイルは形式化の記録として残し、ビルドは通し続ける。

* `epsilon_is_sign_flip_permutation`
* `abs_vector_moves_to_even_sector`
* `c_minus_le_c_plus`
* `c_equals_c_plus`

置換行列 `permMat` と成分の絶対値 `absVec` の基本性質は、本文の主張
（`trace_of_epsilon_V_plus` の Step 3 (b)、`onsager_exact_solution` の Step 3）も使うので
`Ising2D/NecSuf/PermMatrix.lean` へ移した。

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

## 「必要十分版」がなぜ章 011 の定義の上に乗っているか

章 011 の Lean 形式化（`Ising2D.rayleighSup` / `sectorRayleighSup`）は、すでに
**任意の実行列 `W : Matrix n n ℝ` と任意の実行列 `ε`** について述べられており、
Ising 模型の構造を含んでいない。したがって本章の必要十分版は、その上に
「`ε` が対合の置換行列である」という仮定だけを追加した形になる。
-/
import Ising2D.Part011.Claim010_SectorDecomposition
import Ising2D.NecSuf.PermMatrix

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **ノートの `abs_vector_moves_to_even_sector` (1) の必要十分版**:
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
（人手証明 `epsilon_is_sign_flip_permutation` (4) の必要十分版）。

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

/-- **人手証明 `c_minus_le_c_plus` の必要十分版** `c_-(M) ≤ c_+(M)`。

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

/-- **人手証明 `c_equals_c_plus` Step 1 の必要十分版** `c(M) = c_+(M)`。 -/
theorem rayleighSup_eq_sectorRayleighSup_pos [Nonempty n] {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hWnn : ∀ k l, 0 ≤ W k l)
    {π : n → n} (hπ : Function.Involutive π)
    (hcomm : permMat π * W = W * permMat π) :
    rayleighSup W = sectorRayleighSup W (permMat π) 1 := by
  rw [sector_decomposition_of_rayleigh_sup hW hpsd (permMat_isSymm hπ)
    (permMat_mul_self hπ) hcomm]
  exact max_eq_left (sectorRayleighSup_neg_le_pos hW hpsd hWnn hπ)

end Ising2D.NecSuf
