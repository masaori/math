/-
# 差の有限和と、非負の項の有限和の下からの評価（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean`）:
`finite_sum_of_real_differences`, `finite_sum_of_negated_real_numbers`, `finite_sum_of_real_scalar_multiples`,
`finite_sum_of_nonnegative_reals_is_at_least_each_term`。

## 何が効いているか / 効いていないか

| 具体版（係数 `ℝ`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `finite_sum_of_real_differences_step` | `finite_sum_sub_step'`（同じ 4 段） | 差が符号反転を足すことで、符号反転が和を項ごとの符号反転の和へ移す可換な加法（`SubtractionCommMonoid`） |
| `finite_sum_of_real_differences_succ` | `finite_sum_sub_succ'`（同じ並び） | 同上 |
| `finite_sum_of_real_differences` | `finite_sum_sub_fin'` | 同上 |
| `finite_sum_of_negated_real_numbers_succ` | `finite_sum_neg_succ'`（同じ並び） | 加法についての可換モノイドと符号反転 `Neg` に、明示の仮定 `-(a + b) = -a + -b` を足したものだけ |
| `finite_sum_of_negated_real_numbers` | `finite_sum_neg_fin'` | 同上と、空の和のための明示の仮定 `-0 = 0` |
| `finite_sum_of_real_scalar_multiples_succ` | `finite_sum_mul_left_succ'`（同じ並び） | 加法についての可換モノイドと乗法 `Mul` に、左からの分配法則 `c(a + b) = ca + cb`（`LeftDistribClass`）を足したものだけ |
| `finite_sum_of_real_scalar_multiples` | `finite_sum_mul_left_fin'` | 同上と、空の和のための明示の仮定 `c0 = 0` |
| `finite_sum_of_real_scalar_multiples_fintype` | `finite_sum_mul_left'`（同じく番号を付けて `fin'` 版を当てる） | 同上 |
| `finite_sum_of_nonnegative_reals_ge_term_succ` | `finite_sum_ge_term_succ'`（同じ場合分けと並び） | 加法についての可換モノイドと、両辺に同じ元を左右どちらから足しても保たれる前順序（`Preorder`・`AddLeftMono`・`AddRightMono`） |
| `finite_sum_of_nonnegative_reals_ge_term` | `finite_sum_ge_term_fin'` | 同上 |
| `finite_sum_of_nonnegative_reals_ge_term_fintype` | `finite_sum_ge_term'`（同じく番号を付けて `fin'` 版を当てる） | 同上 |

* 差の主張に効いているのは、帰納法の段の `(α - β) + (x - y) = (α + x) - (β + y)` だけで、`finite_sum_sub_step'` の 4 段が示すとおり
  差が「符号反転を足すこと」（`sub_eq_add_neg`）、加法の結合則・交換則（`finite_sum_add_step'`）、`-(β + y) = -β + -y`（`neg_add`）から出る。
  加法の逆元の法則 `a + (-a) = 0` は使わないので、群ではなく `SubtractionCommMonoid` で足りる。乗法も順序も、実数であることも効いていない。
  交換則は外せない（`-β` と `x` を入れ替える段と、`neg_add` の右辺の順序がある）。
* 符号反転の主張に効いているのは、帰納法の段の `(-a) + (-b) = -(a + b)` だけで、これを明示の仮定 `hneg` として置く
  （空の和の `fin'` 版はさらに `-0 = 0` を `h0` として置く）。符号反転が対合であること、差、加法の逆元の法則 `a + (-a) = 0`、
  乗法、順序、実数であることは効いていない。加法の交換則は、`Finset` の上の和 `∑` が `AddCommMonoid` を要求するので外せない
  （人手の左から足す和の定義を `Fin` の上の `∑` で受けるための仮定で、帰納法の段そのものは交換則を使わない）。
* 共通の因子の主張に効いているのは、帰納法の段の `ca + cb = c(a + b)`（左からの分配法則）だけである
  （空の和の `fin'` 版はさらに `c0 = 0` を `h0` として置く）。乗法の結合則・交換則・単位元、右からの分配法則、差、順序、
  実数であることは効いていない。加法の交換則は、符号反転の主張と同じく `Finset` の上の和 `∑` のためだけに要る。
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

/-- **`Σ_{j=1}^{m+1}(-x_j) = -Σ x_j`**（具体版 `finite_sum_of_negated_real_numbers_succ`）。`m` についての帰納法。 -/
theorem finite_sum_neg_succ' [AddCommMonoid R] [Neg R] (hneg : ∀ a b : R, -(a + b) = -a + -b)
    (m : ℕ) (x : Fin (m + 1) → R) :
    ∑ j, -(x j) = -(∑ j, x j) := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, -(x j)
        = -(x 0) := Fin.sum_univ_one _                                       -- 和の定義（1 項）
      _ = -(∑ j : Fin 1, x j) := by rw [Fin.sum_univ_one x]                  -- 和の定義（1 項）を右辺から左辺へ
  | succ m ih =>
    calc ∑ j : Fin (m + 2), -(x j)
        = (∑ j : Fin (m + 1), -(x j.castSucc)) + -(x (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- 和の定義（項を 1 つ足す）
      _ = -(∑ j : Fin (m + 1), x j.castSucc) + -(x (Fin.last _)) := by
          rw [ih (fun j => x j.castSucc)]                                     -- 帰納法の仮定
      _ = -((∑ j : Fin (m + 1), x j.castSucc) + x (Fin.last _)) :=
          (hneg _ _).symm                                                     -- `(-a) + (-b) = -(a + b)`（仮定 `hneg`）
      _ = -(∑ j, x j) := by rw [Fin.sum_univ_castSucc x]                      -- 和の定義を右辺から左辺へ

/-- `Fin m` の上の和（`m = 0` を含む。具体版 `finite_sum_of_negated_real_numbers`）。 -/
theorem finite_sum_neg_fin' [AddCommMonoid R] [Neg R] (hneg : ∀ a b : R, -(a + b) = -a + -b)
    (h0 : -(0 : R) = 0) (m : ℕ) (x : Fin m → R) :
    ∑ j, -(x j) = -(∑ j, x j) := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, h0]                     -- 空の和（人手には無い。仮定 `h0`）
  | succ m => exact finite_sum_neg_succ' hneg m x

/-- **`Σ_{j=1}^{m+1} c x_j = c Σ x_j`**（具体版 `finite_sum_of_real_scalar_multiples_succ`）。`m` についての帰納法。
効いているのは左からの分配法則だけである。 -/
theorem finite_sum_mul_left_succ' [AddCommMonoid R] [Mul R] [LeftDistribClass R] (m : ℕ) (c : R)
    (x : Fin (m + 1) → R) : ∑ j, c * x j = c * ∑ j, x j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, c * x j
        = c * x 0 := Fin.sum_univ_one _                                      -- 和の定義（1 項）
      _ = c * ∑ j : Fin 1, x j := by rw [Fin.sum_univ_one x]                 -- 和の定義（1 項）を右辺から左辺へ
  | succ m ih =>
    calc ∑ j : Fin (m + 2), c * x j
        = (∑ j : Fin (m + 1), c * x j.castSucc) + c * x (Fin.last _) :=
          Fin.sum_univ_castSucc _                                             -- 和の定義（項を 1 つ足す）
      _ = c * (∑ j : Fin (m + 1), x j.castSucc) + c * x (Fin.last _) := by
          rw [ih (fun j => x j.castSucc)]                                     -- 帰納法の仮定
      _ = c * ((∑ j : Fin (m + 1), x j.castSucc) + x (Fin.last _)) :=
          (left_distrib _ _ _).symm                                           -- 左からの分配法則
      _ = c * ∑ j, x j := by rw [Fin.sum_univ_castSucc x]                     -- 和の定義を右辺から左辺へ

/-- **`Σ_j c x_j = c Σ_j x_j`**（`Fin m`。具体版 `finite_sum_of_real_scalar_multiples`）。空の和には明示の仮定 `c0 = 0` が要る
（左からの分配法則からは `c0 = c0 + c0` までしか出ず、`c0` を消す加法の簡約律が無いので `c0 = 0` は出ない）。 -/
theorem finite_sum_mul_left_fin' [AddCommMonoid R] [Mul R] [LeftDistribClass R] (c : R) (h0 : c * 0 = 0)
    (m : ℕ) (x : Fin m → R) : ∑ j, c * x j = c * ∑ j, x j := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, h0]
  | succ m => exact finite_sum_mul_left_succ' m c x

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

/-- 有限型 `κ` の上の和（具体版 `finite_sum_of_real_scalar_multiples_fintype`）。`κ` に `Fintype.equivFin` で番号を付け、
`finite_sum_mul_left_fin'` を使う。 -/
theorem finite_sum_mul_left' [AddCommMonoid R] [Mul R] [LeftDistribClass R] (c : R) (h0 : c * 0 = 0)
    {κ : Type*} [Fintype κ] (x : κ → R) : ∑ j, c * x j = c * ∑ j, x j := by
  let e := Fintype.equivFin κ
  calc ∑ j, c * x j
      = ∑ t : Fin (Fintype.card κ), c * x (e.symm t) :=
        (Equiv.sum_comp e.symm (fun j => c * x j)).symm                      -- 番号を付ける
    _ = c * ∑ t, x (e.symm t) := finite_sum_mul_left_fin' c h0 _ _
    _ = c * ∑ j, x j := by rw [Equiv.sum_comp e.symm x]                       -- 番号を外す

/-- 有限型 `κ` の上の和（具体版 `finite_sum_of_nonnegative_reals_ge_term_fintype`）。`κ` に `Fintype.equivFin` で番号を付け、
`finite_sum_ge_term_fin'` を使う。 -/
theorem finite_sum_ge_term' [AddCommMonoid R] [Preorder R] [AddLeftMono R] [AddRightMono R]
    {κ : Type*} [Fintype κ] (a : κ → R) (ha : ∀ j, 0 ≤ a j) (k : κ) : ∑ j, a j ≥ a k := by
  let e := Fintype.equivFin κ
  calc ∑ j, a j
      = ∑ t : Fin (Fintype.card κ), a (e.symm t) := (Equiv.sum_comp e.symm a).symm  -- 番号を付ける
    _ ≥ a (e.symm (e k)) := finite_sum_ge_term_fin' _ (fun t => a (e.symm t)) (fun t => ha _) (e k)
    _ = a k := by rw [Equiv.symm_apply_apply]                                 -- 番号を外す

end Ising2D.NecSuf
