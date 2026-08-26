/-
人手証明「点数乗表示の底は閾値の箱の値から一意に決まる」
（ラベル `claim_power_form_base_is_determined_by_threshold_box`）の Lean 具体版。

人手証明と同じ順で進む。
準備段: 閾値の箱の点の数を `n = L₀ ^ 3` と置き、`L₀` が正なので `n ≥ 1` であることを確かめる。
第一段: 仮定を `L = L₀` に適用して `c ^ n = Z_{L₀}(q) = c' ^ n` を得る。
第二段: 正の有理数について `0 < x < y` かつ `0 < z` なら `x * z < y * z` を `n` 回用いて、
        `c < c'` から `c ^ n < c' ^ n` を導く（人手証明の「因子を順に置き換える」に対応する）。
着地: 三分律で `c < c'`・`c > c'` をいずれも第一段の等式との矛盾で排除し、`c = c'` を得る。

扱うのは正の有理数の非零自然数乗だけであり、正の実数乗根も箱の大きさの極限も現れない。
底の存在は仮定に含まれており、ここで構成するのは一意性だけである。
-/
import Mathlib

namespace Ising3DCut.LimitQuantity

/-- 一辺 `L` の箱の点の数 `#V_L = L ^ 3`。 -/
def vertexNumber (L : ℕ) : ℕ := L ^ 3

/-- 準備段。`L₀` が正の自然数なら閾値の箱の点の数は `1` 以上である。 -/
theorem one_le_vertexNumber {L₀ : ℕ} (hL₀ : 0 < L₀) : 1 ≤ vertexNumber L₀ := by
  unfold vertexNumber
  exact Nat.one_le_pow _ _ hL₀

/-- 第二段。正の有理数について、狭義の大小は非零自然数乗で保たれる。
人手証明の「`n ≥ 1` 個の因子を順に置き換える」に対応する。 -/
theorem pow_lt_pow_left_of_pos {c c' : ℚ} (hc : 0 < c) (hlt : c < c')
    {n : ℕ} (hn : 1 ≤ n) : c ^ n < c' ^ n := by
  induction n with
  | zero => exact absurd hn (by decide)
  | succ k ih =>
      rcases Nat.eq_zero_or_pos k with hk | hk
      · subst hk
        simpa using hlt
      · have hprev : c ^ k < c' ^ k := ih hk
        have hcpos : (0 : ℚ) < c ^ k := pow_pos hc k
        calc c ^ (k + 1) = c ^ k * c := by ring
          _ < c' ^ k * c := by exact mul_lt_mul_of_pos_right hprev hc
          _ < c' ^ k * c' := by
                have : (0 : ℚ) < c' ^ k := pow_pos (hc.trans hlt) k
                exact mul_lt_mul_of_pos_left hlt this
          _ = c' ^ (k + 1) := by ring

/-- 人手証明の着地。閾値の箱での値が一致する二つの正の有理数の底は等しい。

`Z` は各箱の分配多項式の値を表す族、`hc`・`hc'` は「閾値以後すべての箱で点数乗表示が成り立つ」
という仮定である。使うのは閾値の箱 `L₀` の一本だけであり、それ以後の箱の情報は要らない。 -/
theorem power_form_base_is_determined_by_threshold_box
    {Z : ℕ → ℚ} {c c' : ℚ} {L₀ : ℕ}
    (hL₀ : 0 < L₀) (hcpos : 0 < c) (hc'pos : 0 < c')
    (hc : ∀ L, L₀ ≤ L → Z L = c ^ vertexNumber L)
    (hc' : ∀ L, L₀ ≤ L → Z L = c' ^ vertexNumber L) :
    c = c' := by
  -- 準備段
  have hn : 1 ≤ vertexNumber L₀ := one_le_vertexNumber hL₀
  -- 第一段: 仮定を閾値の箱そのものへ適用する
  have hpow : c ^ vertexNumber L₀ = c' ^ vertexNumber L₀ := by
    rw [← hc L₀ (le_refl L₀), hc' L₀ (le_refl L₀)]
  -- 着地: 三分律
  rcases lt_trichotomy c c' with hlt | heq | hgt
  · exact absurd hpow (ne_of_lt (pow_lt_pow_left_of_pos hcpos hlt hn))
  · exact heq
  · exact absurd hpow.symm (ne_of_lt (pow_lt_pow_left_of_pos hc'pos hgt hn))

end Ising3DCut.LimitQuantity
