/-
# 抽象版: 反周期的（半整数運動量）フーリエ和

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素数・複素行列） |
| --- | --- |
| `antiperiodic_exp_sum` | `Ising2D/Part013/Claim002_AntiperiodicExpSum.lean` |
| `anticommutator_of_check_Z_Y` | `Ising2D/Part013/Claim005_AnticommutatorCheckZY.lean` |
| `recover_Z_Y_from_check_Z_Y` | `Ising2D/Part013/Claim006_RecoverZY.lean` |

具体版を本ファイルの抽象版の特殊化として導出したものは
`Ising2D/Part013/Claim002_AntiperiodicExpSumAbstract.lean` にある。

## 抽象版が何を明らかにするか

013 章は「整数運動量 `θ_μ = 2πμ/M` を半整数運動量 `θ~_μ = 2π(μ - 1/2)/M` に取り替える」章で、
本文は仕組みを 1 つの等式 `e^{-iM θ~_μ} = -1`（反周期性）に集約している。
抽象化するとこの等式の正体が見える。

* **`e^{-i θ~}` は 1 の原始 `2M` 乗根 `ξ` である。** 半整数運動量の位相
  `e^{-i j θ~_μ}` は `ξ^{j(2μ-1)}`、すなわち**`2M` 乗根の奇数周波数**にほかならない。
  反周期性 `e^{-iM θ~_μ} = -1` は `ξ^M = -1`（`pow_half_eq_neg_one`）であり、
  これは「`ξ^M` は `1` の平方根で、原始性から `1` ではない」から出る。
  整数運動量が `ζ = ξ^2`（1 の原始 `M` 乗根）の偶数周波数だったのに対応する。

* **整数運動量と半整数運動量は、同じ直交性 `sum_zpow_primitiveRoot` の別の特殊化である。**
  奇数周波数の和は
  `∑_{μ=1}^{M} ξ^{(2μ-1)k} = ξ^{k} ∑_{μ=0}^{M-1} (ξ^2)^{μ k} = ξ^{k} · M δ^M_{k,0}`
  と、定数位相 `ξ^{k}` を括り出すだけで偶数周波数の和（既存の
  `Ising2D.Abstract.sum_zpow_primitiveRoot`）に帰着する。
  人手証明が「`M(-1)^l` か `0`」と場合分けしている `(-1)^l` は、この定数位相を
  `M ∣ k` のところで評価した `ξ^{lM} = (ξ^M)^{l} = (-1)^l` である。

* **反交換関係は既存の抽象版のまま特殊化できる。** `Abstract.acomm_fourier_clifford_weights`
  は「位相が `ζ^{(j+1)ν}`、重みが任意」という形なので、`ζ := ξ`（`2M` 乗根）、
  `ν := 2μ-1`（奇数）と取るだけでよい。効いているのは Clifford 関係と直交性だけで、
  周波数が偶数か奇数かは効かない。**対になる添字が `μ+ν ≡ 0` から `μ+ν ≡ 1` へ
  ずれるのは、奇数 + 奇数 = 偶数 `2(μ+ν-1)` の `-1` に由来する**（それだけである）。

* **添字の周期性も既存の抽象版のまま特殊化できる。** `Abstract.transform_periodic`
  （重み `w_j`・周波数 `a_j` が任意）に `w_j = ξ^{-j}`, `a_j = j`, `ζ = ξ^2` を入れれば
  `check(Z)_{μ+M} = check(Z)_μ` になる。効いているのは `ζ^M = 1` の 1 点だけ。

* 逆変換（`recover_Z_Y_from_check_Z_Y`）だけは既存の `inverse_dft_abstract`
  （`M` 乗根版）の特殊化にならない。周波数が奇数だと `ζ = ξ^2` に揃わないためで、
  本ファイルに `inverse_dft_antiperiodic` として別に立ててある。
  ただし証明の骨格（位相をまとめる → 二重和の順序交換 → 直交性）は同じである。
-/
import Ising2D.Abstract.RootOfUnitySum
import Ising2D.Abstract.FourierClifford
import Ising2D.Abstract.DiscreteFourier
import Mathlib.Algebra.Module.Defs

namespace Ising2D.Abstract

variable {K : Type*} [Field K]

/-! ## `1` の原始 `2M` 乗根の基本性質 -/

/-- **反周期性の正体**: `ξ` が 1 の原始 `2M` 乗根なら `ξ^M = -1`。

人手証明の `e^{-iM\tildeθ_μ} = -1`（`def_half_integer_modes` (1)）にあたる。
効いているのは「`(ξ^M)^2 = 1` かつ `ξ^M ≠ 1`」だけで、
指数関数・円周率・複素数であることは効かない。 -/
theorem pow_half_eq_neg_one {M : ℕ} (hM : M ≠ 0) {ξ : K} (hξ : IsPrimitiveRoot ξ (2 * M)) :
    ξ ^ M = -1 := by
  have hsq : (ξ ^ M) * (ξ ^ M) = 1 := by
    rw [← pow_add, show M + M = 2 * M by ring, hξ.pow_eq_one]
  have hne : ξ ^ M ≠ 1 := by
    intro h
    have hdvd : 2 * M ∣ M := (hξ.pow_eq_one_iff_dvd M).1 h
    have hle : 2 * M ≤ M := Nat.le_of_dvd (Nat.pos_of_ne_zero hM) hdvd
    omega
  rcases mul_self_eq_one_iff.1 hsq with h | h
  · exact absurd h hne
  · exact h

/-- `ξ` が 1 の原始 `2M` 乗根なら `ξ^2` は 1 の原始 `M` 乗根。

整数運動量（`ζ = ξ^2` の偶数周波数）と半整数運動量（`ξ` の奇数周波数）を
同じ直交性へ帰着させるための橋渡し。 -/
theorem sq_isPrimitiveRoot {M : ℕ} (hM : M ≠ 0) {ξ : K} (hξ : IsPrimitiveRoot ξ (2 * M)) :
    IsPrimitiveRoot (ξ ^ 2) M :=
  hξ.pow (by omega) rfl

/-- `M ∣ k` のところでの定数位相の値: `ξ^{l M} = (-1)^l`。

人手証明が `k = lM` の場合に出している `(-1)^l` はこれである。 -/
theorem zpow_mul_natCast {M : ℕ} (hM : M ≠ 0) {ξ : K} (hξ : IsPrimitiveRoot ξ (2 * M))
    (l : ℤ) : ξ ^ (l * (M : ℤ)) = (-1 : K) ^ l := by
  have hM' : ξ ^ ((M : ℕ) : ℤ) = -1 := by rw [zpow_natCast]; exact pow_half_eq_neg_one hM hξ
  rw [show l * (M : ℤ) = ((M : ℕ) : ℤ) * l by ring, zpow_mul, hM']

/-! ## 反周期的な指数和（`antiperiodic_exp_sum` の抽象版） -/

/-- 既存の直交性 `sum_zpow_primitiveRoot`（添字が `1,…,M`）の `0,…,M-1` 版。

`μ = 0` の項と `μ = M` の項がどちらも `ζ^0 = ζ^{Mk} = 1` なので値は同じである。 -/
theorem sum_zpow_primitiveRoot_zero_based {M : ℕ} (hM : M ≠ 0) {ζ : K}
    (hζ : IsPrimitiveRoot ζ M) (k : ℤ) :
    ∑ j : Fin M, ζ ^ (((j : ℕ) : ℤ) * k) = (M : K) * (if (M : ℤ) ∣ k then 1 else 0) := by
  have hζ0 : ζ ≠ 0 := hζ.ne_zero hM
  have hterm : ∀ j : Fin M,
      ζ ^ (((j : ℕ) : ℤ) * k) = ζ ^ ((((j : ℕ) : ℤ) + 1) * k) * ζ ^ (-k) := by
    intro j
    rw [← zpow_add₀ hζ0]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.sum_mul,
    sum_zpow_primitiveRoot hM hζ k]
  by_cases hd : (M : ℤ) ∣ k
  · rw [if_pos hd, mul_one, (hζ.zpow_eq_one_iff_dvd (-k)).2 ((dvd_neg).2 hd), mul_one]
  · rw [if_neg hd, mul_zero, zero_mul]

/-- **抽象版の本体（`antiperiodic_exp_sum` の骨格）**: `ξ` が体 `K` の中の 1 の原始 `2M` 乗根なら

  `∑_{μ=1}^{M} ξ^{(2μ-1)k} = ξ^{k} · M · (M ∣ k なら 1、そうでなければ 0)`。

（`Fin M` の添字 `μ` に対して原文の `μ` は `(μ : ℕ) + 1` なので、`2μ-1` は `2(μ:ℕ)+1`。）

証明は「定数位相 `ξ^{k}` を括り出して偶数周波数の和にする」の 1 段だけで、
残りは既存の直交性 `sum_zpow_primitiveRoot`（1 の原始 `M` 乗根 `ζ = ξ^2`）である。
すなわち**整数運動量の指数和と半整数運動量の指数和は、同じ直交性の別の特殊化**である。 -/
theorem sum_zpow_antiperiodic {M : ℕ} (hM : M ≠ 0) {ξ : K} (hξ : IsPrimitiveRoot ξ (2 * M))
    (k : ℤ) :
    ∑ μ : Fin M, ξ ^ ((2 * ((μ : ℕ) : ℤ) + 1) * k)
      = ξ ^ k * ((M : K) * (if (M : ℤ) ∣ k then 1 else 0)) := by
  have hξ0 : ξ ≠ 0 := hξ.ne_zero (by omega)
  have hterm : ∀ μ : Fin M,
      ξ ^ ((2 * ((μ : ℕ) : ℤ) + 1) * k)
        = ξ ^ k * (ξ ^ 2) ^ (((μ : ℕ) : ℤ) * k) := by
    intro μ
    rw [← zpow_natCast ξ 2, ← zpow_mul, ← zpow_add₀ hξ0]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.mul_sum,
    sum_zpow_primitiveRoot_zero_based hM (sq_isPrimitiveRoot hM hξ) k]

/-! ## 反周期的な逆変換（`recover_Z_Y_from_check_Z_Y` の抽象版） -/

/-- `Fin M` の 2 元 `j, m` について `M ∣ (j - m) ⟺ j = m`（`|j - m| < M` だから）。
`Abstract.fin_dvd_sub_iff_eq`（`DiscreteFourier.lean`）と同じ主張だが、
本ファイルを独立に読めるようにここでも参照できる形にしておく。 -/
theorem fin_dvd_sub_iff_eq' {M : ℕ} (j m : Fin M) :
    ((M : ℤ) ∣ ((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) ↔ j = m :=
  fin_dvd_sub_iff_eq j m

variable {V : Type*} [AddCommGroup V] [Module K V]

/-- **抽象版の反周期的離散フーリエ逆変換（`recover_Z_Y_from_check_Z_Y` の骨格）**。

`ξ` を体 `K` の中の 1 の原始 `2M` 乗根とし、`V` を `K`-加群とする。
族 `x : Fin M → V` の**半整数運動量**変換 `check(x)_μ = ∑_j ξ^{-(j+1)(2μ-1)} x_j` に対し

  `∑_{μ} ξ^{(m+1)(2μ-1)} check(x)_μ = M x_m`。

`inverse_dft_abstract`（整数運動量版、`Abstract/DiscreteFourier.lean`）と証明の骨格は同じで、
違いは直交性として `sum_zpow_antiperiodic` を使う点だけ。
効いているのは `ξ` が 1 の原始 `2M` 乗根であることと、対象が `K`-加群であることだけで、
行列であることも積があることも Clifford 関係も効かない。 -/
theorem inverse_dft_antiperiodic {M : ℕ} (hM : M ≠ 0) {ξ : K} (hξ : IsPrimitiveRoot ξ (2 * M))
    (x : Fin M → V) (m : Fin M) :
    ∑ μ : Fin M, ξ ^ ((((m : ℕ) : ℤ) + 1) * (2 * ((μ : ℕ) : ℤ) + 1)) •
        (∑ j : Fin M, ξ ^ (-((((j : ℕ) : ℤ) + 1) * (2 * ((μ : ℕ) : ℤ) + 1))) • x j)
      = (M : K) • x m := by
  classical
  have hξ0 : ξ ≠ 0 := hξ.ne_zero (by omega)
  -- Step 0: 指数法則で位相をまとめる
  have step1 : ∀ μ : Fin M,
      ξ ^ ((((m : ℕ) : ℤ) + 1) * (2 * ((μ : ℕ) : ℤ) + 1)) •
          (∑ j : Fin M, ξ ^ (-((((j : ℕ) : ℤ) + 1) * (2 * ((μ : ℕ) : ℤ) + 1))) • x j)
        = ∑ j : Fin M,
            ξ ^ ((2 * ((μ : ℕ) : ℤ) + 1) * (((m : ℕ) : ℤ) - ((j : ℕ) : ℤ))) • x j := by
    intro μ
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_smul, ← zpow_add₀ hξ0]
    congr 1
    ring
  simp_rw [step1]
  -- Step 1: 有限二重和の順序交換
  rw [Finset.sum_comm]
  -- Step 2: `μ` についての反周期的直交性
  have step2 : ∀ j : Fin M,
      (∑ μ : Fin M, ξ ^ ((2 * ((μ : ℕ) : ℤ) + 1) * (((m : ℕ) : ℤ) - ((j : ℕ) : ℤ))) • x j)
        = (ξ ^ (((m : ℕ) : ℤ) - ((j : ℕ) : ℤ)) *
            ((M : K) *
              (if (M : ℤ) ∣ (((m : ℕ) : ℤ) - ((j : ℕ) : ℤ)) then 1 else 0))) • x j := by
    intro j
    rw [← Finset.sum_smul, sum_zpow_antiperiodic hM hξ]
  simp_rw [step2]
  -- Step 3: `j = m` の項だけ残る（このとき定数位相は `ξ^0 = 1`）
  rw [Finset.sum_eq_single_of_mem m (Finset.mem_univ m)]
  · rw [sub_self, if_pos (dvd_zero _), mul_one, zpow_zero, one_mul]
  · intro j _ hj
    rw [if_neg (fun h => hj ((fin_dvd_sub_iff_eq m j).1 h).symm), mul_zero, mul_zero, zero_smul]

/-! ## 反周期的フーリエ和どうしの反交換子（`anticommutator_of_check_Z_Y` の抽象版） -/

section Clifford

variable {A : Type*} [Ring A] [Algebra K A]

/-- **抽象版（`anticommutator_of_check_Z_Y` の骨格）**:

`x, y` が Clifford 関係 `[x_a, y_b]₊ = 2δ_{ab}·1` を満たすとき、
半整数運動量のフーリエ和（周波数が**奇数** `2μ-1`）どうしの反交換子は

  `[∑_j ξ^{(j+1)(2μ-1)} x_j, ∑_j ξ^{(j+1)(2ν-1)} y_j]₊ = 2M δ^M_{μ+ν-1,0} · 1`。

既存の `acomm_fourier_clifford_weights`（重み・周波数が任意）を
`ζ := ξ`（1 の原始 `2M` 乗根）・周波数 `2μ-1` に特殊化しただけである。
**対になる添字が整数運動量の `μ+ν ≡ 0` から `μ+ν ≡ 1` へずれるのは、
`(2μ-1) + (2ν-1) = 2(μ+ν-1)` の `-1` だけに由来する。** -/
theorem acomm_antiperiodic_fourier_clifford {M : ℕ} (hM : M ≠ 0) {ξ : K}
    (hξ : IsPrimitiveRoot ξ (2 * M)) (x y : Fin M → A)
    (h : ∀ a b, acomm (x a) (y b) = (if a = b then (2 : K) else 0) • (1 : A)) (μ ν : ℤ) :
    acomm (∑ j : Fin M, ξ ^ ((((j : ℕ) : ℤ) + 1) * (2 * μ - 1)) • x j)
        (∑ j : Fin M, ξ ^ ((((j : ℕ) : ℤ) + 1) * (2 * ν - 1)) • y j)
      = (2 * (M : K) * (if (M : ℤ) ∣ (μ + ν - 1) then 1 else 0)) • (1 : A) := by
  have hξ0 : ξ ≠ 0 := hξ.ne_zero (by omega)
  have hrw : ∀ (c : ℤ) (w : Fin M → A),
      (∑ j : Fin M, ξ ^ ((((j : ℕ) : ℤ) + 1) * c) • w j)
        = ∑ j : Fin M, ((1 : K) * ξ ^ ((((j : ℕ) : ℤ) + 1) * c)) • w j := by
    intro c w
    exact Finset.sum_congr rfl fun j _ => by rw [one_mul]
  rw [hrw (2 * μ - 1) x, hrw (2 * ν - 1) y,
    acomm_fourier_clifford_weights hξ0 x y h (fun _ => (1 : K)) (fun _ => (1 : K))
      (2 * μ - 1) (2 * ν - 1)]
  congr 1
  have hsum : ∑ j : Fin M,
      (1 : K) * (1 : K) * ξ ^ ((((j : ℕ) : ℤ) + 1) * ((2 * μ - 1) + (2 * ν - 1)))
      = ∑ j : Fin M, (ξ ^ 2) ^ ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)) := by
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [one_mul, one_mul, ← zpow_natCast ξ 2, ← zpow_mul]
    congr 1
    push_cast
    ring
  rw [hsum, sum_zpow_primitiveRoot hM (sq_isPrimitiveRoot hM hξ) (μ + ν - 1)]
  ring

end Clifford

end Ising2D.Abstract
