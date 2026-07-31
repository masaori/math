/-
# 命題 B（$\pi(p,1)$ の精密公式）— **片方向のみ**

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 B**
（根拠 report: `outputs/reports/cycle3_T1_D-U2_rigorous.md`、cycle 7–8 の指標の一次独立の議論）。

人手証明の主張は
$$\pi(p,1)=\operatorname{lcm}\{\operatorname{ord}(\lambda)\ :\ \lambda\in\overline{\mathbb{F}_p}^\times\
\text{は}\ \chi_T\ \text{の相異固有値で}\ p\nmid m_\lambda\}\qquad(m_\lambda=\text{代数的重複度})$$
という**等式**である。

## 形式化した主張（$\supseteq$ 方向＝ lcm が $\pi$ を割る側）

* `mulVec_pow_eq_pow_smul` — $Av=\mu v \Rightarrow A^n v=\mu^n v$。
* `eigenvalue_pow_eq_one_of_pow_eq_one` — $A^N=1$ かつ $\mu$ が固有値なら $\mu^N=1$。
* `orderOf_eigenvalue_dvd_orderOf` — $\operatorname{ord}(\mu)\mid\operatorname{ord}(A)$。
* `lcm_orderOf_eigenvalues_dvd_orderOf` — 固有値の有限集合 $s$ について
  $\operatorname{lcm}_{\mu\in s}\operatorname{ord}(\mu)\mid\operatorname{ord}(A)$。
  これが $\operatorname{lcm}\{\operatorname{ord}(\lambda)\}\mid\pi(p,1)$ である。

この方向には**重複度の仮定 $p\nmid m_\lambda$ は要らない**（どの固有値についても成り立つ）。
体は $\overline{\mathbb{F}_p}$ に限定せず任意の体で述べた。可算・非可算の区別には触れない
純代数の主張であり、$\mathbb{R}$ へは脱出していない。

## 形式化していない主張（**逆方向＝ $\pi(p,1)\mid\operatorname{lcm}$**）

* **逆向きの整除 $\operatorname{ord}(A)\mid\operatorname{lcm}\{\operatorname{ord}(\lambda)\}$ は形式化していない。**
  これが本質的な側であり、$p\nmid m_\lambda$ の仮定はここでしか効かない
  （$A$ の半単純性、すなわち $A$ が $\overline{\mathbb{F}_p}$ 上で対角化可能であることに帰着する。
  $p\mid m_\lambda$ だと冪単部分が非自明になり $\operatorname{ord}$ に $p$ 冪が乗る）。
* **障害は mathlib の欠落ではない。**（この点は 2026-07-31 の再調査で従来の記述を訂正した。
  旧 `README.md` は「mathlib に固有値の重複度を扱う API が無い」と書いていたが、**誤りである**。）
  一次確認（`scripts/mathlib-gap-survey.sh` / `logs/mathlib-gap-survey-cycle16.log` と個別 grep）によれば、
  必要な部品はすべて mathlib v4.32.1 に存在する:
  - 代数的重複度は `Polynomial.rootMultiplicity` で表せる。実際
    `Mathlib/LinearAlgebra/Eigenspace/Zero.lean:211` が `φ.charpoly.rootMultiplicity μ` を
    「algebraic multiplicity」と呼んでいる（`finrank_eigenspace_le`）。
  - 半単純性の判定は両方向ある: `Module.End.isSemisimple_of_squarefree_aeval_eq_zero`
    （`Mathlib/LinearAlgebra/Semisimple.lean:221`）と `Module.End.IsSemisimple.minpoly_squarefree`（同 246）。
  - 代数閉体上の固有空間分解は `Module.End.IsSemisimple.iSup_eigenspace_eq_top`
    （`Mathlib/LinearAlgebra/Eigenspace/Semisimple.lean:79`）。
* すなわち残っているのは**組み立ての作業量**であって、道具の不在ではない:
  行列 → `Module.End` への移送、$\mathbb{F}_p\to\overline{\mathbb{F}_p}$ への係数拡大、
  「$\chi_T$ の各重根の重複度が $p$ と素 $\Rightarrow$ minpoly が squarefree」の導出、
  そこから固有空間分解を経て $A^{\mathrm{lcm}}=1$ を出す段。**この step では実施していない。**
* したがって**命題 B は「部分的」であり、等式は未形式化**である。この事実は
  `lean/README.md` の「形式化の現状」表にもそのまま記録してある。

## 主張が弱くなる退化ケース（明示）

`orderOf A = 0`（＝ $A$ が有限位数をもたない。例えば $A$ が非可逆）のとき、$n\mid 0$ は常に真なので
上の整除は情報を持たない。意味があるのは $A$ が可逆で位数有限のとき、すなわち
$p\nmid\det T$（`PropCPeriod.isUnit_map_of_not_dvd_det`）かつ係数体が有限のときである。
定理としては正しいが、**この退化ケースを含む形で述べてある**ことを明記しておく。

**新規性は主張しない**（有限体上の行列の位数と固有値の位数の関係は古典）。
-/
import Mathlib

namespace IntegrableLattice

open Matrix

variable {K : Type*} [Field K] {d : ℕ}

/-- $Av=\mu v$ なら $A^n v=\mu^n v$。 -/
theorem mulVec_pow_eq_pow_smul (A : Matrix (Fin d) (Fin d) K) (μ : K) (v : Fin d → K)
    (hv : A *ᵥ v = μ • v) : ∀ n : ℕ, (A ^ n) *ᵥ v = (μ ^ n) • v := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
    calc (A ^ (n + 1)) *ᵥ v = (A * A ^ n) *ᵥ v := by rw [pow_succ']
      _ = A *ᵥ ((A ^ n) *ᵥ v) := (Matrix.mulVec_mulVec v A (A ^ n)).symm
      _ = A *ᵥ ((μ ^ n) • v) := by rw [ih]
      _ = (μ ^ n) • (A *ᵥ v) := by rw [Matrix.mulVec_smul]
      _ = (μ ^ n) • (μ • v) := by rw [hv]
      _ = (μ ^ (n + 1)) • v := by rw [smul_smul, ← pow_succ]

/-- $A^N=1$ で $\mu$ が（固有ベクトル $v\neq0$ をもつ）固有値なら $\mu^N=1$。 -/
theorem eigenvalue_pow_eq_one_of_pow_eq_one {A : Matrix (Fin d) (Fin d) K} {μ : K}
    {v : Fin d → K} (hv0 : v ≠ 0) (hv : A *ᵥ v = μ • v) {N : ℕ} (hN : A ^ N = 1) :
    μ ^ N = 1 := by
  have h1 : (μ ^ N) • v = v := by
    rw [← mulVec_pow_eq_pow_smul A μ v hv N, hN, Matrix.one_mulVec]
  -- $(\mu^N-1)\cdot v=0$ を成分で見る
  obtain ⟨i, hi⟩ : ∃ i, v i ≠ 0 := by
    simpa [funext_iff] using Function.ne_iff.mp hv0
  have h2 : (μ ^ N) * v i = v i := congrFun h1 i
  have h3 : ((μ ^ N) - 1) * v i = 0 := by linear_combination h2
  rcases mul_eq_zero.mp h3 with h | h
  · exact sub_eq_zero.mp h
  · exact absurd h hi

/-- 固有値の乗法的位数は行列の乗法的位数を割る。 -/
theorem orderOf_eigenvalue_dvd_orderOf {A : Matrix (Fin d) (Fin d) K} {μ : K}
    {v : Fin d → K} (hv0 : v ≠ 0) (hv : A *ᵥ v = μ • v) :
    orderOf μ ∣ orderOf A :=
  orderOf_dvd_of_pow_eq_one
    (eigenvalue_pow_eq_one_of_pow_eq_one hv0 hv (pow_orderOf_eq_one A))

/-- **命題 B の片方向**: 固有値の有限集合 $s$ について
$\operatorname{lcm}_{\mu\in s}\operatorname{ord}(\mu)\mid\operatorname{ord}(A)$。
$A=T\bmod p$、$s$ を $\chi_T$ の $\overline{\mathbb{F}_p}$ 上の相異固有値の集合に取れば
$\operatorname{lcm}\{\operatorname{ord}(\lambda)\}\mid\pi(p,1)$ である。
**逆向きは形式化していない**（ファイル冒頭を見よ）。 -/
theorem lcm_orderOf_eigenvalues_dvd_orderOf (A : Matrix (Fin d) (Fin d) K) [DecidableEq K]
    (s : Finset K) (hs : ∀ μ ∈ s, ∃ v : Fin d → K, v ≠ 0 ∧ A *ᵥ v = μ • v) :
    s.lcm orderOf ∣ orderOf A := by
  refine Finset.lcm_dvd ?_
  intro μ hμ
  obtain ⟨v, hv0, hv⟩ := hs μ hμ
  exact orderOf_eigenvalue_dvd_orderOf hv0 hv

end IntegrableLattice
