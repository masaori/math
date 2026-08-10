/-
章「固有値の代数性」の主張「互換の反復合成の符号は `(-1)^k` である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_transposition_composite_sign`）に対応する。

  人手証明                                          このファイル
  準備の第一（1 ≤ j < e なら τ₀ ≠ S^[j](τ₀)）      rowShiftIterate_ne_self_of_lt_period
  準備の第二（相異なる 2 点の互換の符号は -1）      orbitTransposition_symm /
                                                    orbitTransposition_sign_of_ne
  帰納法の出発点（sgn_O(Ψ₀) = +1）                  ambientComposite の 0 の場合
  帰納法の一歩（乗法性を当てる）                    ambientComposite_sign の succ の場合
  主張（sgn_O(Ψ_k) = (-1)^k）                       ambientComposite_sign

`orbitPermSign` は ambient の写像を受けるので、人手証明の `Ψ^{O,τ₀}_k : O → O` を
ambient の写像 `ambientComposite` として持ち直す（`O` の上では
`orbitTranspositionComposite` と同じ値を取ることを `ambientComposite_val` で確かめる）。
乗法性 `orbitPermSign_comp` が第 2 引数の逆写像を要求するので、逆向きの反復合成
`ambientCompositeInv` も置く（互換が自分自身を逆写像に持つことから、合成の順を逆にするだけでよい）。

mathlib の `Equiv.Perm.sign` は引いていない（引くと転倒数で定めるという人手証明の定義が消える）。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは個数（ℕ）と符号（ℤ）だけである）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionCompositeIsShift
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionSign
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignMul

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の準備の第一。`1 ≤ j` と `j < e(τ₀)` ならば `τ₀ ≠ S^[j](τ₀)` である。

人手証明どおり、`S^[0](τ₀) = τ₀` と `claim_row_shift_iterate_distinct_below_period` から
`0 = j` を出して `1 ≤ j` に矛盾させる。 -/
theorem rowShiftIterate_ne_self_of_lt_period {τ₀ : RowConfig L} {j : ℕ}
    (hj : 1 ≤ j) (hjlt : j < rowShiftMinimalPeriod L τ₀) :
    τ₀ ≠ rowShiftIterate L j τ₀ := by
  intro h
  have h0 : rowShiftIterate L 0 τ₀ = rowShiftIterate L j τ₀ := h
  have := rowShiftIterate_index_eq_of_lt_period (by omega) hjlt h0
  omega

/-- 人手証明の準備の第二の前半。2 つの互換は写像として一致する（`t_{a,b} = t_{b,a}`）。

人手証明どおり `def_orbit_transposition` の 3 つの場合で値を見比べる。 -/
theorem orbitTransposition_symm (a b : RowConfig L) :
    orbitTransposition L a b = orbitTransposition L b a := by
  funext τ
  simp only [orbitTransposition]
  by_cases hτa : τ = a
  · by_cases hτb : τ = b
    · -- τ = a かつ τ = b。このとき a = b なのでどちらの値も同じである。
      have hab : a = b := hτa ▸ hτb
      simp [hτa, hτb, hab]
    · -- τ = a かつ τ ≠ b。どちらも b を返す（残るのは a = b のときの向きだけである）。
      simp [hτa, hτb]
      exact fun h => h.symm
  · by_cases hτb : τ = b
    · simp [hτa, hτb]
    · simp [hτa, hτb]

/-- 人手証明の準備の第二。`O` の相異なる 2 点の互換の符号は `-1` である。

人手証明どおり `a ≺ b` と `b ≺ a` の 2 つの場合に分け（`≺` の三分律）、
後者では 2 つの互換が写像として一致することを使って前者へ帰着させる。 -/
theorem orbitTransposition_sign_of_ne {O : Finset (RowConfig L)} {a b : RowConfig L}
    (ha : a ∈ O) (hb : b ∈ O) (hab : a ≠ b) :
    orbitPermSign L O (orbitTransposition L a b) = -1 := by
  rcases rowConfigLess_or_rowConfigLess hab with h | h
  · exact orbitTransposition_sign ha hb h
  · rw [orbitTransposition_symm]
    exact orbitTransposition_sign hb ha h

variable (L)

/-- 人手証明の `Ψ^{O,τ₀}_k` を ambient の写像として持ち直したもの。 -/
noncomputable def ambientComposite (τ₀ : RowConfig L) :
    ℕ → (RowConfig L → RowConfig L)
  | 0 => id
  | (k + 1) => fun τ =>
      orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) (ambientComposite τ₀ k τ)

/-- 上の逆向きの反復合成（互換の合成の順を逆にしたもの）。 -/
noncomputable def ambientCompositeInv (τ₀ : RowConfig L) :
    ℕ → (RowConfig L → RowConfig L)
  | 0 => id
  | (k + 1) => fun τ =>
      ambientCompositeInv τ₀ k
        (orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) τ)

variable {L}

/-- ambient の反復合成が `O` の上で人手証明の `Ψ^{O,τ₀}_k` と同じ値を取ること。 -/
theorem ambientComposite_val {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ)
    (τ : {τ : RowConfig L // τ ∈ O}) :
    (orbitTranspositionComposite hO hτ₀ k τ).1 = ambientComposite L τ₀ k τ.1 := by
  induction k with
  | zero => rfl
  | succ k ih =>
      show orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀)
          (orbitTranspositionComposite hO hτ₀ k τ).1
        = orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) (ambientComposite L τ₀ k τ.1)
      rw [ih]

/-- ambient の反復合成は `O` を保つ。 -/
theorem ambientComposite_mem {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    ∀ τ ∈ O, ambientComposite L τ₀ k τ ∈ O := by
  induction k with
  | zero => intro τ hτ; exact hτ
  | succ k ih =>
      intro τ hτ
      exact orbitTransposition_mem hτ₀ (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1))
        (ih τ hτ)

/-- 逆向きの反復合成も `O` を保つ。 -/
theorem ambientCompositeInv_mem {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    ∀ τ ∈ O, ambientCompositeInv L τ₀ k τ ∈ O := by
  induction k with
  | zero => intro τ hτ; exact hτ
  | succ k ih =>
      intro τ hτ
      exact ih _ (orbitTransposition_mem hτ₀
        (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1)) hτ)

/-- 逆向きの反復合成が左逆写像であること（`O` の上で往復すると恒等写像）。 -/
theorem ambientCompositeInv_left {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    ∀ τ ∈ O, ambientCompositeInv L τ₀ k (ambientComposite L τ₀ k τ) = τ := by
  induction k with
  | zero => intro τ _; rfl
  | succ k ih =>
      intro τ hτ
      show ambientCompositeInv L τ₀ k
          (orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀)
            (orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀)
              (ambientComposite L τ₀ k τ))) = τ
      rw [orbitTransposition_involutive]
      exact ih τ hτ

/-- 逆向きの反復合成が右逆写像であること（`O` の上で逆向きから往復しても恒等写像）。 -/
theorem ambientCompositeInv_right {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    ∀ τ ∈ O, ambientComposite L τ₀ k (ambientCompositeInv L τ₀ k τ) = τ := by
  induction k with
  | zero => intro τ _; rfl
  | succ k ih =>
      intro τ hτ
      show orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀)
          (ambientComposite L τ₀ k
            (ambientCompositeInv L τ₀ k
              (orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) τ))) = τ
      rw [ih _ (orbitTransposition_mem hτ₀
        (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1)) hτ)]
      exact orbitTransposition_involutive _ _ τ

/-- 人手証明の主張。`k < e(τ₀)` ならば `sgn_O(Ψ^{O,τ₀}_k) = (-1)^k` である。

人手証明どおり `k` についての帰納法である。出発点は恒等写像の符号が `+1` であること、
一歩は符号の乗法性（`claim_orbit_permutation_sign_mul`）と準備の 2 つである。 -/
theorem ambientComposite_sign {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) :
    ∀ k : ℕ, k < rowShiftMinimalPeriod L τ₀ →
      orbitPermSign L O (ambientComposite L τ₀ k) = (-1) ^ k := by
  intro k
  induction k with
  | zero =>
      intro _
      -- Ψ₀ = id_O。恒等写像の符号は +1 である。
      calc orbitPermSign L O (ambientComposite L τ₀ 0)
          = orbitPermSign L O id := rfl
        _ = 1 := orbitPermSign_id O
        _ = (-1 : ℤ) ^ 0 := by norm_num
  | succ k ih =>
      intro hk
      have hkk : k < rowShiftMinimalPeriod L τ₀ := by omega
      have hmemk := rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1)
      -- 準備の第一。τ₀ ≠ S^[k+1](τ₀) である。
      have hne : τ₀ ≠ rowShiftIterate L (k + 1) τ₀ :=
        rowShiftIterate_ne_self_of_lt_period (by omega) hk
      -- 互換は自分自身を逆写像に持つので O の上で単射である。
      have hinj₁ : ∀ τ ∈ O, ∀ τ' ∈ O,
          orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) τ
            = orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) τ' → τ = τ' :=
        injOn_of_leftInverse (g' := orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀))
          (fun τ _ => orbitTransposition_involutive _ _ τ)
      calc orbitPermSign L O (ambientComposite L τ₀ (k + 1))
          = orbitPermSign L O (fun τ =>
              orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀)
                (ambientComposite L τ₀ k τ)) := rfl
        _ = orbitPermSign L O (orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀))
              * orbitPermSign L O (ambientComposite L τ₀ k) :=
            orbitPermSign_comp (ambientComposite_mem hO hτ₀ k)
              (ambientCompositeInv_mem hO hτ₀ k)
              (ambientCompositeInv_left hO hτ₀ k) (ambientCompositeInv_right hO hτ₀ k)
              hinj₁
        _ = (-1) * orbitPermSign L O (ambientComposite L τ₀ k) := by
            rw [orbitTransposition_sign_of_ne hτ₀ hmemk hne]
        _ = (-1) * (-1) ^ k := by rw [ih hkk]
        _ = (-1 : ℤ) ^ (k + 1) := by ring

end Ising2DLambda.AlgebraicEigenvalue
