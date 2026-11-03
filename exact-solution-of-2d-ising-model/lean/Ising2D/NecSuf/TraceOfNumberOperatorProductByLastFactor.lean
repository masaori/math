/-
# 数演算子とその補の積のトレース（最後の因子を分ける帰納法）（**必要十分版**）

対応する人手証明のラベル: `trace_of_check_number_operator_product`
（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts` の `evenEigen_004_claim_trace_of_check_number_operator_product`）。

**具体版**: `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/ClaimTraceCheckNumberOperatorProduct.lean` の `CheckFermiSetup.trace_projFactor_finProdLeft`。
具体版をこの特殊化として導くのは `ClaimTraceCheckNumberOperatorProductFromNecSuf.lean`。

## 具体版との対応（証明手順は同じ）

| 具体版（人手の鎖） | 必要十分版 |
| --- | --- |
| 基底段階 `trace_identity_base_case`（`tr(I) = 2^{M_col}`） | 仮定 `hτ1 : τ 1 = 2^{|ι|}` |
| 準備 2 の単位行列との積 `ann_mul_identity_prep2`（2 行） | `mul_one_eq_one_mul`（同じ 2 行） |
| 準備 2 の `e_j` ごとの鎖 `ann_mul_projFactor_prep2`（各 3 行） | `ann_mul_projFactor`（同じ並び） |
| 準備 3 `trace_mul_one_sub_nOp_prep3`（10 行） | `tau_mul_one_sub_num`（同じ 10 行） |
| `tr(Pň_{μ_k})` の 8 行 `trace_mul_nOp_chain` | `tau_mul_num_chain`（同じ 8 行） |
| 移項の 2 行 `trace_mul_nOp_eq_half` | `tau_mul_num_eq_half` |
| 二場合 `trace_mul_projFactor_eq_half` | `tau_mul_projFactor_eq_half` |
| 主張 `trace_projFactor_finProdLeft`（2 つの節） | `tau_finProdLeft_projFactor`（同じ 2 つの節） |

## 何が効いているか / 効いていないか

* 積の側 `A` は環（`Ring A`）で、`K` 加群（`Module K A`）であること。準備 3 は差の書き換え・分配・単位元・符号の外出し（環）と、
  `1 • x = x`・`-x = (-1) • x`（加群）を使って線型性 `hlin` の形へ運ぶ。行列であることも、成分が複素数であることも効いていない。
* `τ` について効いているのは、線型性 `hlin : τ(α • x + β • y) = α τ(x) + β τ(y)`（人手 `trace_basic_properties` (1)）と、
  巡回性 `hcyc : τ(xy) = τ(yx)`（(2)）と、`τ(1) = 2^{|ι|}`（基底段階）だけである。
* 演算子の側で効いているのは、`a_i c_i = 1 - n_i`（`hac`。人手 `check_number_operator_idempotent` (2)）と、
  `i ≠ j` で `a_i n_j = n_j a_i`（`hcomm`。`check_number_operators_commute` (1) の第 2 式）だけである。
  `c_i` と `n_j` の可換性（(1) の第 1 式）も、`ň` どうしの可換性（(2)）も使わない（最後の因子を分けたので、`P` の右に `a_k` を通すだけで済む）。
  反交換関係そのもの（`c_i a_i + a_i c_i = 1`）も、`hac` の形でしか使わない。
* 係数 `K` は環（`Ring K`）で、`half * 2 = 1` を満たす元 `half`（人手の `1/2`）があればよい。体であることも、積の可換性も使わない。
  `half` は移項の段（`τ(Pn) = τ(P) - τ(Pn)` から `τ(Pn)` を決める段）と最後の `half (2^m 2) = 2^m` に要る。下の `example` は、
  `K = ZMod 2` では `x = t - x` を満たす `x` が `t = 0` で 2 つあり、この段が `τ(Pn)` を決めないことを確かめる（主張そのものの反例ではない）。
* `hcomm` は準備 2 の `e_j` ごとの鎖の 2 行目（`ann_mul_projFactor`）が引く。最後の因子 `a_k` を前の因子の積 `P` の右へ通すのに使い、
  これが無いと `τ(Pn_k)` の 8 行の 5 行目が書けない。`μ` の単射性は、`hcomm` の前提 `i ≠ j` を前の因子ごとに満たすために要る
  （SageMath の check_47 の否定コントロールは、単射性を外した列（`μ_k = μ_j`）で準備 2 も値も外れることを確かめる）。
-/
import Mathlib.Algebra.Module.Defs
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination
import Mathlib.Data.ZMod.Basic
import Ising2D.NecSuf.NumberOperator
import Ising2D.NecSuf.JointEigenspace
import Ising2D.NecSuf.FiniteProductLeft
import Ising2D.NecSuf.FiniteProductCommute

namespace Ising2D.NecSuf

section TraceByLastFactor

variable {A : Type*} [Ring A] {K : Type*} [Ring K] [Module K A]
variable {ι : Type*} [DecidableEq ι]

omit [DecidableEq ι] in
/-- 準備 2 の単位元との積（2 行）: `a 1 = a = 1 a`。 -/
theorem mul_one_eq_one_mul (x : A) : x * 1 = 1 * x :=
  calc x * 1
      = x := mul_one x                                       -- 単位元（右）
    _ = 1 * x := (one_mul x).symm                            -- 単位元（左）を右辺から左辺へ

/-- 準備 2 の `e_j` ごとの鎖（各 3 行）: `j ≠ k` なら `a_k R_j = R_j a_k`。 -/
theorem ann_mul_projFactor (c a : ι → A) (hcomm : ∀ i j, i ≠ j → a i * num c a j = num c a j * a i)
    (T : Finset ι) {k j : ι} (h : k ≠ j) :
    a k * projFactor (num c a) T j = projFactor (num c a) T j * a k := by
  by_cases hj : j ∈ T
  · calc a k * projFactor (num c a) T j
        = a k * num c a j := by rw [projFactor_of_mem hj]          -- `R_j^{(1)}` の定義
      _ = num c a j * a k := hcomm k j h                            -- `hcomm`
      _ = projFactor (num c a) T j * a k := by rw [projFactor_of_mem hj]
  · calc a k * projFactor (num c a) T j
        = a k * (1 - num c a j) := by rw [projFactor_of_notMem hj]  -- `R_j^{(0)}` の定義
      _ = (1 - num c a j) * a k := by
          rw [mul_sub, sub_mul, mul_one_eq_one_mul (a k), hcomm k j h]
                                                                    -- 差との可換（具体版の `commuting_with_difference`。
                                                                    -- その必要十分版は行列の環についてしか無いので、同じ鎖を環 `A` で開いて書く）。
                                                                    -- 前提は上の単位元との積と `hcomm`
      _ = projFactor (num c a) T j * a k := by rw [projFactor_of_notMem hj]

omit [DecidableEq ι] in
/-- 準備 3（10 行）: `τ(P(1 - n)) = τ(P) - τ(Pn)`。 -/
theorem tau_mul_one_sub_num (τ : A → K) (hlin : ∀ (α β : K) (x y : A), τ (α • x + β • y) = α * τ x + β * τ y)
    (P n : A) : τ (P * (1 - n)) = τ P - τ (P * n) :=
  calc τ (P * (1 - n))
      = τ (P * (1 + (-n))) := by rw [sub_eq_add_neg]                -- 差の書き換え
    _ = τ (P * 1 + P * (-n)) := by rw [mul_add]                      -- 分配
    _ = τ (P + P * (-n)) := by rw [mul_one]                          -- 単位元（右）
    _ = τ (P + (-(P * n))) := by rw [mul_neg]                        -- 符号の外出し
    _ = τ ((1 : K) • P + (-(P * n))) := by rw [one_smul]             -- `1 • x = x` を右辺から左辺へ
    _ = τ ((1 : K) • P + (-1 : K) • (P * n)) := by rw [neg_one_smul] -- `-x = (-1) • x`
    _ = 1 * τ P + (-1) * τ (P * n) := hlin _ _ _ _                   -- 線型性
    _ = τ P + (-1) * τ (P * n) := by rw [one_mul]                    -- `1` は積の単位元
    _ = τ P + (-(τ (P * n))) := by rw [neg_one_mul]                  -- `-1` 倍を右辺から左辺へ
    _ = τ P - τ (P * n) := (sub_eq_add_neg _ _).symm                 -- 差の定義を右辺から左辺へ

omit [DecidableEq ι] in
/-- `τ(Pn_k)` の 8 行: `τ(Pn_k) = τ(P) - τ(Pn_k)`。前提 `hP` は準備 2。 -/
theorem tau_mul_num_chain (τ : A → K) (hlin : ∀ (α β : K) (x y : A), τ (α • x + β • y) = α * τ x + β * τ y)
    (hcyc : ∀ x y : A, τ (x * y) = τ (y * x)) (c a : ι → A) (hac : ∀ i, a i * c i = 1 - num c a i)
    (P : A) (k : ι) (hP : a k * P = P * a k) :
    τ (P * num c a k) = τ P - τ (P * num c a k) :=
  calc τ (P * num c a k)
      = τ (P * (c k * a k)) := by rw [num_def]                      -- 数演算子の定義
    _ = τ ((P * c k) * a k) := by rw [mul_assoc]                     -- 結合律を右辺から左辺へ
    _ = τ (a k * (P * c k)) := hcyc _ _                               -- 巡回性
    _ = τ ((a k * P) * c k) := by rw [mul_assoc]                     -- 結合律を右辺から左辺へ
    _ = τ ((P * a k) * c k) := by rw [hP]                            -- 準備 2
    _ = τ (P * (a k * c k)) := by rw [mul_assoc]                     -- 結合律
    _ = τ (P * (1 - num c a k)) := by rw [hac]                       -- `hac`
    _ = τ P - τ (P * num c a k) := tau_mul_one_sub_num τ hlin P _    -- 準備 3

omit [DecidableEq ι] in
/-- 移項の 2 行: `2 τ(Pn_k) = τ(P)`、`τ(Pn_k) = half · τ(P)`。 -/
theorem tau_mul_num_eq_half (τ : A → K) (hlin : ∀ (α β : K) (x y : A), τ (α • x + β • y) = α * τ x + β * τ y)
    (hcyc : ∀ x y : A, τ (x * y) = τ (y * x)) (half : K) (hhalf : half * 2 = 1) (c a : ι → A) (hac : ∀ i, a i * c i = 1 - num c a i)
    (P : A) (k : ι) (hP : a k * P = P * a k) :
    τ (P * num c a k) = half * τ P := by
  have h := tau_mul_num_chain τ hlin hcyc c a hac P k hP
  have h2 : 2 * τ (P * num c a k) = τ P := by
    rw [two_mul]; exact (eq_sub_iff_add_eq.mp h)                     -- 移項
  calc τ (P * num c a k)
      = (half * 2) * τ (P * num c a k) := by rw [hhalf, one_mul]
    _ = half * τ P := by rw [mul_assoc, h2]                          -- 両辺に `half` を掛ける

/-- 二場合: `τ(P R_k^{(e_k)}) = half · τ(P)`。 -/
theorem tau_mul_projFactor_eq_half (τ : A → K) (hlin : ∀ (α β : K) (x y : A), τ (α • x + β • y) = α * τ x + β * τ y)
    (hcyc : ∀ x y : A, τ (x * y) = τ (y * x)) (half : K) (hhalf : half * 2 = 1) (c a : ι → A) (hac : ∀ i, a i * c i = 1 - num c a i)
    (T : Finset ι) (P : A) (k : ι) (hP : a k * P = P * a k) :
    τ (P * projFactor (num c a) T k) = half * τ P := by
  by_cases hk : k ∈ T
  · calc τ (P * projFactor (num c a) T k)
        = τ (P * num c a k) := by rw [projFactor_of_mem hk]
      _ = half * τ P := tau_mul_num_eq_half τ hlin hcyc half hhalf c a hac P k hP
  · calc τ (P * projFactor (num c a) T k)
        = τ (P * (1 - num c a k)) := by rw [projFactor_of_notMem hk]
      _ = τ P - τ (P * num c a k) := tau_mul_one_sub_num τ hlin P _
      _ = τ P - half * τ P := by rw [tau_mul_num_eq_half τ hlin hcyc half hhalf c a hac P k hP]
      _ = half * τ P := by
          have hsum : half + half = 1 := by rw [← mul_two, hhalf]      -- `half · 2 = half + half`
          have hsplit : τ P = half * τ P + half * τ P :=
            calc τ P = 1 * τ P := (one_mul _).symm
              _ = (half + half) * τ P := by rw [hsum]
              _ = half * τ P + half * τ P := add_mul _ _ _
          rw [sub_eq_iff_eq_add, ← hsplit]                              -- `K` の四則

variable [Fintype ι]

/-- **主張**（`k ≥ 1`。具体版 `trace_projFactor_finProdLeft` と同じ 2 つの節）:
相異なる `μ_1, …, μ_k ∈ ι` について `τ(∏_{j=1}^{k} R_{μ_j}^{(e_j)}) = 2^{|ι|-k}`。`k = 1` の帰納法の仮定は `hτ1`（基底段階）である。 -/
theorem tau_finProdLeft_projFactor (τ : A → K) (hlin : ∀ (α β : K) (x y : A), τ (α • x + β • y) = α * τ x + β * τ y)
    (hcyc : ∀ x y : A, τ (x * y) = τ (y * x)) (half : K) (hhalf : half * 2 = 1) (c a : ι → A) (hac : ∀ i, a i * c i = 1 - num c a i)
    (hcomm : ∀ i j, i ≠ j → a i * num c a j = num c a j * a i)
    (hτ1 : τ 1 = (2 : K) ^ (Fintype.card ι - 0)) (T : Finset ι) :
    ∀ (r : ℕ) (μ : Fin (r + 1) → ι), Function.Injective μ →
      τ (finProdLeft r (fun j => projFactor (num c a) T (μ j))) = (2 : K) ^ (Fintype.card ι - (r + 1))
  | 0, μ, hμ => by
    have hle : 0 + 1 ≤ Fintype.card ι := by
      simpa using Fintype.card_le_of_injective μ hμ               -- `k ≤ |ι|`
    calc τ (finProdLeft 0 (fun j => projFactor (num c a) T (μ j)))
        = τ (projFactor (num c a) T (μ 0)) := by rw [finProdLeft_zero]      -- 準備 1: 有限積の定義
      _ = τ (1 * projFactor (num c a) T (μ 0)) := by rw [one_mul]            -- 準備 1: 単位元（左）を右辺から左辺へ
      _ = half * τ 1 :=
          tau_mul_projFactor_eq_half τ hlin hcyc half hhalf c a hac T 1 (μ 0) (mul_one_eq_one_mul _)
                                                                              -- 二場合（準備 2 は `P := 1`）
      _ = half * (2 : K) ^ (Fintype.card ι - 0) := by rw [hτ1]              -- 帰納法の仮定（基底段階）
      _ = half * (2 : K) ^ ((Fintype.card ι - (0 + 1)) + 1) := by
          rw [show Fintype.card ι - 0 = (Fintype.card ι - (0 + 1)) + 1 by omega]   -- 指数の整数計算
      _ = half * ((2 : K) ^ (Fintype.card ι - (0 + 1)) * 2) := by
          rw [pow_succ]
                                                                              -- 冪の定義
      _ = (2 : K) ^ (Fintype.card ι - (0 + 1)) := by
          rw [pow_mul_comm', ← mul_assoc, hhalf, one_mul]
                                                                              -- `K` の四則（`2^m 2 = 2 2^m`）
  | r + 1, μ, hμ => by
    have hle : r + 1 + 1 ≤ Fintype.card ι := by
      simpa using Fintype.card_le_of_injective μ hμ               -- `k ≤ |ι|`
    have hIH := tau_finProdLeft_projFactor τ hlin hcyc half hhalf c a hac hcomm hτ1 T r (fun j => μ (Fin.castSucc j))
      (hμ.comp (Fin.castSucc_injective _))                         -- 帰納法の仮定
    have hP : a (μ (Fin.last (r + 1))) * finProdLeft r (fun j => projFactor (num c a) T (μ (Fin.castSucc j)))
        = finProdLeft r (fun j => projFactor (num c a) T (μ (Fin.castSucc j))) * a (μ (Fin.last (r + 1))) :=
      commute_finProdLeft r _ _ (fun j =>
        ann_mul_projFactor c a hcomm T (fun h => (Fin.castSucc_lt_last j).ne' (hμ h)))
                                                                    -- 準備 2: 各因子と可換なら有限積とも可換
    calc τ (finProdLeft (r + 1) (fun j => projFactor (num c a) T (μ j)))
        = τ (finProdLeft r (fun j => projFactor (num c a) T (μ (Fin.castSucc j)))
            * projFactor (num c a) T (μ (Fin.last (r + 1)))) := by rw [finProdLeft_succ]
                                                                    -- 準備 1: 有限積の定義
      _ = half * τ (finProdLeft r (fun j => projFactor (num c a) T (μ (Fin.castSucc j)))) :=
          tau_mul_projFactor_eq_half τ hlin hcyc half hhalf c a hac T _ _ hP
                                                                    -- 二場合
      _ = half * (2 : K) ^ (Fintype.card ι - (r + 1)) := by rw [hIH]  -- 帰納法の仮定
      _ = half * (2 : K) ^ ((Fintype.card ι - (r + 1 + 1)) + 1) := by
          rw [show Fintype.card ι - (r + 1) = (Fintype.card ι - (r + 1 + 1)) + 1 by omega]   -- 指数の整数計算
      _ = half * ((2 : K) ^ (Fintype.card ι - (r + 1 + 1)) * 2) := by
          rw [pow_succ]
                                                                    -- 冪の定義
      _ = (2 : K) ^ (Fintype.card ι - (r + 1 + 1)) := by
          rw [pow_mul_comm', ← mul_assoc, hhalf, one_mul]
                                                                    -- `K` の四則（`2^m 2 = 2 2^m`）

/-- 移項の段が `τ(Pn)` を決めないことの確認（主張そのものの反例ではない）: `K = ZMod 2` では `t = 0` について `x = t - x` を満たす `x` が `0` と `1` の 2 つあり、
移項の段（`τ(Pn) = τ(P) - τ(Pn)` から `τ(Pn)` を決める段）が働かない。 -/
example : (0 : ZMod 2) = 0 - 0 ∧ (1 : ZMod 2) = 0 - 1 ∧ (0 : ZMod 2) ≠ 1 := by decide

end TraceByLastFactor

end Ising2D.NecSuf
