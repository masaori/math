/-
# `w = -conj z` である複素数の対（**必要十分版**）

対応する人手証明のラベル: `relation_of_gamma_2_theta_tilde`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_003_claim_relation_of_gamma2`）

具体版: `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimRelationGamma2Tilde.lean`。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明は `γ_2(-θ~_μ) = -overline{γ_2(θ~_μ)}` を出発点に、(2) 積が負の実数、
(3) 偏角が `π`、(4) `√(-γ_2γ_2(-θ)) = |γ_2|`、(5) `√(γ_2γ_2(-θ)) = i|γ_2|` を導く。
これらに効いているのは

* **`w = -conj z` という関係ただ 1 つ**

だけである。`γ_2` の具体形（`i e^{iθ} s_2^*(c_1cos θ - i sin θ - s_1c_2)`）も、
`θ` が半整数運動量であることも、Ising 模型の定数も、`M` も効いていない。
**`z ≠ 0`（人手証明では `gamma_2_theta_tilde_nonzero`）が効くのは狭義の不等号だけ**で、
等式 (1)(2)(4)(5) は `z = 0` でも成り立つ。

なお人手証明が `arg^{[0,2π)}` 分岐つきの平方根 `def_sqrt_cc` を経由している (4)(5) は、
ここでは**平方根関数を使わず**「`(|z|)^2 = -(z w)`」「`(i|z|)^2 = z w`」という
2 乗の等式として述べる（`RoutesNotAdopted/IntegerMomentum/ClaimEigenvectorsAndDiagonalizationOfATheta.lean` と同じ方針）。
分岐の選択は「`|z|` と `-|z|` のどちらを取るか」に還元され、人手証明が
`arg^{[0,2π)}` で固定しているのは前者（非負の方）である。

## (2) の狭義の負の鎖

具体版 `absGamma2_thetaTilde_sq_pos`・`neg_absGamma2_thetaTilde_sq_neg` の `calc`（人手の 3 行と 2 行の鎖）は、
`sq_pos_of_pos_chain`・`neg_neg_of_pos_chain` の `calc` と同じ並びで対応する。効くのは

* `0·a = 0`、正の元を右から掛けると狭義の不等号が保たれること（`MulPosStrictMono`）、
* 冪の定義の 2 つの式と `1` が乗法の単位元であること（`NecSuf.sq_eq_mul_self'`）、
* 両辺の符号を反転すると狭義の不等号の向きが変わること（加法の左右からの狭義の単調性）

だけである。複素数であること、絶対値であること、全順序、順序の反対称律、乗法の可換性、分配則、
加法の可換性、加法の逆元の存在（第一の鎖）は効いていない。
第一の鎖の仮定は `MonoidWithZero R`（`0·a = 0` と冪）・`Preorder R`・`MulPosStrictMono R`（第 2 段の狭義の単調性）だけである。
`Preorder R` は mathlib の `MulPosStrictMono` の定義が前提にするためだけに置く（鎖が使うのは `<` だけで、反射律・推移律は使わない）。
`MonoidWithZero R` は、冪の `Monoid` と `0·a = 0` の `MulZeroClass` に同じ乗法を共有させるために置く（`mul_zero` は使っていない。
2 つを別々に置くと乗法が 2 つになるので、両方を 1 つの乗法で満たす最小のクラスとしてこれを選んだ）。
第二の鎖は、人手と具体版と同じく直前の鎖の結論 `0 < x`（`x := a^2`）を入力に取り、乗法を使わない。
仮定は `AddGroup R`（符号反転と `-0 = 0`）・`LT R`・加法の左右からの狭義の単調性
`AddLeftStrictMono R`・`AddRightStrictMono R` だけである（反射律・推移律・加法の可換性は使わない）。
加法が可換でないので、一般の `a < b ⟹ -b < -a`（第 1 段の `0 < x ⟹ -x < -0`）には左右両方の単調性が要る。
左からだけでは片方の辺が `0` のときの `-x < 0` しか出ず、それを使うと第 1 段で `-0 = 0` を先に使うことになり、
具体版と段が揃わない。`AddRightStrictMono R` は、数学として要るからではなく、第 1 段を具体版と同じ 1 回の適用にするために残した仮定である。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Ising2D.NecSuf.SquareIsProduct

namespace Ising2D.NecSuf

variable {z w : ℂ}

/-- **必要十分版 (2)**: `w = -conj z` なら `z w = -|z|^2`（非正の実数）。 -/
theorem mul_of_eq_neg_conj (h : w = -(starRingEnd ℂ) z) :
    z * w = -((Complex.normSq z : ℝ) : ℂ) := by
  rw [h, mul_neg, Complex.mul_conj]

/-- **必要十分版**: `w = -conj z` なら `z ≠ 0 ⟹ w ≠ 0`。 -/
theorem ne_zero_of_eq_neg_conj (h : w = -(starRingEnd ℂ) z) (hz : z ≠ 0) : w ≠ 0 := by
  rw [h, neg_ne_zero]
  simpa using hz

/-- **必要十分版 (4)**: `(|z|)^2 = -(z w)`（`|z| := √(normSq z) ≥ 0`）。
人手証明の `√(-γ_2γ_2(-θ)) = |γ_2|` を平方根関数抜きで述べたもの。 -/
theorem sq_absOf_eq_neg_mul (h : w = -(starRingEnd ℂ) z) :
    ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ) ^ 2 = -(z * w) := by
  rw [mul_of_eq_neg_conj h, neg_neg, ← Complex.ofReal_pow,
    Real.sq_sqrt (Complex.normSq_nonneg z)]

/-- **必要十分版 (5)**: `(i|z|)^2 = z w`。
人手証明の `√(γ_2γ_2(-θ)) = i|γ_2|` を平方根関数抜きで述べたもの。 -/
theorem sq_I_mul_absOf_eq_mul (h : w = -(starRingEnd ℂ) z) :
    (Complex.I * ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ)) ^ 2 = z * w := by
  have hI : (Complex.I : ℂ) ^ 2 = -1 := Complex.I_sq
  have hr := sq_absOf_eq_neg_mul h
  calc (Complex.I * ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ)) ^ 2
      = Complex.I ^ 2 * ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ) ^ 2 := by ring
    _ = (-1) * (-(z * w)) := by rw [hI, hr]
    _ = z * w := by ring

/-- **必要十分版**: `z ≠ 0` なら `|z| > 0`。狭義の不等号が要るのはここだけ。
具体版 `absGamma2_pos_of_ne_zero` と同じ 3 段（`|z| ≥ 0`、`abs_basic_properties` (3) で `|z| ≠ 0`、順序で `> 0`）。
`w = -conj z` は使わない。主張は ℂ の上の特定の写像 `|·| = √(normSq ·)` の値についての主張で、段 2 が
`abs_basic_properties` (3)（この写像の零点が `0_ℂ` だけであること）を使うので、ℂ と `|·|` から抽象度を上げる余地が無い。
具体版から取り除けたのは `γ_2` の具体形と `θ̃_μ` だけである。 -/
theorem absOf_pos (hz : z ≠ 0) : 0 < Real.sqrt (Complex.normSq z) := by
  have h0 : 0 ≤ Real.sqrt (Complex.normSq z) := Real.sqrt_nonneg _   -- 段 1: `def_abs_arg`
  have hne : Real.sqrt (Complex.normSq z) ≠ 0 := by                  -- 段 2: `abs_basic_properties` (3)
    intro h
    apply hz
    exact Complex.normSq_eq_zero.1 (le_antisymm (Real.sqrt_eq_zero'.1 h) (Complex.normSq_nonneg z))
  exact lt_of_le_of_ne h0 (Ne.symm hne)                               -- 段 3: ℝ の順序

section StrictNegativity

/-- **必要十分版 (2) の狭義部分の第一の鎖**: `0 < a` なら `0 < a^2`。
具体版 `absGamma2_thetaTilde_sq_pos` の 3 段と同じ並び。 -/
theorem sq_pos_of_pos_chain {R : Type*} [MonoidWithZero R] [Preorder R] [MulPosStrictMono R]
    {a : R} (ha : 0 < a) : 0 < a ^ 2 :=
  calc (0 : R)
      = 0 * a := (zero_mul a).symm                       -- `0·a = 0`
    _ < a * a := mul_lt_mul_of_pos_right ha ha           -- 正の元 `a` を右から掛ける
    _ = a ^ 2 := (sq_eq_mul_self' a).symm                -- `square_of_real_number_is_product` を右辺から左辺へ

/-- **必要十分版 (2) の狭義部分の第二の鎖**: `0 < x` なら `-x < 0`（`x := a^2` を第一の鎖から受け取る）。
具体版 `neg_absGamma2_thetaTilde_sq_neg` の 2 段と同じ並び。 -/
theorem neg_neg_of_pos_chain {R : Type*} [AddGroup R] [LT R] [AddLeftStrictMono R]
    [AddRightStrictMono R] {x : R} (hx : 0 < x) : -x < 0 :=
  calc -x
      < -0 := neg_lt_neg_iff.2 hx                        -- 符号を反転すると向きが変わる
    _ = 0 := neg_zero                                    -- `-0 = 0`

end StrictNegativity

end Ising2D.NecSuf
