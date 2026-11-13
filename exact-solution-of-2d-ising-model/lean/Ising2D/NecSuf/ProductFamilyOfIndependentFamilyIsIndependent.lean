/-
# 必要十分版: 線型独立な関数の族から作る積の族は線型独立

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル: **`<kronecker_family_of_independent_family_is_independent>`**
（`structured-latex/content/002_linear_space_general.ts`。具体版は
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerFamilyOfIndependentFamilyIsIndependent.lean` の
`Ising2D.kronecker_family_of_independent_family_is_independent`、特殊化による導出は同じフォルダの
`ClaimKroneckerFamilyOfIndependentFamilyIsIndependentFromNecSuf.lean`）。

## 読み替え

- 具体版の `b_a ∈ Mat(2, ℂ)`（`a ∈ Fin 4`）は、ここでは `b a : κ → R`（`a ∈ ι`）である。具体版の成分の対 `(u, v)` が
  `κ` の 1 つの元に当たる（導出では `κ := Fin 2 × Fin 2`）。具体版の `U, V : Conf M` の対は `W : Fin M → κ` に当たる。
- 具体版の `F_q` の成分 `Π_{k=1}^{M}(b_{π(q)_k})_{u_kv_k}` は、ここでは左から順に掛ける積 `prefixProductOf b p W M` である
  （係数が可換と限らないので、積の順序を漸化式で固定する。具体版の `P^{(s)}` と同じ漸化式）。
  `F_q` 自身は関数 `W ↦ prefixProductOf b p W M`（`productFamilyOf b p`）である。
- 線型独立性・`Σ_q d_q F_q = O` は、関数全体 `κ → R`・`(Fin M → κ) → R` の左 `R` 加群での等式で述べる。

## 具体版との手順の対応

ステップは具体版と同じ順で、同じ鎖を書く。

| 人手・具体版 | 本ファイル |
| --- | --- |
| 準備 (a) `P^{(s)}_q`（`prefixEntryProduct`）と (R)（`prefixEntryProduct_succ`） | `prefixProductOf`・`prefixProductOf_succ` |
| 準備 (a) の「`P^{(s)}` は `U, V` の前の `s` 成分だけを読む」（`prefixEntryProduct_update_of_le`） | `prefixProductOf_update_of_le` |
| 準備 (b) `χ^{(s)}_q`（`suffixLetterIndicator`） | `suffixIndicatorOf`・`suffixIndicatorOf_of_le`・`suffixIndicatorOf_of_lt` |
| 準備 (c) `A(s)`（`IndependenceStatement`） | `IndependenceStatementOf` |
| Step 1（`A(M)`、8 行の鎖。`independenceStatement_top`） | `independenceStatementOf_top`（同じ鎖。「`P^{(M)}_q` の定義」の段は `F_q` の定義そのものなので 1 段減る） |
| Step 2 の `b_{π(q)_s} = Σ_a δ_{π(q)_s a} b_a`（`matrix_eq_sum_delta_smul`） | `eq_sum_delta_smul` |
| Step 2 (2a)（11 行の鎖。`independenceStep_B_eq_zero`） | `independenceStepOf_B_eq_zero`（同じ段。「積の可換律」の段は `suffixIndicatorOf_commute`） |
| Step 2 (2b)（6 行の鎖。`independenceStep_B_eq_sum`） | `independenceStepOf_B_eq_sum`（同じ 6 段） |
| Step 2 (2c)(2d)（6 行の鎖。`independenceStatement_pred`） | `independenceStatementOf_pred`（同じ段。「積の可換律」の段は `delta_commute`） |
| Step 3（下げる帰納法。`independenceStatement_zero`） | `independenceStatementOf_zero` |
| Step 4 `E(s)`（三つの場合の鎖。`suffixLetterIndicator_eq`） | `suffixIndicatorOf_eq`（同じ三つの場合） |
| Step 5（`kronecker_family_of_independent_family_is_independent`） | `productFamilyOf_independent`（同じ 3 行と 6 行の鎖） |

## 効いているもの（一次情報: 下の証明が使っている補題がすべて）

* 係数の加法の結合則・交換則と零（有限和 `Finset.sum`、`Finset.sum_comm`、`Finset.sum_eq_single`）。
* 係数の乗法の結合則（(2a)(2d) の組み替えの段の `mul_assoc`）、単位元（`mul_one`）、零との積（`mul_zero`・`zero_mul`）。
* 左 `R` 加群としてのスカラー倍の性質（`Finset.smul_sum`・`smul_smul`・`Finset.sum_smul`・`one_smul`・`zero_smul`）。
  関数全体の加群の和・スカラー倍・零が成分ごとであること（`Finset.sum_apply`・`Pi.smul_apply`・`Pi.zero_apply`）。
* `b` の線型独立性（仮定 `hb`）。
* `ι` の等号が判定できること（`DecidableEq ι`）: `δ_{π(q)_s a}`（`if p s = a then 1 else 0`）と、それを掛ける
  `χ^{(s)}_q`（`suffixIndicatorOf`）を定義するのに要る。Step 5 の `q = q_0` の場合分けも `Fin M → ι` の等号の判定である。

## 効いていないもの

* **係数の乗法の可換則**: 具体版の (2a)(2d) の「積の可換律」の段で入れ替えるのは、`χ^{(s)}_q` または `δ` と
  ほかの元との積だけである。`χ^{(s)}_q`・`δ` の値は `0_R` か `1_R` なので、可換則なしにどの元とも交換する
  （`delta_commute`・`suffixIndicatorOf_commute`）。積の順序は漸化式で固定し、係数 `d_q` は左から掛ける。
* **係数が体であること・負元・逆元**: 引き算も割り算も使わない。係数は任意の半環 `R` でよい。
* **行列であること**: 具体版が `b_a` から読むのは成分 `(b_a)_{uv}` だけで、行列の積も行と列の区別も使わない。
  ここでは成分の添字を任意の型 `κ` の 1 つの元に置き換えた（`κ` は有限でなくてよい）。
* **因子の種類が 4 個であること**: 添字は任意の有限型 `ι` でよい。
* **`M ≥ 1`**: `M = 0` でも同じ証明が通る（`F_q` は定数関数 `1_R` で、`q` は 1 つしかない）。

## 外せない仮定

* `hb`（`b` の線型独立性）: 外すと結論は偽になりうる。例えば `R` が `1 ≠ 0` の環で、`M = 1`、`b_1 = b_2` なら、
  係数 `d_{(1)} = 1`・`d_{(2)} = -1` で `Σ_q d_q F_q = O` だが `d_{(1)} ≠ 0`。
* `ι` が有限であること: 線型独立性の仮定と主張を有限和で述べるのに要る（人手の `Σ_{a=1}^{4}`、`Σ_{q=1}^{N}`）。
* `κ` の元 `x₀`: Step 5 で `A(0)` を 1 つの `W` に当てはめる段（具体版の `U₀`）に要る。この手順のままでは外せない
  （`κ` が空で `M ≥ 1` なら当てはめる `W` が無い。その場合も結論は別の論法で出るが、それは具体版と別の手順である）。
-/
import Mathlib.Algebra.Module.Pi
import Mathlib.Algebra.BigOperators.Pi
import Mathlib.Algebra.Module.BigOperators
import Mathlib.Data.Fintype.Pi

namespace Ising2D.NecSuf

open Finset

variable {R : Type*} [Semiring R]
variable {ι κ : Type*} {M : ℕ}

/-- 具体版の準備 (a) の `P^{(s)}_q(U, V)`: 左から順に掛ける積に、`P^{(0)}_q := 1_R` を添えたもの。 -/
def prefixProductOf (b : ι → κ → R) (p : Fin M → ι) (W : Fin M → κ) : ℕ → R
  | 0 => 1
  | s + 1 => prefixProductOf b p W s * (if h : s < M then b (p ⟨s, h⟩) (W ⟨s, h⟩) else 1)

/-- 具体版の (R)（`prefixEntryProduct_succ`）。 -/
theorem prefixProductOf_succ (b : ι → κ → R) (p : Fin M → ι) (W : Fin M → κ) (s : ℕ) (h : s < M) :
    prefixProductOf b p W (s + 1) = prefixProductOf b p W s * b (p ⟨s, h⟩) (W ⟨s, h⟩) := by
  rw [prefixProductOf, dif_pos h]

/-- `P^{(s)}` は `W` の第 `0, …, s-1` 成分だけを読む（具体版の `prefixEntryProduct_update_of_le`）。 -/
theorem prefixProductOf_update_of_le (b : ι → κ → R) (p : Fin M → ι)
    (W : Fin M → κ) (j : Fin M) (x : κ) :
    ∀ s : ℕ, s ≤ (j : ℕ) → prefixProductOf b p (Function.update W j x) s = prefixProductOf b p W s
  | 0, _ => rfl
  | s + 1, hs => by
    have hsj : s < M := by omega
    have hne : (⟨s, hsj⟩ : Fin M) ≠ j := fun h => by rw [← h] at hs; simp at hs
    rw [prefixProductOf_succ _ _ _ s hsj, prefixProductOf_succ _ _ _ s hsj,
      Function.update_of_ne hne, prefixProductOf_update_of_le b p W j x s (by omega)]

/-- 具体版の `F_q`: 関数 `W ↦ P^{(M)}_q(W)`。 -/
def productFamilyOf (b : ι → κ → R) (p : Fin M → ι) : (Fin M → κ) → R :=
  fun W => prefixProductOf b p W M

variable [DecidableEq ι]

/-- 具体版の準備 (b) の `χ^{(s)}_q(τ)`（`suffixLetterIndicator`）。値は `R` の `0`・`1` の積。 -/
def suffixIndicatorOf (p τ : Fin M → ι) (s : ℕ) : R :=
  if h : s < M then (if p ⟨s, h⟩ = τ ⟨s, h⟩ then 1 else 0) * suffixIndicatorOf p τ (s + 1)
  else 1
termination_by M - s

theorem suffixIndicatorOf_of_le (p τ : Fin M → ι) (s : ℕ) (h : M ≤ s) :
    suffixIndicatorOf (R := R) p τ s = 1 := by
  rw [suffixIndicatorOf, dif_neg (by omega)]

theorem suffixIndicatorOf_of_lt (p τ : Fin M → ι) (s : ℕ) (h : s < M) :
    suffixIndicatorOf (R := R) p τ s
      = (if p ⟨s, h⟩ = τ ⟨s, h⟩ then 1 else 0) * suffixIndicatorOf p τ (s + 1) := by
  rw [suffixIndicatorOf, dif_pos h]

/-- `δ` の値は `0_R` か `1_R` なので、可換則なしにどの元とも交換する（具体版の「積の可換律」の段の代わり）。 -/
theorem delta_commute (P : Prop) [Decidable P] (x : R) : Commute (if P then (1 : R) else 0) x := by
  by_cases hP : P
  · rw [if_pos hP]; exact Commute.one_left x
  · rw [if_neg hP]; exact Commute.zero_left x

/-- `χ^{(s)}_q` は `δ` の積なので、どの元とも交換する（具体版の「積の可換律」の段の代わり）。 -/
theorem suffixIndicatorOf_commute (p τ : Fin M → ι) (x : R) :
    ∀ n s : ℕ, s + n = M → Commute (suffixIndicatorOf p τ s) x
  | 0, s, hn => by rw [suffixIndicatorOf_of_le p τ s (by omega)]; exact Commute.one_left x
  | n + 1, s, hn => by
    rw [suffixIndicatorOf_of_lt p τ s (by omega)]
    exact (delta_commute _ x).mul_left (suffixIndicatorOf_commute p τ x n (s + 1) (by omega))

variable [Fintype ι]

/-- 具体版の準備 (c) の `A(s)`。 -/
def IndependenceStatementOf (b : ι → κ → R) (d : (Fin M → ι) → R) (s : ℕ) : Prop :=
  ∀ (W : Fin M → κ) (τ : Fin M → ι),
    ∑ p, d p * (prefixProductOf b p W s * suffixIndicatorOf p τ s) = 0

/-- 具体版 Step 1: `A(M)`（具体版の 8 行の鎖。「`P^{(M)}_q` の定義」の段は `F_q` の定義そのもの）。 -/
theorem independenceStatementOf_top (b : ι → κ → R) (d : (Fin M → ι) → R)
    (hd : ∑ p, d p • productFamilyOf b p = 0) : IndependenceStatementOf b d M := by
  intro W τ
  calc ∑ p, d p * (prefixProductOf b p W M * suffixIndicatorOf p τ M)
      = ∑ p, d p * (prefixProductOf b p W M * 1) :=
        Finset.sum_congr rfl fun p _ => by
          rw [suffixIndicatorOf_of_le _ _ _ le_rfl]                    -- `χ^{(M)}_q` の定義を各 `q` へ
    _ = ∑ p, d p * prefixProductOf b p W M :=
        Finset.sum_congr rfl fun p _ => by rw [mul_one]                -- 積の単位元を各 `q` へ
    _ = ∑ p, d p * productFamilyOf b p W := rfl                        -- `F_q` の定義を右辺から左辺へ、各 `q` へ
    _ = ∑ p, (d p • productFamilyOf b p) W :=
        Finset.sum_congr rfl fun p _ => by
          rw [Pi.smul_apply, smul_eq_mul]                              -- スカラー倍は成分ごと、各 `q` へ
    _ = (∑ p, d p • productFamilyOf b p) W :=
        (Finset.sum_apply W _ _).symm                                  -- 有限和は成分ごと（右辺から左辺へ）
    _ = (0 : (Fin M → κ) → R) W := by rw [hd]                         -- 仮定 `Σ_q d_qF_q = O`
    _ = 0 := Pi.zero_apply W                                           -- 零は成分ごと

/-- 具体版 Step 2 (2b) の準備（`matrix_eq_sum_delta_smul`）: `b_x = Σ_a δ_{xa} b_a`。 -/
theorem eq_sum_delta_smul (b : ι → κ → R) (x : ι) :
    b x = ∑ a, (if x = a then (1 : R) else 0) • b a := by
  have hzero : ∀ a, a ≠ x → (if x = a then (1 : R) else 0) • b a = 0 := fun a ha => by
    calc (if x = a then (1 : R) else 0) • b a
        = (0 : R) • b a := by rw [if_neg (Ne.symm ha)]                 -- `δ` の定義
      _ = 0 := zero_smul R _                                           -- 零のスカラー倍
  calc b x
      = (1 : R) • b x := (one_smul R _).symm                           -- `1` のスカラー倍（右辺から左辺へ）
    _ = (if x = x then (1 : R) else 0) • b x := by rw [if_pos rfl]     -- `δ` の定義
    _ = ∑ a, (if x = a then (1 : R) else 0) • b a :=
        (Finset.sum_eq_single x (fun a _ ha => hzero a ha)
          (fun h => absurd (Finset.mem_univ x) h)).symm                -- 一つの項だけが零でない有限和（右辺から左辺へ）

/-- 具体版 Step 2 の `w_q := d_q (P^{(s-1)}_q χ^{(s)}_q)`（具体版の `s` は Lean の `s + 1`）。 -/
def independenceStepCoeffOf (b : ι → κ → R) (d : (Fin M → ι) → R) (W : Fin M → κ) (τ : Fin M → ι)
    (s : ℕ) (p : Fin M → ι) : R :=
  d p * (prefixProductOf b p W s * suffixIndicatorOf p τ (s + 1))

/-- 具体版 Step 2 の `B := Σ_q w_q b_{π(q)_s}`。 -/
def independenceStepOf (b : ι → κ → R) (d : (Fin M → ι) → R) (W : Fin M → κ) (τ : Fin M → ι)
    (s : ℕ) (h : s < M) : κ → R :=
  ∑ p, independenceStepCoeffOf b d W τ s p • b (p ⟨s, h⟩)

/-- 具体版 Step 2 (2a): `A(s)` から `B = O`（具体版の 11 行の鎖と同じ段）。 -/
theorem independenceStepOf_B_eq_zero (b : ι → κ → R) (d : (Fin M → ι) → R)
    (W : Fin M → κ) (τ : Fin M → ι) (s : ℕ) (h : s < M)
    (hA : IndependenceStatementOf b d (s + 1)) : independenceStepOf b d W τ s h = 0 := by
  funext x
  set j : Fin M := ⟨s, h⟩
  have hP : ∀ p, prefixProductOf b p (Function.update W j x) s = prefixProductOf b p W s := fun p =>
    prefixProductOf_update_of_le b p W j x s le_rfl
  have hχ : ∀ p, Commute (suffixIndicatorOf p τ (s + 1)) (b (p j) x) := fun p =>
    suffixIndicatorOf_commute p τ _ (M - (s + 1)) (s + 1) (by omega)
  calc independenceStepOf b d W τ s h x
      = (∑ p, independenceStepCoeffOf b d W τ s p • b (p j)) x := rfl  -- `B` の定義
    _ = ∑ p, (independenceStepCoeffOf b d W τ s p • b (p j)) x :=
        Finset.sum_apply x _ _                                         -- 有限和は成分ごと
    _ = ∑ p, independenceStepCoeffOf b d W τ s p * b (p j) x :=
        Finset.sum_congr rfl fun p _ => by
          rw [Pi.smul_apply, smul_eq_mul]                              -- スカラー倍は成分ごと、各 `q` へ
    _ = ∑ p, (d p * (prefixProductOf b p W s * suffixIndicatorOf p τ (s + 1))) * b (p j) x :=
        rfl                                                            -- `w_q` の定義を各 `q` へ
    _ = ∑ p, d p * ((prefixProductOf b p W s * suffixIndicatorOf p τ (s + 1)) * b (p j) x) :=
        Finset.sum_congr rfl fun p _ => by rw [mul_assoc]              -- 積の結合律を各 `q` へ
    _ = ∑ p, d p * (prefixProductOf b p W s * (suffixIndicatorOf p τ (s + 1) * b (p j) x)) :=
        Finset.sum_congr rfl fun p _ => by rw [mul_assoc]              -- 積の結合律を各 `q` へ
    _ = ∑ p, d p * (prefixProductOf b p W s * (b (p j) x * suffixIndicatorOf p τ (s + 1))) :=
        Finset.sum_congr rfl fun p _ => by rw [(hχ p).eq]              -- `χ^{(s)}_q` はどの元とも交換する、各 `q` へ
    _ = ∑ p, d p * ((prefixProductOf b p W s * b (p j) x) * suffixIndicatorOf p τ (s + 1)) :=
        Finset.sum_congr rfl fun p _ => by
          rw [← mul_assoc (prefixProductOf b p W s)]                   -- 積の結合律を右辺から左辺へ、各 `q` へ
    _ = ∑ p, d p * (prefixProductOf b p (Function.update W j x) (s + 1)
          * suffixIndicatorOf p τ (s + 1)) :=
        Finset.sum_congr rfl fun p _ => by
          rw [prefixProductOf_succ _ _ _ s h, hP p, Function.update_self]   -- (R) を右辺から左辺へ、各 `q` へ
    _ = 0 := hA _ τ                                                    -- `A(s)`（`W → (W',x)`）
    _ = (0 : κ → R) x := rfl                                           -- 零は成分ごと（右辺から左辺へ）

/-- 具体版 Step 2 (2b): `B = Σ_a (Σ_q w_q δ_{π(q)_s a}) b_a`（具体版の 6 行の鎖と同じ段）。 -/
theorem independenceStepOf_B_eq_sum (b : ι → κ → R) (d : (Fin M → ι) → R)
    (W : Fin M → κ) (τ : Fin M → ι) (s : ℕ) (h : s < M) :
    independenceStepOf b d W τ s h
      = ∑ a, (∑ p, independenceStepCoeffOf b d W τ s p * (if p ⟨s, h⟩ = a then 1 else 0)) • b a := by
  set w := independenceStepCoeffOf b d W τ s
  set j : Fin M := ⟨s, h⟩
  calc independenceStepOf b d W τ s h
      = ∑ p, w p • b (p j) := rfl                                      -- `B` の定義
    _ = ∑ p, w p • ∑ a, (if p j = a then (1 : R) else 0) • b a :=
        Finset.sum_congr rfl fun p _ => by
          rw [← eq_sum_delta_smul b (p j)]                             -- `b_{π(q)_s}` の表示を各 `q` へ
    _ = ∑ p, ∑ a, w p • ((if p j = a then (1 : R) else 0) • b a) :=
        Finset.sum_congr rfl fun p _ => Finset.smul_sum                -- スカラー倍は有限和に分配する、各 `q` へ
    _ = ∑ p, ∑ a, (w p * (if p j = a then (1 : R) else 0)) • b a :=
        Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun a _ =>
          smul_smul _ _ _                                              -- スカラー倍の結合律を各項へ
    _ = ∑ a, ∑ p, (w p * (if p j = a then (1 : R) else 0)) • b a :=
        Finset.sum_comm                                                -- 有限和の入れ替え
    _ = ∑ a, (∑ p, w p * (if p j = a then (1 : R) else 0)) • b a :=
        Finset.sum_congr rfl fun a _ => Finset.sum_smul.symm           -- 係数の和のスカラー倍（右辺から左辺へ）、各 `a` へ

/-- 具体版 Step 2: `A(s)` が成り立てば `A(s-1)` が成り立つ（(2c) は線型独立性、(2d) は具体版の 6 行の鎖と同じ段）。 -/
theorem independenceStatementOf_pred (b : ι → κ → R)
    (hb : ∀ c : ι → R, ∑ a, c a • b a = 0 → ∀ a, c a = 0)
    (d : (Fin M → ι) → R) (s : ℕ) (h : s < M)
    (hA : IndependenceStatementOf b d (s + 1)) : IndependenceStatementOf b d s := by
  intro W τ
  set j : Fin M := ⟨s, h⟩
  set w := independenceStepCoeffOf b d W τ s
  -- (2c): (2a) と (2b) より `Σ_a (Σ_q w_q δ_{π(q)_s a}) b_a = O`、線型独立性の仮定より係数は 0
  have h2c : ∀ a, ∑ p, w p * (if p j = a then (1 : R) else 0) = 0 := by
    apply hb
    rw [← independenceStepOf_B_eq_sum b d W τ s h]
    exact independenceStepOf_B_eq_zero b d W τ s h hA
  have hχ : ∀ p, suffixIndicatorOf p τ s
      = (if p j = τ j then (1 : R) else 0) * suffixIndicatorOf p τ (s + 1) := fun p =>
    suffixIndicatorOf_of_lt p τ s h
  calc ∑ p, d p * (prefixProductOf b p W s * suffixIndicatorOf p τ s)
      = ∑ p, d p * (prefixProductOf b p W s
          * ((if p j = τ j then (1 : R) else 0) * suffixIndicatorOf p τ (s + 1))) :=
        Finset.sum_congr rfl fun p _ => by rw [hχ p]                   -- `χ^{(s-1)}_q` の定義を各 `q` へ
    _ = ∑ p, d p * (prefixProductOf b p W s
          * (suffixIndicatorOf p τ (s + 1) * (if p j = τ j then (1 : R) else 0))) :=
        Finset.sum_congr rfl fun p _ => by
          rw [(delta_commute (p j = τ j) (suffixIndicatorOf p τ (s + 1))).eq]   -- `δ` はどの元とも交換する、各 `q` へ
    _ = ∑ p, d p * ((prefixProductOf b p W s * suffixIndicatorOf p τ (s + 1))
          * (if p j = τ j then (1 : R) else 0)) :=
        Finset.sum_congr rfl fun p _ => by
          rw [← mul_assoc (prefixProductOf b p W s)]                   -- 積の結合律を右辺から左辺へ、各 `q` へ
    _ = ∑ p, (d p * (prefixProductOf b p W s * suffixIndicatorOf p τ (s + 1)))
          * (if p j = τ j then (1 : R) else 0) :=
        Finset.sum_congr rfl fun p _ => by rw [← mul_assoc]            -- 積の結合律を右辺から左辺へ、各 `q` へ
    _ = ∑ p, w p * (if p j = τ j then (1 : R) else 0) := rfl           -- `w_q` の定義を右辺から左辺へ、各 `q` へ
    _ = 0 := h2c (τ j)                                                 -- (2c)

/-- 具体版 Step 3: `A(0)`。Step 1 と Step 2 から、`s` を `M` から `0` まで下げる帰納法で示す。 -/
theorem independenceStatementOf_zero (b : ι → κ → R)
    (hb : ∀ c : ι → R, ∑ a, c a • b a = 0 → ∀ a, c a = 0)
    (d : (Fin M → ι) → R) (hd : ∑ p, d p • productFamilyOf b p = 0) :
    IndependenceStatementOf b d 0 := by
  have key : ∀ n s : ℕ, s + n = M → IndependenceStatementOf b d s := by
    intro n
    induction n with
    | zero => intro s hs; rw [show s = M by omega]; exact independenceStatementOf_top b d hd   -- Step 1
    | succ n ih =>
      intro s hs
      exact independenceStatementOf_pred b hb d s (by omega) (ih (s + 1) (by omega))         -- Step 2
  exact key M 0 (by omega)

omit [Fintype ι] in
/-- 具体版 Step 4 の `E(s)`: `s ≤ k < M` のすべての `k` で `π(q)_k = τ_k` ならば `χ^{(s)}_q(τ) = 1_R`、
そうでなければ `0_R`（具体版と同じ三つの場合）。 -/
theorem suffixIndicatorOf_eq (p τ : Fin M → ι) :
    ∀ n s : ℕ, s + n = M →
      suffixIndicatorOf (R := R) p τ s = if (∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k) then 1 else 0
  | 0, s, hn => by
    rw [if_pos (fun k hk => absurd k.isLt (by omega))]                 -- 条件は空
    exact suffixIndicatorOf_of_le p τ s (by omega)                     -- `χ^{(M)}_q` の定義
  | n + 1, s, hn => by
    have hs : s < M := by omega
    have ih : suffixIndicatorOf (R := R) p τ (s + 1)
        = if (∀ k : Fin M, s + 1 ≤ (k : ℕ) → p k = τ k) then 1 else 0 :=
      suffixIndicatorOf_eq p τ n (s + 1) (by omega)                    -- 帰納法の仮定 `E(s)`
    by_cases ha : p ⟨s, hs⟩ = τ ⟨s, hs⟩
    · by_cases hrest : ∀ k : Fin M, s + 1 ≤ (k : ℕ) → p k = τ k
      · -- 場合 1: `π(q)_s = a` かつ以降の成分がすべて一致
        have hall : ∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k := fun k hk => by
          rcases Nat.eq_or_lt_of_le hk with h | h
          · have : k = ⟨s, hs⟩ := Fin.ext h.symm
            rw [this]; exact ha
          · exact hrest k h
        rw [if_pos hall]
        calc suffixIndicatorOf (R := R) p τ s
            = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : R) else 0) * suffixIndicatorOf p τ (s + 1) :=
              suffixIndicatorOf_of_lt p τ s hs                         -- `χ^{(s-1)}_q` の定義
          _ = 1 * suffixIndicatorOf p τ (s + 1) := by rw [if_pos ha]   -- `δ` の定義と `π(q)_s = a`
          _ = 1 * 1 := by rw [ih, if_pos hrest]                         -- 帰納法の仮定 `E(s)`
          _ = 1 := mul_one 1                                           -- 積の単位元
      · -- 場合 3: `π(q)_s = a` で、以降のある成分が一致しない
        have hnot : ¬ ∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k := fun hall =>
          hrest fun k hk => hall k (by omega)
        rw [if_neg hnot]
        calc suffixIndicatorOf (R := R) p τ s
            = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : R) else 0) * suffixIndicatorOf p τ (s + 1) :=
              suffixIndicatorOf_of_lt p τ s hs                         -- `χ^{(s-1)}_q` の定義
          _ = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : R) else 0) * 0 := by rw [ih, if_neg hrest]   -- 帰納法の仮定 `E(s)`
          _ = 0 := mul_zero _                                          -- 零との積
    · -- 場合 2: `π(q)_s ≠ a`
      have hnot : ¬ ∀ k : Fin M, s ≤ (k : ℕ) → p k = τ k := fun hall => ha (hall ⟨s, hs⟩ le_rfl)
      rw [if_neg hnot]
      calc suffixIndicatorOf (R := R) p τ s
          = (if p ⟨s, hs⟩ = τ ⟨s, hs⟩ then (1 : R) else 0) * suffixIndicatorOf p τ (s + 1) :=
            suffixIndicatorOf_of_lt p τ s hs                           -- `χ^{(s-1)}_q` の定義
        _ = 0 * suffixIndicatorOf p τ (s + 1) := by rw [if_neg ha]     -- `δ` の定義と `π(q)_s ≠ a`
        _ = 0 := zero_mul _                                            -- 零との積

/-- **`<kronecker_family_of_independent_family_is_independent>` の必要十分版**: `b : ι → (κ → R)` が線型独立ならば、
`Σ_p d_p F_p = O` となる係数はすべて `0_R`（`F_p(W) = b_{p_1}(W_1)⋯b_{p_M}(W_M)`、左から掛ける）。

具体版 Step 5: `E(0)`（`τ → π(q_0)`）と `π` の単射性で `q ≠ q_0` の項が `0_R` になり（3 行の鎖）、
`d_{q_0}` から `A(0)` の左辺へ 6 行の鎖でつなぐ。`P^{(0)}` は `W` を読まないので、`W` には `κ` の任意の元 `x₀` を並べる
（具体版の `U₀ := (0, …, 0)`）。`A(0)` を 1 つの `W` に当てはめるこの段のために、`κ` の元 `x₀` を 1 つ仮定に取る。 -/
theorem productFamilyOf_independent (b : ι → κ → R)
    (hb : ∀ c : ι → R, ∑ a, c a • b a = 0 → ∀ a, c a = 0) (x₀ : κ)
    (d : (Fin M → ι) → R) (hd : ∑ p, d p • productFamilyOf b p = 0) :
    ∀ p, d p = 0 := by
  intro p₀
  have hA0 := independenceStatementOf_zero b hb d hd
  let W₀ : Fin M → κ := fun _ => x₀
  have hP0 : ∀ p, prefixProductOf b p W₀ 0 = 1 := fun _ => rfl
  have hE : ∀ p, suffixIndicatorOf (R := R) p p₀ 0 = if p = p₀ then 1 else 0 := fun p => by
    rw [suffixIndicatorOf_eq p p₀ M 0 (by omega)]
    by_cases hp : p = p₀
    · rw [if_pos hp, if_pos fun k _ => by rw [hp]]
    · rw [if_neg hp, if_neg fun hall => hp (funext fun k => hall k (Nat.zero_le _))]
  have hzero : ∀ p, p ≠ p₀ →
      d p * (prefixProductOf b p W₀ 0 * suffixIndicatorOf p p₀ 0) = 0 := fun p hp => by
    calc d p * (prefixProductOf b p W₀ 0 * suffixIndicatorOf p p₀ 0)
        = d p * (prefixProductOf b p W₀ 0 * 0) := by rw [hE p, if_neg hp]   -- `E(0)` と `q ≠ q_0`
      _ = d p * 0 := by rw [mul_zero]                                  -- 零との積
      _ = 0 := mul_zero _                                              -- 零との積
  calc d p₀
      = d p₀ * 1 := (mul_one _).symm                                   -- 積の単位元を右辺から左辺へ
    _ = d p₀ * (1 * 1) := by rw [mul_one (1 : R)]                      -- 積の単位元を右辺から左辺へ
    _ = d p₀ * (prefixProductOf b p₀ W₀ 0 * 1) := by rw [hP0]          -- `P^{(0)}_{q_0}` の定義を右辺から左辺へ
    _ = d p₀ * (prefixProductOf b p₀ W₀ 0 * suffixIndicatorOf p₀ p₀ 0) := by
        rw [hE p₀, if_pos rfl]                                         -- `E(0)`（`q → q_0`）を右辺から左辺へ
    _ = ∑ p, d p * (prefixProductOf b p W₀ 0 * suffixIndicatorOf p p₀ 0) :=
        (Finset.sum_eq_single p₀ (fun p _ hp => hzero p hp)
          (fun h => absurd (Finset.mem_univ p₀) h)).symm               -- 一つの項だけが零でない有限和（右辺から左辺へ）
    _ = 0 := hA0 W₀ p₀                                                 -- Step 3 の `A(0)`

end Ising2D.NecSuf
