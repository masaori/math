/-
# 差の有限和と、非負の項の有限和の下からの評価（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean`）:
`finite_sum_of_real_differences`, `finite_sum_of_nonnegative_reals_is_at_least_each_term`。

## 何が効いているか / 効いていないか

| 具体版（係数 `ℝ`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `finite_sum_of_real_differences_step` | `finite_sum_sub_step'`（同じ 4 段） | 差が符号反転を足すことで、符号反転が和を項ごとの符号反転の和へ移す可換な加法（`SubtractionCommMonoid`） |
| `finite_sum_of_real_differences_succ` | `finite_sum_sub_succ'`（同じ並び） | 同上 |
| `finite_sum_of_real_differences` | `finite_sum_sub_fin'` | 同上 |
| `finite_sum_of_nonnegative_reals_ge_term_succ` | `finite_sum_ge_term_succ'`（同じ場合分けと並び） | 加法についての可換モノイドと、両辺に同じ元を左右どちらから足しても保たれる前順序（`Preorder`・`AddLeftMono`・`AddRightMono`） |
| `finite_sum_of_nonnegative_reals_ge_term` | `finite_sum_ge_term_fin'` | 同上 |

* 差の主張に効いているのは、帰納法の段の `(α - β) + (x - y) = (α + x) - (β + y)` だけで、`finite_sum_sub_step'` の 4 段が示すとおり
  差が「符号反転を足すこと」（`sub_eq_add_neg`）、加法の結合則・交換則（`finite_sum_add_step'`）、`-(β + y) = -β + -y`（`neg_add`）から出る。
  加法の逆元の法則 `a + (-a) = 0` は使わないので、群ではなく `SubtractionCommMonoid` で足りる。乗法も順序も、実数であることも効いていない。
  交換則は外せない（`-β` と `x` を入れ替える段と、`neg_add` の右辺の順序がある）。
* 非負の項の主張に効いているのは、`≤` の反射律・推移律（前順序）と、両辺に同じ元を足しても `≤` が保たれること（`add_le_add`。左右の両方を使う）、
  `0` が加法の単位元であることだけである。反対称律（半順序）も、差（符号反転）も乗法も、順序が全順序であることも効いていない。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.Monoid.Defs
import Ising2D.NecSuf.MatMulDistribSum

namespace Ising2D.NecSuf

variable {R : Type*}

/-- **帰納法の段**（具体版 `finite_sum_of_real_differences_step`）: `(α - β) + (x - y) = (α + x) - (β + y)`。 -/
theorem finite_sum_sub_step' [SubtractionCommMonoid R] (α β x y : R) :
    (α - β) + (x - y) = (α + x) - (β + y) :=
  calc (α - β) + (x - y)
      = (α + -β) + (x + -y) := by rw [sub_eq_add_neg α β, sub_eq_add_neg x y]   -- 差は符号反転を足すこと（2 か所）
    _ = (α + x) + (-β + -y) := finite_sum_add_step' _ _ _ _                     -- 結合則・交換則
    _ = (α + x) + -(β + y) := by rw [neg_add β y]                               -- 和の符号反転は符号反転の和
    _ = (α + x) - (β + y) := (sub_eq_add_neg _ _).symm                          -- 差は符号反転を足すこと

/-- **`Σ_{j=1}^{m+1}(a_j - b_j) = Σ a_j - Σ b_j`**（具体版 `finite_sum_of_real_differences_succ`）。`m` についての帰納法。 -/
theorem finite_sum_sub_succ' [SubtractionCommMonoid R] (m : ℕ) (a b : Fin (m + 1) → R) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, (a j - b j)
        = a 0 - b 0 := Fin.sum_univ_one _                                    -- 和の定義（1 項）
      _ = (∑ j : Fin 1, a j) - ∑ j : Fin 1, b j := by
          rw [Fin.sum_univ_one a, Fin.sum_univ_one b]                         -- 和の定義（1 項）を 2 か所
  | succ m ih =>
    calc ∑ j : Fin (m + 2), (a j - b j)
        = (∑ j : Fin (m + 1), (a j.castSucc - b j.castSucc)) + (a (Fin.last _) - b (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- 和の定義（項を 1 つ足す）
      _ = ((∑ j : Fin (m + 1), a j.castSucc) - ∑ j : Fin (m + 1), b j.castSucc)
            + (a (Fin.last _) - b (Fin.last _)) := by
          rw [ih (fun j => a j.castSucc) (fun j => b j.castSucc)]             -- 帰納法の仮定
      _ = ((∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _))
            - ((∑ j : Fin (m + 1), b j.castSucc) + b (Fin.last _)) :=
          finite_sum_sub_step' _ _ _ _                                         -- 和と差の計算
      _ = (∑ j, a j) - ∑ j, b j := by
          rw [Fin.sum_univ_castSucc a, Fin.sum_univ_castSucc b]               -- 和の定義を 2 か所

/-- `Fin m` の上の和（`m = 0` を含む。具体版 `finite_sum_of_real_differences`）。 -/
theorem finite_sum_sub_fin' [SubtractionCommMonoid R] (m : ℕ) (a b : Fin m → R) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, Fin.sum_univ_zero, sub_zero]   -- 空の和（人手には無い）
  | succ m => exact finite_sum_sub_succ' m a b

/-- **非負の項の有限和は各項以上**（具体版 `finite_sum_of_nonnegative_reals_ge_term_succ`）。`m` についての帰納法。 -/
theorem finite_sum_ge_term_succ' [AddCommMonoid R] [Preorder R] [AddLeftMono R] [AddRightMono R]
    (m : ℕ) (a : Fin (m + 1) → R) (ha : ∀ j, 0 ≤ a j) (k : Fin (m + 1)) : ∑ j, a j ≥ a k := by
  induction m with
  | zero =>
    have hk : k = 0 := Fin.fin_one_eq_zero k
    calc ∑ j : Fin 1, a j
        = a 0 := Fin.sum_univ_one _                                          -- 和の定義（1 項）
      _ = a k := by rw [hk]
      _ ≥ a k := le_refl _                                                    -- 反射律
  | succ m ih =>
    induction k using Fin.lastCases with
    | cast k' =>
      calc ∑ j : Fin (m + 2), a j
          = (∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- 和の定義（項を 1 つ足す）
        _ ≥ (∑ j : Fin (m + 1), a j.castSucc) + 0 := add_le_add le_rfl (ha _) -- 両辺に同じ元を足す
        _ = ∑ j : Fin (m + 1), a j.castSucc := add_zero _                     -- 0 は加法の単位元
        _ ≥ a k'.castSucc := ih (fun j => a j.castSucc) (fun j => ha _) k'    -- 帰納法の仮定
    | last =>
      have h0 : ∑ j : Fin (m + 1), a j.castSucc ≥ 0 :=
        le_trans (ha (Fin.castSucc 0)) (ih (fun j => a j.castSucc) (fun j => ha _) 0)   -- 推移律
      calc ∑ j : Fin (m + 2), a j
          = (∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- 和の定義（項を 1 つ足す）
        _ ≥ 0 + a (Fin.last _) := add_le_add h0 le_rfl                       -- 両辺に同じ元を足す
        _ = a (Fin.last _) := zero_add _                                      -- 0 は加法の単位元

/-- `Fin m` の上の和（具体版 `finite_sum_of_nonnegative_reals_ge_term`）。 -/
theorem finite_sum_ge_term_fin' [AddCommMonoid R] [Preorder R] [AddLeftMono R] [AddRightMono R]
    (m : ℕ) (a : Fin m → R) (ha : ∀ j, 0 ≤ a j) (k : Fin m) : ∑ j, a j ≥ a k := by
  cases m with
  | zero => exact k.elim0
  | succ m => exact finite_sum_ge_term_succ' m a ha k

end Ising2D.NecSuf
