/-
章「固有値の代数性」の「シフト行列の位数」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件
（`def_column_translation_iterate` / `def_row_config_shift_iterate`）と主張 4 件・定理 1 件
（`claim_column_translation_iterate_apply` / `claim_column_translation_period` /
`claim_row_config_shift_iterate_apply` / `claim_row_config_shift_period` /
`claim_shift_matrix_pow` / `theorem_shift_matrix_order`）に対応する。

  人手証明                              このファイル
  γ^[k]（平行移動の反復）                columnTranslationIterate L k
  γ^[k](y) = y + π(k)                    columnTranslationIterate_apply
  γ^[L] = id                             columnTranslationIterate_period
  S^[k]（巡回シフトの反復）              rowShiftIterate L k
  (S^[k](τ))(y) = τ(γ^[k](y))            rowShiftIterate_apply
  S^[L] = id                             rowShiftIterate_period
  (U^k)_{τ,τ'} の場合分け                 shiftMatrix_pow_apply
  U^L = I                                shiftMatrix_pow_L

人手証明が反復の順を γ^[k+1] = γ^[k] ∘ γ、S^[k+1] = S ∘ S^[k] と別々に定めていることは、
ここでも同じである（噛み合わせるための選択であり、人手証明にその理由が書いてある）。
mathlib の `Function.iterate` は引いていない。引くと「2 つの反復を段ごとに噛み合わせる」
という人手証明の定め方が、既製の記法の性質へ置き換わってしまうためである。
行列の冪も人手証明の定義（`rowMatrixPow`）のままで、mathlib の `Monoid.npow` は引いていない。

行列の冪の引数のずらしについて。`rowMatrixPow L A k` は人手証明の `A^{k+1}` である
（人手証明は `A^0` を定めていない）。したがって人手証明の `U^L` は
`rowMatrixPow L (shiftMatrix L) (L - 1)` と書く。

住処: 人手証明のこれらのブロックは ℕ（行列の 2 つは ℤ）を宣言している。
ここに ℝ / ℂ は現れない（添字は `ZMod L`、成分は `Polynomial ℤ`）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrix

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の `γ^[0] = id`、`γ^[k+1] = γ^[k] ∘ γ`。 -/
def columnTranslationIterate : ℕ → (ZMod L → ZMod L)
  | 0 => id
  | k + 1 => fun y => columnTranslationIterate k (columnTranslation L y)

variable {L}

/-- 人手証明の主張「反復した平行移動は剰余類を足す操作である」。

証明は人手証明どおり `k` についての帰納法で、帰納法の仮定を `γ(y)` へ適用する。 -/
theorem columnTranslationIterate_apply (k : ℕ) (y : ZMod L) :
    columnTranslationIterate L k y = y + (k : ZMod L) := by
  induction k generalizing y with
  | zero =>
    -- γ^[0](y) = y = y + 0 = y + π(0)
    show y = y + ((0 : ℕ) : ZMod L)
    rw [Nat.cast_zero, add_zero]
  | succ k ih =>
    -- γ^[k+1](y) = γ^[k](γ(y)) = γ(y) + π(k) = (y + 1̄) + π(k) = y + π(k+1)
    show columnTranslationIterate L k (columnTranslation L y) = y + ((k + 1 : ℕ) : ZMod L)
    rw [ih, columnTranslation, Nat.cast_add, Nat.cast_one, add_assoc, add_comm (1 : ZMod L)]

/-- 人手証明の主張「平行移動を L 回施すと恒等写像になる」。

`π(L) = 0` であることによる。 -/
theorem columnTranslationIterate_period (y : ZMod L) :
    columnTranslationIterate L L y = y := by
  rw [columnTranslationIterate_apply, ZMod.natCast_self, add_zero]

variable (L)

/-- 人手証明の `S^[0] = id`、`S^[k+1] = S ∘ S^[k]`。 -/
def rowShiftIterate : ℕ → (RowConfig L → RowConfig L)
  | 0 => id
  | k + 1 => fun τ => rowShift L (rowShiftIterate k τ)

variable {L}

/-- 人手証明の主張「反復した巡回シフトは反復した平行移動による引き戻しである」。

証明は人手証明どおり `k` についての帰納法で、帰納法の仮定を `γ(y)` へ適用する
（そのために `y` を一般化したまま帰納法を回す）。 -/
theorem rowShiftIterate_apply (k : ℕ) (τ : RowConfig L) (y : ZMod L) :
    rowShiftIterate L k τ y = τ (columnTranslationIterate L k y) := by
  induction k generalizing y with
  | zero => rfl
  | succ k ih =>
    -- (S^[k+1](τ))(y) = (S^[k](τ))(γ(y)) = τ(γ^[k](γ(y))) = τ(γ^[k+1](y))
    show rowShiftIterate L k τ (columnTranslation L y)
      = τ (columnTranslationIterate L k (columnTranslation L y))
    exact ih (columnTranslation L y)

/-- 人手証明の主張「巡回シフトを L 回施すと恒等写像になる」。 -/
theorem rowShiftIterate_period (τ : RowConfig L) : rowShiftIterate L L τ = τ := by
  funext y
  rw [rowShiftIterate_apply, columnTranslationIterate_period]

/-- 人手証明の主張「シフト行列の冪は反復したシフトの行列である」。

Lean 側の引数 `k` は人手証明の指数 `k+1` にあたる（`rowMatrixPow` の約束）。
証明は人手証明どおりで、`k+1` の段は右から掛ける主張 `mul_shiftMatrix_apply` と
同値 `rowShift_eq_iff` の 2 つだけを使う。 -/
theorem shiftMatrix_pow_apply (k : ℕ) (τ τ' : RowConfig L) :
    rowMatrixPow L (shiftMatrix L) k τ τ'
      = if τ' = rowShiftIterate L (k + 1) τ then constPoly 1 else constPoly 0 := by
  classical
  induction k generalizing τ' with
  | zero =>
    -- U^1 = U、S^[1] = S
    show shiftMatrix L τ τ' = if τ' = rowShift L (rowShiftIterate L 0 τ) then _ else _
    rfl
  | succ k ih =>
    -- (U^{k+1})_{τ,τ''} = (U^k U)_{τ,τ''} = (U^k)_{τ,S'(τ'')}
    rw [rowMatrixPow_succ, mul_shiftMatrix_apply, ih]
    -- 条件 S'(τ'') = S^[k+1](τ) は τ'' = S(S^[k+1](τ)) = S^[k+2](τ) と同値
    by_cases h : τ' = rowShiftIterate L (k + 1 + 1) τ
    · rw [if_pos h, if_pos]
      exact (rowShift_eq_iff (rowShiftIterate L (k + 1) τ) τ').mp h
    · rw [if_neg h, if_neg]
      intro hcontra
      exact h ((rowShift_eq_iff (rowShiftIterate L (k + 1) τ) τ').mpr hcontra)

variable (L)

/-- 人手証明の定理「シフト行列の L 乗は単位行列である」。

人手証明の `U^L` は、引数のずらしにより `rowMatrixPow L (shiftMatrix L) (L - 1)` である。 -/
theorem shiftMatrix_pow_L :
    rowMatrixPow L (shiftMatrix L) (L - 1) = identityRowMatrix L := by
  classical
  have hL : L - 1 + 1 = L := Nat.succ_pred_eq_of_pos (Nat.pos_of_ne_zero (NeZero.ne L))
  funext τ τ'
  rw [shiftMatrix_pow_apply, hL, identityRowMatrix]
  -- S^[L](τ) = τ なので、条件 τ' = S^[L](τ) は τ = τ' と同じである
  rw [rowShiftIterate_period]
  by_cases h : τ = τ'
  · rw [if_pos h.symm, if_pos h]
  · rw [if_neg (fun hc : τ' = τ => h hc.symm), if_neg h]

end Ising2DLambda.AlgebraicEigenvalue
