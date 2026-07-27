/-
# 命題 A（$v_p$ の最終周期性）

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 A**、
根拠 report `integrable-lattice/outputs/reports/cycle3_T1_D-U2_rigorous.md` 命題 A (1)–(4)。

人手証明の主張（$T\in M_d(\mathbb{Z})$、$Z_N=\operatorname{Tr}T^N$）:

1. $(T^N \bmod p^k)_N$ は有限モノイド $M_d(\mathbb{Z}/p^k)$ 内の列だから最終周期的（鳩の巣）。
2. トレースは環準同型と可換なので $Z_N \bmod p^k$ も最終周期的。
3. 切断付値 $\min(v_p(Z_N),k)$ は $Z_N \bmod p^k$ で決まるので、最終周期的。
4. 有限手続きで決定可能。

本ファイルは 1–3 を形式化する。4（決定可能性）は Lean の定理ではなく計算量の主張なので
形式化の対象にしない（`README.md` の「形式化の現状」表を参照）。
切断付値は `IntegrableLattice.truncVal`（`TruncVal.lean`。mathlib の `padicValInt 0 = 0`
規約を避けるための定義。$z\neq0$ では `min (v_p z) k` に一致することを証明済み）。

**新規性は主張しない**（有限モノイド上の鳩の巣。古典）。
-/
import IntegrableLattice.TruncVal

namespace IntegrableLattice

/-- **命題 A (1) の核**: 有限モノイドの元の冪列は最終周期的（鳩の巣）。 -/
theorem exists_eventually_periodic_pow {M : Type*} [Monoid M] [Finite M] (a : M) :
    ∃ N₀ π : ℕ, 0 < π ∧ ∀ n, N₀ ≤ n → a ^ (n + π) = a ^ n := by
  obtain ⟨i, j, hne, hEq⟩ := Finite.exists_ne_map_eq_of_infinite (fun n : ℕ => a ^ n)
  -- `i ≠ j` なので、小さい方を前周期、差を周期に取る。
  have key : ∀ x y : ℕ, x < y → a ^ x = a ^ y →
      ∃ N₀ π : ℕ, 0 < π ∧ ∀ n, N₀ ≤ n → a ^ (n + π) = a ^ n := by
    intro x y hxy h
    refine ⟨x, y - x, Nat.sub_pos_of_lt hxy, ?_⟩
    intro n hn
    obtain ⟨m, rfl⟩ := Nat.exists_eq_add_of_le hn
    have hrw : x + m + (y - x) = y + m := by omega
    rw [hrw, pow_add, pow_add, ← h]
  rcases hne.lt_or_gt with h | h
  · exact key i j h hEq
  · exact key j i h hEq.symm

/-- 整数行列の `mod m` 還元（環準同型の行列版）。 -/
noncomputable def redMat (m : ℕ) {d : ℕ} (T : Matrix (Fin d) (Fin d) ℤ) :
    Matrix (Fin d) (Fin d) (ZMod m) :=
  (Int.castRingHom (ZMod m)).mapMatrix T

/-- **命題 A (1)**: $(T^N \bmod m)_N$ は最終周期的。 -/
theorem exists_eventually_periodic_matrixPow (m : ℕ) [NeZero m] {d : ℕ}
    (T : Matrix (Fin d) (Fin d) ℤ) :
    ∃ N₀ π : ℕ, 0 < π ∧ ∀ n, N₀ ≤ n → redMat m (T ^ (n + π)) = redMat m (T ^ n) := by
  obtain ⟨N₀, π, hπ, h⟩ := exists_eventually_periodic_pow (redMat m T)
  refine ⟨N₀, π, hπ, ?_⟩
  intro n hn
  have hpow : ∀ N : ℕ, redMat m (T ^ N) = (redMat m T) ^ N := by
    intro N; simp [redMat, map_pow]
  rw [hpow, hpow, h n hn]

/-- **命題 A (2)**: $Z_N = \operatorname{Tr} T^N$ の `mod m` 還元は最終周期的。
トレースが環準同型と可換であることを使う。 -/
theorem exists_eventually_periodic_trace (m : ℕ) [NeZero m] {d : ℕ}
    (T : Matrix (Fin d) (Fin d) ℤ) :
    ∃ N₀ π : ℕ, 0 < π ∧ ∀ n, N₀ ≤ n →
      ((Matrix.trace (T ^ (n + π)) : ℤ) : ZMod m) = ((Matrix.trace (T ^ n) : ℤ) : ZMod m) := by
  obtain ⟨N₀, π, hπ, h⟩ := exists_eventually_periodic_matrixPow m T
  refine ⟨N₀, π, hπ, ?_⟩
  intro n hn
  have htr : ∀ A : Matrix (Fin d) (Fin d) ℤ,
      ((Matrix.trace A : ℤ) : ZMod m) = Matrix.trace (redMat m A) := by
    intro A
    simp [redMat, Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply, Matrix.map_apply]
  rw [htr, htr, h n hn]

/-- **命題 A (3)**: 切断付値 $\min(v_p(Z_N),k)$（`truncVal p k`）は
$N$ について最終周期的。周期は $T^N \bmod p^k$ の周期を割る（同じ `π` が取れる）。 -/
theorem exists_eventually_periodic_truncVal (p k : ℕ) [hp : Fact p.Prime] {d : ℕ}
    (T : Matrix (Fin d) (Fin d) ℤ) :
    ∃ N₀ π : ℕ, 0 < π ∧ ∀ n, N₀ ≤ n →
      truncVal p k (Matrix.trace (T ^ (n + π))) = truncVal p k (Matrix.trace (T ^ n)) := by
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero _ hp.out.ne_zero⟩
  obtain ⟨N₀, π, hπ, h⟩ := exists_eventually_periodic_trace (p ^ k) T
  refine ⟨N₀, π, hπ, ?_⟩
  intro n hn
  refine truncVal_congr_of_dvd p k ?_
  have := h n hn
  have hmod : (Matrix.trace (T ^ (n + π)) : ℤ) ≡ Matrix.trace (T ^ n) [ZMOD (p ^ k : ℕ)] := by
    exact (ZMod.intCast_eq_intCast_iff _ _ _).mp this
  have := (Int.ModEq.dvd hmod.symm)
  simpa using this

/-- 命題 A (3) を人手証明の文言（`min (v_p Z_N) k`）で述べ直した版。
$Z_N \neq 0$ が必要（`truncVal` 版はその仮定を要さない）。 -/
theorem exists_eventually_periodic_min_padicValInt (p k : ℕ) [hp : Fact p.Prime] {d : ℕ}
    (T : Matrix (Fin d) (Fin d) ℤ) (hne : ∀ n, Matrix.trace (T ^ n) ≠ 0) :
    ∃ N₀ π : ℕ, 0 < π ∧ ∀ n, N₀ ≤ n →
      min (padicValInt p (Matrix.trace (T ^ (n + π)))) k
        = min (padicValInt p (Matrix.trace (T ^ n))) k := by
  obtain ⟨N₀, π, hπ, h⟩ := exists_eventually_periodic_truncVal p k T
  refine ⟨N₀, π, hπ, ?_⟩
  intro n hn
  rw [← truncVal_eq_min_padicValInt p k (hne (n + π)), ← truncVal_eq_min_padicValInt p k (hne n)]
  exact h n hn

end IntegrableLattice
