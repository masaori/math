/-
# 必要十分版: 張る族を各因子に入れた多重線型写像の値の族は、値全体の張る空間を張る

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル: **`<kronecker_family_of_spanning_family_spans>`**
（`structured-latex/content/002_linear_space_general.ts`。具体版は
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerFamilyOfSpanningFamilySpans.lean` の
`Ising2D.kronecker_family_of_spanning_family_spans`、特殊化による導出は同じフォルダの
`ClaimKroneckerFamilyOfSpanningFamilySpansFromNecSuf.lean`）。

## 具体版との手順の対応

ステップは具体版（`ClaimKroneckerFamilyOfSpanningFamilySpans.lean`）と同じ順で、同じ鎖を書く。

| 人手・具体版 | 本ファイル |
| --- | --- |
| `𝒮 := {Σ_q d_q F_q}`（`kroneckerFamilyCombinations`） | `familyCombinations f b` |
| Step 1（`𝒮` は線型結合について閉じる。5 段の鎖） | `linComb_mem_familyCombinations`（同じ 5 段） |
| Step 2（`C(s)` の帰納法。`s = 0` の 5 段、一段の 2 段） | `map_mem_familyCombinations`（同じ段。`kronecker_multilinear` は `f` の多重線型性） |
| Step 3（全体を `f` の値の線型結合で書き、`C(n)` と Step 1 で結ぶ） | `mem_familyCombinations_of_spanning` |

## 効いているもの（一次情報: 下の証明が使っている補題がすべて）

* 加群の公理のうち、`Finset.smul_sum`（スカラー倍は有限和に分配する）・`smul_smul`（`mul_smul`）・
  `Finset.sum_smul`（`add_smul`）・`one_smul`・`zero_smul`、有限和の入れ替え `Finset.sum_comm`。
* `f` が各因子について和とスカラー倍を保つこと（`MultilinearMap.map_update_sum`・`map_update_smul`）。
* 各因子の空間の元が `b` の有限の線型結合で書けること（仮定 `hb`）と、全体の元が `f` の値の有限の線型結合で書けること（仮定 `hf`）。

## 効いていないもの

* **行列であること・クロネッカー積であること**: `f` は任意の多重線型写像でよい。クロネッカー積の成分公式も、
  積の規則（`kronecker_product_rule`）も使わない。
* **係数が ℂ であること**: 係数は任意の半環 `R` でよい（体であることも可換性も使わない）。
* **`b` が基底であること**: 線型独立性は使わず、各因子の空間を張ることだけを使う。次元も使わない。
* **因子の個数が 4 であること・各因子の空間が `Mat(2, ℂ)` であること**: 添字は任意の有限型 `ι`、空間は任意の加群 `V`。
* **`n ≥ 1`**: `n = 0` でも同じ帰納法が通る（`s = 0` で族の元そのもの）。

## 外せない仮定

* `ι`・`κ` が有限であること: 仮定 `hb`・`hf` を有限和で書くのに要る（人手の `Σ_{a=1}^{4}` と `Σ_{t=1}^{N}`）。
  `ι → ` の写像全体 `Fin n → ι` の和にも要る。
* `ι` の等号が判定できること（`DecidableEq ι`）: `s = 0` の係数 `δ_{qq_0}`（`if q = p then 1 else 0`。`q, p : Fin n → ι`）を
  定義するのに要る。人手の `def_kronecker_delta` が番号の一致で場合分けするのに当たる。
* `hf`: これを外すと結論は偽になる（`f` の値で書けない元は、`f` の値の線型結合で書けない）。
  具体版では `tensor_basis` (1) の展開が与える。
-/
import Mathlib.LinearAlgebra.Multilinear.Basic
import Mathlib.Algebra.Module.BigOperators

namespace Ising2D.NecSuf

open Finset

variable {R : Type*} [Semiring R]
variable {V W : Type*} [AddCommMonoid V] [Module R V] [AddCommMonoid W] [Module R W]
variable {n : ℕ} {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 具体版の `𝒮`: `b` を各因子に入れた `f` の値の族の線型結合全体。 -/
def familyCombinations (f : MultilinearMap R (fun _ : Fin n => V) W) (b : ι → V) : Set W :=
  {w | ∃ d : (Fin n → ι) → R, w = ∑ p, d p • f (fun k => b (p k))}

/-- 具体版の Step 1: `𝒮` は線型結合について閉じる（具体版と同じ 5 段）。 -/
theorem linComb_mem_familyCombinations (f : MultilinearMap R (fun _ : Fin n => V) W) (b : ι → V)
    {κ : Type*} (t : Finset κ) (X : κ → W) (c : κ → R)
    (hX : ∀ a ∈ t, X a ∈ familyCombinations f b) :
    ∑ a ∈ t, c a • X a ∈ familyCombinations f b := by
  choose! d hd using hX
  refine ⟨fun p => ∑ a ∈ t, c a * d a p, ?_⟩
  calc ∑ a ∈ t, c a • X a
      = ∑ a ∈ t, c a • ∑ p, d a p • f (fun k => b (p k)) :=
        Finset.sum_congr rfl fun a ha => by rw [← hd a ha]               -- `X_a` の表示
    _ = ∑ a ∈ t, ∑ p, c a • (d a p • f (fun k => b (p k))) := by
        simp_rw [Finset.smul_sum]                                         -- スカラー倍は有限和に分配する
    _ = ∑ a ∈ t, ∑ p, (c a * d a p) • f (fun k => b (p k)) := by
        simp_rw [smul_smul]                                               -- スカラー倍の結合律
    _ = ∑ p, ∑ a ∈ t, (c a * d a p) • f (fun k => b (p k)) :=
        Finset.sum_comm                                                   -- 有限和の入れ替え
    _ = ∑ p, (∑ a ∈ t, c a * d a p) • f (fun k => b (p k)) := by
        simp_rw [Finset.sum_smul]                                         -- 係数の和によるスカラー倍

/-- 具体版の Step 2: 帰納法 `C(s)`（第 `s` 以降（0 始まり）の因子が `b` の元ならば `f x ∈ 𝒮`）。 -/
theorem map_mem_familyCombinations (f : MultilinearMap R (fun _ : Fin n => V) W) (b : ι → V)
    (hb : ∀ v : V, ∃ c : ι → R, v = ∑ a, c a • b a) :
    ∀ s : ℕ, s ≤ n → ∀ x : Fin n → V, (∀ k : Fin n, s ≤ (k : ℕ) → x k ∈ Set.range b) →
      f x ∈ familyCombinations f b
  | 0, _, x, hx => by
    choose p hp using fun k => hx k (Nat.zero_le _)                       -- `A_k = b_{a_k}`
    refine ⟨fun q => if q = p then 1 else 0, ?_⟩                          -- `d_q := δ_{qq_0}`
    calc f x
        = f (fun k => b (p k)) := by
          congr 1; funext k; exact (hp k).symm                            -- `A_k = b_{a_k}`
      _ = (1 : R) • f (fun k => b (p k)) := (one_smul R _).symm           -- `1` によるスカラー倍
      _ = (if p = p then (1 : R) else 0) • f (fun k => b (p k)) := by
          rw [if_pos rfl]                                                 -- `δ_{q_0q_0} = 1`
      _ = ∑ q, (if q = p then (1 : R) else 0) • f (fun k => b (q k)) := by
          rw [Finset.sum_eq_single p
            (fun q _ hq => by rw [if_neg hq, zero_smul])                  -- `q ≠ q_0` の項は `0`
            (fun h => absurd (Finset.mem_univ p) h)]                      -- 零でない項が 1 つだけの和
  | s + 1, hs, x, hx => by
    have hsn : s < n := hs
    obtain ⟨c, hc⟩ := hb (x ⟨s, hsn⟩)                                     -- 第 `s+1` 因子の展開
    have hexp : f x = ∑ a, c a • f (Function.update x ⟨s, hsn⟩ (b a)) := by
      calc f x
          = f (Function.update x ⟨s, hsn⟩ (∑ a, c a • b a)) := by
            rw [← hc, Function.update_eq_self]
        _ = ∑ a, c a • f (Function.update x ⟨s, hsn⟩ (b a)) := by
            rw [MultilinearMap.map_update_sum]                            -- 和を保つ
            exact Finset.sum_congr rfl fun a _ => f.map_update_smul x _ (c a) (b a)   -- スカラー倍を保つ
    rw [hexp]
    refine linComb_mem_familyCombinations f b Finset.univ _ c fun a _ => ?_   -- Step 1
    refine map_mem_familyCombinations f b hb s (Nat.le_of_lt hsn) _ fun k hk => ?_   -- 帰納法の仮定
    by_cases hks : k = ⟨s, hsn⟩
    · subst hks
      rw [Function.update_self]
      exact ⟨a, rfl⟩
    · rw [Function.update_of_ne hks]
      have hne : (k : ℕ) ≠ s := fun h => hks (Fin.ext h)
      exact hx k (by omega)

/-- 具体版の Step 3: 全体の元が `f` の値の有限の線型結合で書けるならば、全体の元は
`b` を各因子に入れた値の族の線型結合で書ける。 -/
theorem mem_familyCombinations_of_spanning (f : MultilinearMap R (fun _ : Fin n => V) W) (b : ι → V)
    (hb : ∀ v : V, ∃ c : ι → R, v = ∑ a, c a • b a)
    {κ : Type*} [Fintype κ] (y : κ → Fin n → V) (hf : ∀ w : W, ∃ c : κ → R, w = ∑ t, c t • f (y t))
    (w : W) : w ∈ familyCombinations f b := by
  obtain ⟨c, hc⟩ := hf w                                                 -- `w = Σ_t κ_t f(y_t)`
  rw [hc]
  exact linComb_mem_familyCombinations f b Finset.univ _ c fun t _ =>
    map_mem_familyCombinations f b hb n le_rfl (y t) fun k hk => absurd hk (by omega)   -- `C(n)`（条件は空）と Step 1

end Ising2D.NecSuf
