/-
# 線型独立な族のクロネッカー積の族は線型独立

対応する人手証明:
`structured-latex/content/002_linear_space_general.ts` の `kronecker_family_of_independent_family_is_independent`

記号の読み替え（`ClaimKroneckerFamilyOfSpanningFamilySpans.lean` と同じ）:
- 人手の `b_1, …, b_4` は Lean の `b : Fin 4 → Mat(2, ℂ)`（添字は `0, …, 3`）、人手の `π(q) ∈ 𝒫 = {1,2,3,4}^M` は
  Lean の `p : Fin M → Fin 4` である。人手は `def_finite_sum_of_matrices` の `1, …, N` の和に合わせて `𝒫` を全単射 `π` で
  並べるが、Lean は `p` を添字とする有限和で書く。人手の「`π` は単射なので `π(q) = π(q_0)` は `q = q_0` と同値」は、
  Lean では `p = p_0` と `∀ k, p k = p_0 k` の同値（`funext`）である。
- 人手のサイト `k`（`1 ≤ k ≤ M`）は Lean の `k - 1`（0 始まり）である。人手の `s` 個組 `U ∈ {1,2}^s` と
  `M - s` 個組 `τ = (τ_{s+1}, …, τ_M)` は、Lean では長さ `M` の `U : Conf M`・`τ : Fin M → Fin 4` で持ち、
  `P^{(s)}` は `U, V` の第 `0, …, s-1` 成分だけを、`χ^{(s)}` は `τ` の第 `s, …, M-1` 成分だけを読む
  （`prefixEntryProduct_update_of_le`・`suffixLetterIndicator_update_of_lt`）。人手の `(U', u)` は Lean の
  `Function.update U ⟨s, _⟩ u`、`(a, τ')` は `Function.update τ ⟨s, _⟩ a` である（人手の `s` は Lean の `s + 1`）。
- 人手の `δ_{ij}`（`def_kronecker_delta`、`n → 4`）は Lean の `if i = j then 1 else 0`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備 (a) `P^{(0)}_q := 1_ℂ`、`P^{(s)}_q := Π_{k=1}^{s}(b_{π(q)_k})_{u_kv_k}`（`def_finite_product_of_complex_numbers` の漸化式） | `prefixEntryProduct`（同じ漸化式） |
| 準備 (a) の (R)（`s ≥ 2` の 3 行・`s = 1` の 4 行の鎖） | `prefixEntryProduct_succ`（Lean の `P` は `def_finite_product_of_complex_numbers` の漸化式そのもので定義するので、鎖の両端を結ぶ定義の式。鎖の中の `Π_{k=1}^{s}` の形は `prefixEntryProduct_eq_prod`） |
| Step 1 の「`P^{(M)}_q` の定義」（`Π_{k=1}^{M}`） | `prefixEntryProduct_eq_prod` |
| 準備 (b) `χ^{(M)}_q := 1_ℂ`、`χ^{(s-1)}_q((a,τ')) := δ_{π(q)_s a} χ^{(s)}_q(τ')` | `suffixLetterIndicator`（同じ漸化式） |
| 準備 (c) `A(s)` | `IndependenceStatement` |
| Step 1（`A(M)`、8 行の鎖） | `independenceStatement_top`（`calc` の 8 段） |
| Step 2 の `b_{π(q)_s} = Σ_a δ_{π(q)_s a} b_a`（δ の 2 行の鎖と 3 行の鎖） | `matrix_eq_sum_delta_smul` |
| Step 2 (2a)（11 行の鎖と `B = O`） | `independenceStep_B_eq_zero` |
| Step 2 (2b)（`B` の 6 行の鎖） | `independenceStep_B_eq_sum` |
| Step 2 (2c)・(2d)（6 行の鎖）と `A(s-1)` | `independenceStatement_pred` |
| Step 3（`A(0)`、下げる帰納法） | `independenceStatement_zero` |
| Step 4 `E(s)`（三つの場合の鎖） | `suffixLetterIndicator_eq` |
| Step 5（`q ≠ q_0` の 3 行の鎖と `d_{q_0}` の 6 行の鎖） | `kronecker_family_of_independent_family_is_independent` |

人手の主張は `M ≥ 1` で述べるが、Lean の証明は `M = 0` でもそのまま通るので `M` に条件を置かない。
必要十分版は置いていない（次の作業単位で要否を判断する。状態台帳の (d4c44p15b)）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerFamilyOfSpanningFamilySpans

namespace Ising2D

variable {M : ℕ}

/-- 人手の準備 (a) の `P^{(s)}_q(U, V)`。`def_finite_product_of_complex_numbers` の漸化式
（左から順に掛ける）に、`P^{(0)}_q := 1_ℂ` を添えたもの。`s ≥ M` の段は使わない（値は変えない）。 -/
noncomputable def prefixEntryProduct (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (p : Fin M → Fin 4)
    (U V : Conf M) : ℕ → ℂ
  | 0 => 1
  | s + 1 => prefixEntryProduct b p U V s *
      (if h : s < M then b (p ⟨s, h⟩) (U ⟨s, h⟩) (V ⟨s, h⟩) else 1)

/-- 人手の (R): `P^{(s)}_q((U',u),(V',v)) = P^{(s-1)}_q(U',V') (b_{π(q)_s})_{uv}`（人手の `s` は Lean の `s + 1`）。 -/
theorem prefixEntryProduct_succ (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (p : Fin M → Fin 4)
    (U V : Conf M) (s : ℕ) (h : s < M) :
    prefixEntryProduct b p U V (s + 1)
      = prefixEntryProduct b p U V s * b (p ⟨s, h⟩) (U ⟨s, h⟩) (V ⟨s, h⟩) := by
  rw [prefixEntryProduct, dif_pos h]

/-- `P^{(s)}` は `U, V` の第 `0, …, s-1` 成分だけを読む（人手の `U ∈ {1,2}^s` を長さ `M` の `U` で持つための読み替え）。 -/
theorem prefixEntryProduct_update_of_le (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (p : Fin M → Fin 4)
    (U V : Conf M) (j : Fin M) (u v : Fin 2) :
    ∀ s : ℕ, s ≤ (j : ℕ) →
      prefixEntryProduct b p (Function.update U j u) (Function.update V j v) s
        = prefixEntryProduct b p U V s
  | 0, _ => rfl
  | s + 1, hs => by
    have hsj : s < M := by omega
    have hne : (⟨s, hsj⟩ : Fin M) ≠ j := fun h => by rw [← h] at hs; simp at hs
    rw [prefixEntryProduct_succ _ _ _ _ s hsj, prefixEntryProduct_succ _ _ _ _ s hsj,
      Function.update_of_ne hne, Function.update_of_ne hne,
      prefixEntryProduct_update_of_le b p U V j u v s (by omega)]

/-- 人手 Step 1 の「`P^{(M)}_q` の定義」: `P^{(s)}_q = Π_{k=1}^{s}(b_{π(q)_k})_{u_kv_k}`
（Lean の有限積は `Fin s` の上の `Finset.prod`。漸化式は `Fin.prod_univ_castSucc` で読む）。 -/
theorem prefixEntryProduct_eq_prod (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (p : Fin M → Fin 4)
    (U V : Conf M) :
    ∀ (s : ℕ) (hs : s ≤ M), prefixEntryProduct b p U V s
      = ∏ k : Fin s, b (p (Fin.castLE hs k)) (U (Fin.castLE hs k)) (V (Fin.castLE hs k))
  | 0, _ => by rw [Fin.prod_univ_zero]; rfl
  | s + 1, hs => by
    rw [prefixEntryProduct_succ _ _ _ _ s (by omega), Fin.prod_univ_castSucc,
      prefixEntryProduct_eq_prod b p U V s (by omega)]
    rfl

/-- 人手の準備 (b) の `χ^{(s)}_q(τ)`: `χ^{(M)}_q := 1_ℂ`、`χ^{(s-1)}_q((a,τ')) := δ_{π(q)_s a} χ^{(s)}_q(τ')`。
Lean では `s` を `0` 始まりのサイトに読み替え、`s < M` の段で `δ_{p(s), τ(s)}` を掛ける。 -/
noncomputable def suffixLetterIndicator (p τ : Fin M → Fin 4) (s : ℕ) : ℂ :=
  if h : s < M then (if p ⟨s, h⟩ = τ ⟨s, h⟩ then 1 else 0) * suffixLetterIndicator p τ (s + 1)
  else 1
termination_by M - s

theorem suffixLetterIndicator_of_le (p τ : Fin M → Fin 4) (s : ℕ) (h : M ≤ s) :
    suffixLetterIndicator p τ s = 1 := by
  rw [suffixLetterIndicator, dif_neg (by omega)]

theorem suffixLetterIndicator_of_lt (p τ : Fin M → Fin 4) (s : ℕ) (h : s < M) :
    suffixLetterIndicator p τ s
      = (if p ⟨s, h⟩ = τ ⟨s, h⟩ then 1 else 0) * suffixLetterIndicator p τ (s + 1) := by
  rw [suffixLetterIndicator, dif_pos h]

/-- `χ^{(s)}` は `τ` の第 `s, …, M-1` 成分だけを読む（人手の `τ' ∈ {1,2,3,4}^{M-s}` を長さ `M` の `τ` で持つための読み替え）。 -/
theorem suffixLetterIndicator_update_of_lt (p τ : Fin M → Fin 4) (j : Fin M) (a : Fin 4) :
    ∀ n s : ℕ, s + n = M → (j : ℕ) < s →
      suffixLetterIndicator p (Function.update τ j a) s = suffixLetterIndicator p τ s
  | 0, s, hn, _ => by
    rw [suffixLetterIndicator_of_le _ _ _ (by omega), suffixLetterIndicator_of_le _ _ _ (by omega)]
  | n + 1, s, hn, hj => by
    have hs : s < M := by omega
    have hne : (⟨s, hs⟩ : Fin M) ≠ j := fun h => by rw [← h] at hj; simp at hj
    rw [suffixLetterIndicator_of_lt _ _ _ hs, suffixLetterIndicator_of_lt _ _ _ hs,
      Function.update_of_ne hne,
      suffixLetterIndicator_update_of_lt p τ j a n (s + 1) (by omega) (by omega)]

/-- 人手の準備 (c) の `A(s)`: すべての `U, V, τ` について `Σ_q d_q (P^{(s)}_q(U,V) χ^{(s)}_q(τ)) = 0_ℂ`。 -/
def IndependenceStatement (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (d : (Fin M → Fin 4) → ℂ) (s : ℕ) : Prop :=
  ∀ (U V : Conf M) (τ : Fin M → Fin 4),
    ∑ p, d p * (prefixEntryProduct b p U V s * suffixLetterIndicator p τ s) = 0

/-- 人手 Step 1: `A(M)`。8 行の鎖を `calc` の 8 段で示す。 -/
theorem independenceStatement_top (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (d : (Fin M → Fin 4) → ℂ)
    (hd : ∑ p, d p • kroneckerFamily b p = 0) : IndependenceStatement b d M := by
  intro U V τ
  calc ∑ p, d p * (prefixEntryProduct b p U V M * suffixLetterIndicator p τ M)
      = ∑ p, d p * (prefixEntryProduct b p U V M * 1) :=
        Finset.sum_congr rfl fun p _ => by
          rw [suffixLetterIndicator_of_le _ _ _ le_rfl]                -- `χ^{(M)}_q` の定義を各 `q` へ
    _ = ∑ p, d p * prefixEntryProduct b p U V M :=
        Finset.sum_congr rfl fun p _ => by rw [mul_one]                -- 積の単位元を各 `q` へ
    _ = ∑ p, d p * ∏ k : Fin M, b (p k) (U k) (V k) :=
        Finset.sum_congr rfl fun p _ => by
          rw [prefixEntryProduct_eq_prod b p U V M le_rfl]; rfl        -- `P^{(M)}_q` の定義を各 `q` へ
    _ = ∑ p, d p * kroneckerFamily b p U V :=
        Finset.sum_congr rfl fun p _ => by
          rw [kroneckerFamily, siteProd_apply]                         -- `def_kronecker` (2) を右辺から左辺へ、各 `q` へ
    _ = ∑ p, (d p • kroneckerFamily b p) U V :=
        Finset.sum_congr rfl fun p _ => by
          rw [Matrix.smul_apply, smul_eq_mul]                          -- `def_matrix_scalar_multiple` を右辺から左辺へ、各 `q` へ
    _ = (∑ p, d p • kroneckerFamily b p) U V :=
        (Matrix.sum_apply U V _ _).symm                                -- `finite_sum_of_matrices_entrywise` を右辺から左辺へ
    _ = (0 : TensorPow M) U V := by rw [hd]                           -- 仮定 `Σ_q d_qF_q = O`
    _ = 0 := Matrix.zero_apply U V                                     -- `def_zero_matrix`

/-- 人手 Step 2 (2b) の準備: `b_{π(q)_s} = Σ_a δ_{π(q)_s a} b_a`（δ の 2 行の鎖と 3 行の鎖）。 -/
theorem matrix_eq_sum_delta_smul (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (x : Fin 4) :
    b x = ∑ a, (if x = a then (1 : ℂ) else 0) • b a := by
  have hzero : ∀ a, a ≠ x → (if x = a then (1 : ℂ) else 0) • b a = 0 := fun a ha => by
    calc (if x = a then (1 : ℂ) else 0) • b a
        = (0 : ℂ) • b a := by rw [if_neg (Ne.symm ha)]                 -- `def_kronecker_delta`
      _ = 0 := zero_smul ℂ _                                           -- `zero_scalar_multiple_is_zero_matrix`
  calc b x
      = (1 : ℂ) • b x := (one_smul ℂ _).symm                           -- `scalar_multiple_by_one` を右辺から左辺へ
    _ = (if x = x then (1 : ℂ) else 0) • b x := by rw [if_pos rfl]     -- `def_kronecker_delta`
    _ = ∑ a, (if x = a then (1 : ℂ) else 0) • b a :=
        (Finset.sum_eq_single x (fun a _ ha => hzero a ha)
          (fun h => absurd (Finset.mem_univ x) h)).symm                -- `finite_sum_of_matrices_with_single_nonzero_term` を右辺から左辺へ

/-- 人手 Step 2 の `w_q := d_q (P^{(s-1)}_q(U',V') χ^{(s)}_q(τ'))`（人手の `s` は Lean の `s + 1`）。 -/
noncomputable def independenceStepCoeff (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (d : (Fin M → Fin 4) → ℂ)
    (U V : Conf M) (τ : Fin M → Fin 4) (s : ℕ) (p : Fin M → Fin 4) : ℂ :=
  d p * (prefixEntryProduct b p U V s * suffixLetterIndicator p τ (s + 1))

/-- 人手 Step 2 の `B := Σ_q w_q b_{π(q)_s}`。 -/
noncomputable def independenceStepMatrix (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (d : (Fin M → Fin 4) → ℂ)
    (U V : Conf M) (τ : Fin M → Fin 4) (s : ℕ) (h : s < M) : Matrix (Fin 2) (Fin 2) ℂ :=
  ∑ p, independenceStepCoeff b d U V τ s p • b (p ⟨s, h⟩)

/-- 人手 Step 2 (2a): `A(s)` から `B = O`。各成分の 11 行の鎖を `calc` の段で示し、4 成分の一致で結ぶ。 -/
theorem independenceStep_B_eq_zero (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (d : (Fin M → Fin 4) → ℂ)
    (U V : Conf M) (τ : Fin M → Fin 4) (s : ℕ) (h : s < M)
    (hA : IndependenceStatement b d (s + 1)) : independenceStepMatrix b d U V τ s h = 0 := by
  ext u v
  set j : Fin M := ⟨s, h⟩
  have hP : ∀ p, prefixEntryProduct b p (Function.update U j u) (Function.update V j v) s
      = prefixEntryProduct b p U V s := fun p =>
    prefixEntryProduct_update_of_le b p U V j u v s le_rfl
  calc independenceStepMatrix b d U V τ s h u v
      = (∑ p, independenceStepCoeff b d U V τ s p • b (p j)) u v := rfl   -- `B` の定義
    _ = ∑ p, (independenceStepCoeff b d U V τ s p • b (p j)) u v :=
        Matrix.sum_apply u v _ _                                       -- `finite_sum_of_matrices_entrywise`
    _ = ∑ p, independenceStepCoeff b d U V τ s p * b (p j) u v :=
        Finset.sum_congr rfl fun p _ => by
          rw [Matrix.smul_apply, smul_eq_mul]                          -- `def_matrix_scalar_multiple` を各 `q` へ
    _ = ∑ p, (d p * (prefixEntryProduct b p U V s * suffixLetterIndicator p τ (s + 1))) * b (p j) u v :=
        rfl                                                            -- `w_q` の定義を各 `q` へ
    _ = ∑ p, d p * ((prefixEntryProduct b p U V s * suffixLetterIndicator p τ (s + 1)) * b (p j) u v) :=
        Finset.sum_congr rfl fun p _ => by rw [mul_assoc]              -- 積の結合律を各 `q` へ
    _ = ∑ p, d p * (prefixEntryProduct b p U V s * (suffixLetterIndicator p τ (s + 1) * b (p j) u v)) :=
        Finset.sum_congr rfl fun p _ => by rw [mul_assoc]              -- 積の結合律を各 `q` へ
    _ = ∑ p, d p * (prefixEntryProduct b p U V s * (b (p j) u v * suffixLetterIndicator p τ (s + 1))) :=
        Finset.sum_congr rfl fun p _ => by rw [mul_comm (suffixLetterIndicator p τ (s + 1))]   -- 積の可換律を各 `q` へ
    _ = ∑ p, d p * ((prefixEntryProduct b p U V s * b (p j) u v) * suffixLetterIndicator p τ (s + 1)) :=
        Finset.sum_congr rfl fun p _ => by
          rw [← mul_assoc (prefixEntryProduct b p U V s)]              -- 積の結合律を右辺から左辺へ、各 `q` へ
    _ = ∑ p, d p * (prefixEntryProduct b p (Function.update U j u) (Function.update V j v) (s + 1)
          * suffixLetterIndicator p τ (s + 1)) :=
        Finset.sum_congr rfl fun p _ => by
          rw [prefixEntryProduct_succ _ _ _ _ s h, hP p,
            Function.update_self, Function.update_self]                -- (R) を右辺から左辺へ、各 `q` へ
    _ = 0 := hA _ _ τ                                                  -- `A(s)`（`U → (U',u), V → (V',v), τ → τ'`）
    _ = (0 : Matrix (Fin 2) (Fin 2) ℂ) u v := (Matrix.zero_apply u v).symm   -- `def_zero_matrix` を右辺から左辺へ

/-- 人手 Step 2 (2b): `B = Σ_a (Σ_q w_q δ_{π(q)_s a}) b_a`。6 行の鎖を `calc` の 6 段で示す。 -/
theorem independenceStep_B_eq_sum (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (d : (Fin M → Fin 4) → ℂ)
    (U V : Conf M) (τ : Fin M → Fin 4) (s : ℕ) (h : s < M) :
    independenceStepMatrix b d U V τ s h
      = ∑ a, (∑ p, independenceStepCoeff b d U V τ s p * (if p ⟨s, h⟩ = a then 1 else 0)) • b a := by
  set w := independenceStepCoeff b d U V τ s
  set j : Fin M := ⟨s, h⟩
  calc independenceStepMatrix b d U V τ s h
      = ∑ p, w p • b (p j) := rfl                                      -- `B` の定義
    _ = ∑ p, w p • ∑ a, (if p j = a then (1 : ℂ) else 0) • b a :=
        Finset.sum_congr rfl fun p _ => by
          rw [← matrix_eq_sum_delta_smul b (p j)]                      -- `b_{π(q)_s}` の表示を各 `q` へ
    _ = ∑ p, ∑ a, w p • ((if p j = a then (1 : ℂ) else 0) • b a) :=
        Finset.sum_congr rfl fun p _ => Finset.smul_sum                -- `finite_sum_of_scalar_multiples` を右辺から左辺へ、各 `q` へ
    _ = ∑ p, ∑ a, (w p * (if p j = a then (1 : ℂ) else 0)) • b a :=
        Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun a _ =>
          smul_smul _ _ _                                              -- `scalar_multiple_is_associative` を各項へ
    _ = ∑ a, ∑ p, (w p * (if p j = a then (1 : ℂ) else 0)) • b a :=
        Finset.sum_comm                                                -- `finite_double_sum_of_matrices_interchange`
    _ = ∑ a, (∑ p, w p * (if p j = a then (1 : ℂ) else 0)) • b a :=
        Finset.sum_congr rfl fun a _ => Finset.sum_smul.symm           -- `finite_sum_of_scalar_multiples_of_one_matrix` を各 `a` へ

/-- 人手 Step 2: `A(s)` が成り立てば `A(s-1)` が成り立つ（人手の `s` は Lean の `s + 1`）。
(2c) は `b_1, …, b_4` の線型独立性の仮定、(2d) は 6 行の鎖を `calc` の 6 段で示す。 -/
theorem independenceStatement_pred (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ c : Fin 4 → ℂ, ∑ a, c a • b a = 0 → ∀ a, c a = 0)
    (d : (Fin M → Fin 4) → ℂ) (s : ℕ) (h : s < M)
    (hA : IndependenceStatement b d (s + 1)) : IndependenceStatement b d s := by
  intro U V τ
  set j : Fin M := ⟨s, h⟩
  set w := independenceStepCoeff b d U V τ s
  -- (2c): (2a) と (2b) より `Σ_a (Σ_q w_q δ_{π(q)_s a}) b_a = O`、線型独立性の仮定より係数は 0
  have h2c : ∀ a, ∑ p, w p * (if p j = a then (1 : ℂ) else 0) = 0 := by
    apply hb
    rw [← independenceStep_B_eq_sum b d U V τ s h]
    exact independenceStep_B_eq_zero b d U V τ s h hA
  -- (2d): `a := τ(s)` と取れば `(a, τ') = τ`（人手の「`{1,2,3,4}^{M-s+1}` の元はどれも `(a,τ')` の形」）
  have hχ : ∀ p, suffixLetterIndicator p τ s
      = (if p j = τ j then (1 : ℂ) else 0) * suffixLetterIndicator p τ (s + 1) := fun p =>
    suffixLetterIndicator_of_lt p τ s h
  calc ∑ p, d p * (prefixEntryProduct b p U V s * suffixLetterIndicator p τ s)
      = ∑ p, d p * (prefixEntryProduct b p U V s
          * ((if p j = τ j then (1 : ℂ) else 0) * suffixLetterIndicator p τ (s + 1))) :=
        Finset.sum_congr rfl fun p _ => by rw [hχ p]                   -- `χ^{(s-1)}_q` の定義を各 `q` へ
    _ = ∑ p, d p * (prefixEntryProduct b p U V s
          * (suffixLetterIndicator p τ (s + 1) * (if p j = τ j then (1 : ℂ) else 0))) :=
        Finset.sum_congr rfl fun p _ => by
          rw [mul_comm (if p j = τ j then (1 : ℂ) else 0)]             -- 積の可換律を各 `q` へ
    _ = ∑ p, d p * ((prefixEntryProduct b p U V s * suffixLetterIndicator p τ (s + 1))
          * (if p j = τ j then (1 : ℂ) else 0)) :=
        Finset.sum_congr rfl fun p _ => by
          rw [← mul_assoc (prefixEntryProduct b p U V s)]              -- 積の結合律を右辺から左辺へ、各 `q` へ
    _ = ∑ p, (d p * (prefixEntryProduct b p U V s * suffixLetterIndicator p τ (s + 1)))
          * (if p j = τ j then (1 : ℂ) else 0) :=
        Finset.sum_congr rfl fun p _ => by rw [← mul_assoc]            -- 積の結合律を右辺から左辺へ、各 `q` へ
    _ = ∑ p, w p * (if p j = τ j then (1 : ℂ) else 0) := rfl           -- `w_q` の定義を右辺から左辺へ、各 `q` へ
    _ = 0 := h2c (τ j)                                                 -- (2c)

/-- 人手 Step 3: `A(0)`。Step 1 と Step 2 から、`s` を `M` から `0` まで下げる帰納法で示す。 -/
theorem independenceStatement_zero (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ c : Fin 4 → ℂ, ∑ a, c a • b a = 0 → ∀ a, c a = 0)
    (d : (Fin M → Fin 4) → ℂ) (hd : ∑ p, d p • kroneckerFamily b p = 0) :
    IndependenceStatement b d 0 := by
  have key : ∀ n s : ℕ, s + n = M → IndependenceStatement b d s := by
    intro n
    induction n with
    | zero => intro s hs; rw [show s = M by omega]; exact independenceStatement_top b d hd   -- Step 1
    | succ n ih =>
      intro s hs
      exact independenceStatement_pred b hb d s (by omega) (ih (s + 1) (by omega))           -- Step 2
  exact key M 0 (by omega)

/-- 人手 Step 4 の `E(s)`: `s ≤ k < M` のすべての `k`（人手の `s < k ≤ M`）で `π(q)_k = τ_k` ならば `χ^{(s)}_q(τ) = 1_ℂ`、
そうでなければ `0_ℂ`。`s` を `M` から下げる帰納法（三つの場合の鎖）で示す。 -/
theorem suffixLetterIndicator_eq (p τ : Fin M → Fin 4) :
    ∀ n s : ℕ, s + n = M →
      suffixLetterIndicator p τ s = if (∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k) then 1 else 0
  | 0, s, hn => by
    rw [if_pos (fun k hk => absurd k.isLt (by omega))]                 -- 条件は空
    exact suffixLetterIndicator_of_le p τ s (by omega)                 -- `χ^{(M)}_q` の定義
  | n + 1, s, hn => by
    have hs : s < M := by omega
    have ih := suffixLetterIndicator_eq p τ n (s + 1) (by omega)       -- 帰納法の仮定 `E(s)`
    by_cases ha : p ⟨s, hs⟩ = τ ⟨s, hs⟩
    · by_cases hrest : ∀ k : Fin M, s + 1 ≤ (k : ℕ) → p k = τ k
      · -- 場合 1: `π(q)_s = a` かつ以降の成分がすべて一致
        have hall : ∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k := fun k hk => by
          rcases Nat.eq_or_lt_of_le hk with h | h
          · have : k = ⟨s, hs⟩ := Fin.ext h.symm
            rw [this]; exact ha
          · exact hrest k h
        rw [if_pos hall]
        calc suffixLetterIndicator p τ s
            = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : ℂ) else 0) * suffixLetterIndicator p τ (s + 1) :=
              suffixLetterIndicator_of_lt p τ s hs                     -- `χ^{(s-1)}_q` の定義
          _ = 1 * suffixLetterIndicator p τ (s + 1) := by rw [if_pos ha]   -- `def_kronecker_delta` と `π(q)_s = a`
          _ = 1 * 1 := by rw [ih, if_pos hrest]                         -- 帰納法の仮定 `E(s)`
          _ = 1 := mul_one 1                                           -- 積の単位元
      · -- 場合 3: `π(q)_s = a` で、以降のある成分が一致しない
        have hnot : ¬ ∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k := fun hall =>
          hrest fun k hk => hall k (by omega)
        rw [if_neg hnot]
        calc suffixLetterIndicator p τ s
            = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : ℂ) else 0) * suffixLetterIndicator p τ (s + 1) :=
              suffixLetterIndicator_of_lt p τ s hs                     -- `χ^{(s-1)}_q` の定義
          _ = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : ℂ) else 0) * 0 := by rw [ih, if_neg hrest]   -- 帰納法の仮定 `E(s)`
          _ = 0 := mul_zero _                                          -- `complex_times_zero_is_zero`
    · -- 場合 2: `π(q)_s ≠ a`
      have hnot : ¬ ∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k := fun hall => ha (hall ⟨s, hs⟩ le_rfl)
      rw [if_neg hnot]
      calc suffixLetterIndicator p τ s
          = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : ℂ) else 0) * suffixLetterIndicator p τ (s + 1) :=
            suffixLetterIndicator_of_lt p τ s hs                       -- `χ^{(s-1)}_q` の定義
        _ = 0 * suffixLetterIndicator p τ (s + 1) := by rw [if_neg ha]   -- `def_kronecker_delta` と `π(q)_s ≠ a`
        _ = 0 := zero_mul _                                            -- `complex_zero_times_is_zero`

/-- **`<kronecker_family_of_independent_family_is_independent>` の形式化**: `b_1, …, b_4` が線型独立ならば、
`Σ_p d_p (b_{p_1} ⊠ ⋯ ⊠ b_{p_M}) = O` となる係数はすべて `0`。

人手 Step 5: `E(0)`（`τ → π(q_0)`）と `π` の単射性で `q ≠ q_0` の項が `0_ℂ` になり（3 行の鎖）、
`d_{q_0}` から `A(0)` の左辺へ 6 行の鎖でつなぐ。 -/
theorem kronecker_family_of_independent_family_is_independent (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ c : Fin 4 → ℂ, ∑ a, c a • b a = 0 → ∀ a, c a = 0)
    (d : (Fin M → Fin 4) → ℂ) (hd : ∑ p, d p • siteProd M (fun k => b (p k)) = 0) :
    ∀ p, d p = 0 := by
  intro p₀
  have hA0 := independenceStatement_zero b hb d hd
  -- 人手の `U, V → ()`: Lean の `P^{(0)}` は `U, V` を読まないので、任意に取る
  let U₀ : Conf M := fun _ => 0
  have hP0 : ∀ p, prefixEntryProduct b p U₀ U₀ 0 = 1 := fun _ => rfl
  -- `E(0)`（`τ → π(q_0)`）と `π` の単射性
  have hE : ∀ p, suffixLetterIndicator p p₀ 0 = if p = p₀ then 1 else 0 := fun p => by
    rw [suffixLetterIndicator_eq p p₀ M 0 (by omega)]
    by_cases hp : p = p₀
    · rw [if_pos hp, if_pos fun k _ => by rw [hp]]
    · rw [if_neg hp, if_neg fun hall => hp (funext fun k => hall k (Nat.zero_le _))]
  -- `q ≠ q_0` の項の 3 行の鎖
  have hzero : ∀ p, p ≠ p₀ →
      d p * (prefixEntryProduct b p U₀ U₀ 0 * suffixLetterIndicator p p₀ 0) = 0 := fun p hp => by
    calc d p * (prefixEntryProduct b p U₀ U₀ 0 * suffixLetterIndicator p p₀ 0)
        = d p * (prefixEntryProduct b p U₀ U₀ 0 * 0) := by rw [hE p, if_neg hp]   -- `E(0)` と `q ≠ q_0`
      _ = d p * 0 := by rw [mul_zero]                                  -- `complex_times_zero_is_zero`
      _ = 0 := mul_zero _                                              -- `complex_times_zero_is_zero`
  calc d p₀
      = d p₀ * 1 := (mul_one _).symm                                   -- 積の単位元を右辺から左辺へ
    _ = d p₀ * (1 * 1) := by rw [mul_one (1 : ℂ)]                      -- 積の単位元を右辺から左辺へ
    _ = d p₀ * (prefixEntryProduct b p₀ U₀ U₀ 0 * 1) := by rw [hP0]    -- `P^{(0)}_{q_0}` の定義を右辺から左辺へ
    _ = d p₀ * (prefixEntryProduct b p₀ U₀ U₀ 0 * suffixLetterIndicator p₀ p₀ 0) := by
        rw [hE p₀, if_pos rfl]                                         -- `E(0)`（`q → q_0`）を右辺から左辺へ
    _ = ∑ p, d p * (prefixEntryProduct b p U₀ U₀ 0 * suffixLetterIndicator p p₀ 0) :=
        (Finset.sum_eq_single p₀ (fun p _ hp => hzero p hp)
          (fun h => absurd (Finset.mem_univ p₀) h)).symm               -- `finite_sum_with_single_nonzero_term` を右辺から左辺へ
    _ = 0 := hA0 U₀ U₀ p₀                                              -- Step 3 の `A(0)`

end Ising2D
