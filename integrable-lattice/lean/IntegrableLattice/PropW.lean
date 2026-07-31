/-
# 命題 W（非退化グラフ塔の閉形式）— 判定条件の検算と、閉形式の帰属の穴

対応する人手証明:
`integrable-lattice/structured-latex/content/006_propositions_TVW.ts` の
`paper_063_theorem_W`（ラベル `paper_prop_W`）、
根拠 report は `outputs/reports/cycle14_T3_two_variable_criterion.md`、
`outputs/reports/cycle14_T3_Zl2_tower_criterion.md`。

## 人手証明のステートメント

$f=\det L(1+T,1+S)$ の $\bmod\,\ell$ 還元の最低次斉次部分を $H$（次数 $k$）とし、$H$ が
$\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない（**非退化**）とき、$n\gg0$ で
$$\operatorname{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\,\ell^{n}-2n+\nu,
\qquad \mu=v_\ell(\operatorname{content}\det L).$$
非退化性は $\det L$ の係数からの**有限計算で判定できる**。

## 本ファイルで形式化したこと

**閉形式そのものは形式化していない。** 上界方向が Cuoco–Monsky の定理に依拠しており
（人手証明自身が「自前では証明できなかった」と明記）、岩澤型漸近は mathlib に無い
（`logs/mathlib-gap-survey-cycle18.log`。`IwasawaInvariant` 0 件、`iwasawa` のヒット 6 件は
群論の岩澤単純性判定法と docstring の言及のみ）。matrix-tree も無い（`PropT.lean` 参照）。

形式化したのは、**この step の目的である「主張の検算」に直接効く 2 点**である。

### (1) 非退化性は本当に有限計算で決まり、本文の 2 つの適用例は正しい

`NoProjZero` を定義し、`Decidable` に乗ることを使って本文の適用例を `decide` で検算した。

* $\ell=3$、$H(t,s)=-(t^2+s^2)$: **非退化**（`torus_nondegenerate_three`）。
* $\ell=2$、$H(t,s)=(t+s)^2$: **退化**（`torus_degenerate_two`。零点 $(1,1)$）。射程外という本文の記述と一致。

副産物として、**非退化なら $k\ge2$**（1 次形式は必ず射影零点をもつ）を証明した
（`exists_proj_zero_of_linear`）。本文は $k\ge2$ を明示していないが、非退化性の定義から従う。

### (2) 閉形式の $\nu$ の帰属が本文に書かれていない（**食い違い**）

$\dfrac{k(\ell+1)}{\ell-1}$ は一般に**整数ではない**。$\ell-1=(\ell+1)-2$ なので、整数になるのは
$(\ell-1)\mid 2k$ のときに限る。本文の適用例 $\ell=3,k=2$ では $\frac{2\cdot4}{2}=4$ で整数になるため
この問題が表に出ていないが、**$\ell=5,k=3$ では $\frac{3\cdot6}{4}=\frac92$ である。**

$\operatorname{ord}_\ell(\kappa_n)\in\mathbb{Z}$ なので、このとき $\nu$ は**整数ではありえない**
（`propW_nu_not_integer_of_ell_five_k_three`。$\mu,\nu\in\mathbb{Z}$ を仮定すると
$9\cdot5^n$ が偶数になり矛盾する）。**本文は $\nu$ がどこに住むか（$\mathbb{Z}$ か $\mathbb{Q}$ か）を
書いていない。** 本プロジェクトの規約（各量の帰属を明示する）に照らすと、これは書き落としである。

なお $k=3$・$\ell=5$ という組合せが**非退化性と両立する**ことは確認した
（`quintic_cubic_nondegenerate`: $H(t,s)=t^3+ts^2+s^3$ は $\mathbb{P}^1(\mathbb{F}_5)$ 上に零点をもたない）。
すなわち $(\ell-1)\nmid k(\ell+1)$ は命題 W の仮定から排除されていない。
**ただしこれは「そういう $H$ をもつグラフ塔が実在する」ことまでは主張していない**
（$H$ は $\det L$ の最低次部分という追加の制約を受ける）。本文の仮定の書き方の問題として指摘する。

**新規性は主張しない。**
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Order.Ring.Int
import Mathlib.Tactic

namespace IntegrableLattice

/-- 2 変数斉次形式 $H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたないこと（**非退化**）。
$\mathbb{F}_\ell$ が有限なので、この述語は有限計算で判定できる（`Decidable` に乗る）。 -/
def NoProjZero (l : ℕ) [NeZero l] (H : ZMod l → ZMod l → ZMod l) : Prop :=
  ∀ t s : ZMod l, ¬ (t = 0 ∧ s = 0) → H t s ≠ 0

instance (l : ℕ) [NeZero l] (H : ZMod l → ZMod l → ZMod l) : Decidable (NoProjZero l H) := by
  unfold NoProjZero
  infer_instance

/-! ## 本文の適用例の検算（$L\times L$ トーラス、$H=-(T^2+S^2)$、$k=2$） -/

/-- 本文の適用例その 1: $\ell=3$ では $-1$ が非平方なので **非退化**。 -/
theorem torus_nondegenerate_three : NoProjZero 3 (fun t s => -(t ^ 2 + s ^ 2)) := by decide

/-- 本文の適用例その 2: $\ell=2$ では $H\equiv(T+S)^2$ が有理零点 $(1,1)$ をもつので **退化**
（本文の「射程外」と一致）。 -/
theorem torus_degenerate_two : ¬ NoProjZero 2 (fun t s => (t + s) ^ 2) := by decide

/-- 非退化なら $k\ge2$: 1 次形式 $aT+bS$（$(a,b)\neq0$）は必ず射影零点 $(b,-a)$ をもつ。 -/
theorem exists_proj_zero_of_linear {l : ℕ} [NeZero l] (a b : ZMod l) (hab : ¬ (a = 0 ∧ b = 0)) :
    ¬ NoProjZero l (fun t s => a * t + b * s) := by
  intro h
  refine h b (-a) ?_ ?_
  · rintro ⟨hb, ha⟩
    exact hab ⟨by simpa using congrArg Neg.neg ha, hb⟩
  · ring

/-! ## $(\ell-1)\nmid k(\ell+1)$ は命題 W の仮定と両立する -/

/-- $\ell=5$ 上の 3 次形式 $H(t,s)=t^3+ts^2+s^3$（$x^3+x+1$ は $\mathbb{F}_5$ 上既約）は**非退化**。
したがって $k=3$、$\ell=5$ は非退化性と両立し、$\frac{k(\ell+1)}{\ell-1}=\frac92\notin\mathbb{Z}$ になる。 -/
theorem quintic_cubic_nondegenerate :
    NoProjZero 5 (fun t s => t ^ 3 + t * s ^ 2 + s ^ 3) := by decide

/-- **$\nu$ は整数ではありえない**（$\ell=5,k=3$ のとき）。
$\operatorname{ord}_\ell(\kappa_n)$ は整数なので、$\mu,\nu$ をともに整数と読むと矛盾する。 -/
theorem propW_nu_not_integer_of_ell_five_k_three (mu nu : ℤ) (n : ℕ) :
    ¬ ∃ z : ℤ, (z : ℚ)
      = (mu : ℚ) * 5 ^ (2 * n) + (3 * (5 + 1) : ℚ) / (5 - 1) * 5 ^ n - 2 * n + (nu : ℚ) := by
  rintro ⟨z, hz⟩
  have hcast : ((2 * z - 2 * mu * 5 ^ (2 * n) + 4 * n - 2 * nu : ℤ) : ℚ)
      = ((9 * 5 ^ n : ℤ) : ℚ) := by
    push_cast
    linarith
  have hint : 2 * z - 2 * mu * 5 ^ (2 * n) + 4 * (n : ℤ) - 2 * nu = 9 * 5 ^ n :=
    Int.cast_injective hcast
  have heven : Even (9 * 5 ^ n : ℤ) :=
    ⟨z - mu * 5 ^ (2 * n) + 2 * (n : ℤ) - nu, by linarith⟩
  have hodd : Odd (9 * 5 ^ n : ℤ) := (by decide : Odd (9 : ℤ)).mul ((by decide : Odd (5 : ℤ)).pow)
  exact (Int.not_even_iff_odd.mpr hodd) heven

end IntegrableLattice
