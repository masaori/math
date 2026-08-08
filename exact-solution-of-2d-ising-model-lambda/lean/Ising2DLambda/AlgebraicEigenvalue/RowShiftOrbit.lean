/-
章「固有値の代数性」の「行配位の軌道」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_row_config_shift_iterate_injective`）と定義 1 件（`def_row_config_orbit`）と
主張 1 件（`claim_row_config_orbit_card`）に対応する。

  人手証明                              このファイル
  S^[k] が単射                           rowShiftIterate_injective
  O(τ)（軌道）                           rowShiftOrbit L τ
  d < e かつ e | d ならば d = 0 の段      eq_zero_of_dvd_of_lt_period
  η_τ : J(τ) → O(τ) の単射性             card_rowShiftOrbit の i_inj（`eq_of_iterate_eq` 経由）
  η_τ の全射性                            card_rowShiftOrbit の i_surj
  |O(τ)| = e(τ)                          card_rowShiftOrbit

個数の等式は `Finset.card_bij` で取る。これは人手証明が書いている形そのもの
（写像を 1 つ置き、単射性と全射性を別々に見る）である。mathlib の `Function.minimalPeriod` /
`Function.periodicOrbit` / 軌道の一般論は引いていない。引くと「反復で到達できる行配位の全体」
という人手証明の定め方と、その個数を数える段が既製の定義の性質へ置き換わる。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位、回数と個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftPeriod

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

-- 反復の単射性は `L ≥ 1` を使わない（一歩ずつ `S` の単射性へ帰着するだけである）。
omit [NeZero L] in
/-- 人手証明の主張「反復した巡回シフトは単射である」。

証明は人手証明どおり `k` についての帰納法で、一歩は `S` が単射であること
（`rowShiftEquiv` の単射性）から出る。 -/
theorem rowShiftIterate_injective (k : ℕ) :
    Function.Injective (rowShiftIterate L k) := by
  induction k with
  | zero =>
    -- S^[0] = id
    intro τ₁ τ₂ h
    exact h
  | succ k ih =>
    -- S^[k+1] = S ∘ S^[k]。S が単射なので S^[k](τ₁) = S^[k](τ₂) が出る
    intro τ₁ τ₂ h
    have h' : rowShift L (rowShiftIterate L k τ₁) = rowShift L (rowShiftIterate L k τ₂) := h
    exact ih ((rowShiftEquiv L).injective h')

variable (L)

/-- 人手証明の `O(τ) = { τ' ∈ R_L | τ' = S^[k](τ) を満たす k ∈ ℕ が存在する }`。 -/
noncomputable def rowShiftOrbit (τ : RowConfig L) : Finset (RowConfig L) :=
  open Classical in univ.filter fun τ' => ∃ k : ℕ, τ' = rowShiftIterate L k τ

variable {L}

lemma mem_rowShiftOrbit {τ τ' : RowConfig L} :
    τ' ∈ rowShiftOrbit L τ ↔ ∃ k : ℕ, τ' = rowShiftIterate L k τ := by
  classical
  simp [rowShiftOrbit]

/-- 人手証明が証明の冒頭で置いていること「`e | d` かつ `d < e` ならば `d = 0`」。

`d = e q` と書き、`q ≥ 1` ならば `d = e q ≥ e · 1 = e` となって `d < e` に反する、
という人手証明の議論をそのまま書く（mathlib の `Nat.eq_zero_of_dvd_of_lt` は引かない）。 -/
theorem eq_zero_of_dvd_of_lt_period {e d : ℕ} (hdvd : e ∣ d) (hlt : d < e) : d = 0 := by
  obtain ⟨q, rfl⟩ := hdvd
  rcases Nat.eq_zero_or_pos q with hq | hq
  · rw [hq, Nat.mul_zero]
  · exact absurd hlt (Nat.not_lt.mpr (Nat.le_mul_of_pos_right e hq))

/-- 人手証明の単射性の段（`a ≤ b` の側）。`a` と `b` は対称なのでこの向きだけ示す。 -/
theorem eq_of_rowShiftIterate_eq_of_le {τ : RowConfig L} {a b : ℕ} (hab : a ≤ b)
    (hb : b < rowShiftMinimalPeriod L τ)
    (h : rowShiftIterate L a τ = rowShiftIterate L b τ) : a = b := by
  -- S^[a](S^[b-a](τ)) = S^[a+(b-a)](τ) = S^[b](τ) = S^[a](τ)
  have hchain : rowShiftIterate L a (rowShiftIterate L (b - a) τ) = rowShiftIterate L a τ := by
    calc rowShiftIterate L a (rowShiftIterate L (b - a) τ)
        = rowShiftIterate L (a + (b - a)) τ := (rowShiftIterate_add a (b - a) τ).symm
      _ = rowShiftIterate L b τ := by rw [Nat.add_sub_cancel' hab]
      _ = rowShiftIterate L a τ := h.symm
  -- S^[a] は単射なので S^[b-a](τ) = τ。したがって e | b - a
  have hreturn : rowShiftIterate L (b - a) τ = τ := rowShiftIterate_injective a hchain
  have hdvd : rowShiftMinimalPeriod L τ ∣ b - a :=
    (rowShiftIterate_eq_self_iff τ (b - a)).mp hreturn
  -- b - a ≤ b < e なので、上で置いたことから b - a = 0
  have hzero : b - a = 0 := eq_zero_of_dvd_of_lt_period hdvd (Nat.lt_of_le_of_lt (Nat.sub_le b a) hb)
  omega

variable (L)

/-- 人手証明の主張「軌道の元の個数は最小周期に等しい」。

証明は人手証明どおり、写像 `η_τ(k) = S^[k](τ)` を `{ k ∈ ℕ | k < e(τ) }` から `O(τ)` へ置き、
単射性と全射性を別々に見る（`Finset.card_bij` はこの形そのものである）。 -/
theorem card_rowShiftOrbit (τ : RowConfig L) :
    (rowShiftOrbit L τ).card = rowShiftMinimalPeriod L τ := by
  classical
  have hcard : (range (rowShiftMinimalPeriod L τ)).card = (rowShiftOrbit L τ).card := by
    refine card_bij (fun k _ => rowShiftIterate L k τ) ?_ ?_ ?_
    · -- 行き先が O(τ) に属すること（軌道の定義そのもの）
      intro k _
      exact mem_rowShiftOrbit.mpr ⟨k, rfl⟩
    · -- 単射性。a と b は対称なので大小で場合を分け、片側だけを示した補題へ帰着する
      intro a ha b hb h
      rw [mem_range] at ha hb
      rcases Nat.le_total a b with hle | hle
      · exact eq_of_rowShiftIterate_eq_of_le hle hb h
      · exact (eq_of_rowShiftIterate_eq_of_le hle ha h.symm).symm
    · -- 全射性。k = e q + r（0 ≤ r < e）と書き、S^[k](τ) = S^[r](τ) を見る
      intro τ' hτ'
      obtain ⟨k, hk⟩ := mem_rowShiftOrbit.mp hτ'
      have hepos : 0 < rowShiftMinimalPeriod L τ := rowShiftMinimalPeriod_pos τ
      refine ⟨k % rowShiftMinimalPeriod L τ, mem_range.mpr (Nat.mod_lt k hepos), ?_⟩
      calc rowShiftIterate L (k % rowShiftMinimalPeriod L τ) τ
          = rowShiftIterate L (k % rowShiftMinimalPeriod L τ)
              (rowShiftIterate L
                (rowShiftMinimalPeriod L τ * (k / rowShiftMinimalPeriod L τ)) τ) := by
            rw [rowShiftIterate_mul τ (rowShiftIterate_minimalPeriod τ)]
        _ = rowShiftIterate L
              (k % rowShiftMinimalPeriod L τ
                + rowShiftMinimalPeriod L τ * (k / rowShiftMinimalPeriod L τ)) τ :=
            (rowShiftIterate_add _ _ τ).symm
        _ = rowShiftIterate L k τ := by rw [Nat.mod_add_div]
        _ = τ' := hk.symm
  rw [← hcard, card_range]

end Ising2DLambda.AlgebraicEigenvalue
