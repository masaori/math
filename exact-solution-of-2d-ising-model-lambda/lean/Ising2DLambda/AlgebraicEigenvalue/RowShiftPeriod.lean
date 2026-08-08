/-
章「固有値の代数性」の「行配位の最小周期」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_row_config_shift_minimal_period`）と主張 3 件
（`claim_row_config_shift_iterate_add` / `claim_row_config_shift_period_divides` /
`claim_row_config_minimal_period_divides_L`）に対応する。

  人手証明                              このファイル
  K(τ) が空でないこと（L ∈ K(τ)）        rowShiftIterate_period_exists
  e(τ)（最小周期）                       rowShiftMinimalPeriod L τ
  S^[a+b](τ) = S^[a](S^[b](τ))           rowShiftIterate_add
  S^[k](τ) = τ ⟺ e(τ) | k                rowShiftIterate_eq_self_iff
  e(τ) | L                               rowShiftMinimalPeriod_dvd_L

最小周期は `Nat.find`（自然数の整列性）で取る。人手証明が「K(τ) の最小元」として定めている
ことにあたる。mathlib の `Function.minimalPeriod` は引いていない。引くと「もとへ戻る回数の
集合の最小元」という人手証明の定め方が、既製の定義の性質へ置き換わってしまうためである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位、回数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrixOrder

namespace Ising2DLambda.AlgebraicEigenvalue

open TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張「反復の回数は足し算になる」。証明は人手証明どおり `a` についての帰納法。 -/
theorem rowShiftIterate_add (a b : ℕ) (τ : RowConfig L) :
    rowShiftIterate L (a + b) τ = rowShiftIterate L a (rowShiftIterate L b τ) := by
  induction a with
  | zero =>
    -- 0 + b = b、S^[0] = id
    rw [Nat.zero_add]
    rfl
  | succ a ih =>
    -- (a+1) + b = (a+b) + 1、S^[k+1] = S ∘ S^[k]
    rw [Nat.succ_add]
    show rowShift L (rowShiftIterate L (a + b) τ)
      = rowShift L (rowShiftIterate L a (rowShiftIterate L b τ))
    rw [ih]

/-- 人手証明の「K(τ) は空でない」。`claim_row_config_shift_period` と `L ≥ 1` による。 -/
theorem rowShiftIterate_period_exists (τ : RowConfig L) :
    ∃ k, 1 ≤ k ∧ rowShiftIterate L k τ = τ :=
  ⟨L, Nat.one_le_iff_ne_zero.mpr (NeZero.ne L), rowShiftIterate_period τ⟩

variable (L)

/-- 人手証明の最小周期 `e(τ)`。`K(τ) = { k ≥ 1 | S^[k](τ) = τ }` の最小元。 -/
noncomputable def rowShiftMinimalPeriod (τ : RowConfig L) : ℕ :=
  open Classical in Nat.find (rowShiftIterate_period_exists τ)

variable {L}

/-- 人手証明の「e(τ) ≥ 1」。 -/
theorem rowShiftMinimalPeriod_pos (τ : RowConfig L) : 1 ≤ rowShiftMinimalPeriod L τ := by
  classical
  exact (Nat.find_spec (rowShiftIterate_period_exists τ)).1

/-- 人手証明の「S^[e(τ)](τ) = τ」。 -/
theorem rowShiftIterate_minimalPeriod (τ : RowConfig L) :
    rowShiftIterate L (rowShiftMinimalPeriod L τ) τ = τ := by
  classical
  exact (Nat.find_spec (rowShiftIterate_period_exists τ)).2

/-- 人手証明の「1 ≤ k < e(τ) では S^[k](τ) ≠ τ」（最小性）。 -/
theorem not_rowShiftIterate_of_lt_minimalPeriod (τ : RowConfig L) {k : ℕ} (hk1 : 1 ≤ k)
    (hk : k < rowShiftMinimalPeriod L τ) : rowShiftIterate L k τ ≠ τ := by
  classical
  intro hcontra
  exact Nat.find_min (rowShiftIterate_period_exists τ) hk ⟨hk1, hcontra⟩

/-- 人手証明の「割り切れるならばもとへ戻る」の側（`q` についての帰納法）。 -/
theorem rowShiftIterate_mul (τ : RowConfig L) {e : ℕ} (he : rowShiftIterate L e τ = τ) (q : ℕ) :
    rowShiftIterate L (e * q) τ = τ := by
  induction q with
  | zero => rw [Nat.mul_zero]; rfl
  | succ q ih =>
    -- e(q+1) = eq + e、S^[eq+e](τ) = S^[eq](S^[e](τ)) = S^[eq](τ) = τ
    rw [Nat.mul_succ, rowShiftIterate_add, he, ih]

/-- 人手証明の主張「もとへ戻る反復の回数は最小周期の倍数である」。

証明は人手証明どおり 2 つの向きに分け、`⇒` の側で自然数の除法 `k = e q + r` を使い、
`r ≥ 1` が最小性に反することで `r = 0` を出す。 -/
theorem rowShiftIterate_eq_self_iff (τ : RowConfig L) (k : ℕ) :
    rowShiftIterate L k τ = τ ↔ rowShiftMinimalPeriod L τ ∣ k := by
  classical
  constructor
  · intro hk
    set e := rowShiftMinimalPeriod L τ with he
    have hepos : 0 < e := rowShiftMinimalPeriod_pos τ
    have hsplit : k % e + e * (k / e) = k := Nat.mod_add_div k e
    have hr : rowShiftIterate L (k % e) τ = τ := by
      calc rowShiftIterate L (k % e) τ
          = rowShiftIterate L (k % e) (rowShiftIterate L (e * (k / e)) τ) := by
            rw [rowShiftIterate_mul τ (rowShiftIterate_minimalPeriod τ) (k / e)]
        _ = rowShiftIterate L (k % e + e * (k / e)) τ := (rowShiftIterate_add _ _ τ).symm
        _ = rowShiftIterate L k τ := by rw [hsplit]
        _ = τ := hk
    rcases Nat.eq_zero_or_pos (k % e) with hzero | hpos
    · exact Nat.dvd_of_mod_eq_zero hzero
    · exact absurd hr (not_rowShiftIterate_of_lt_minimalPeriod τ hpos (Nat.mod_lt k hepos))
  · rintro ⟨q, rfl⟩
    exact rowShiftIterate_mul τ (rowShiftIterate_minimalPeriod τ) q

variable (L)

/-- 人手証明の主張「最小周期は格子の一辺を割り切る」。

`S^[L](τ) = τ` に上の同値を `k = L` で当てるだけである。 -/
theorem rowShiftMinimalPeriod_dvd_L (τ : RowConfig L) : rowShiftMinimalPeriod L τ ∣ L :=
  (rowShiftIterate_eq_self_iff τ L).mp (rowShiftIterate_period τ)

end Ising2DLambda.AlgebraicEigenvalue
