/-
# `A(θ)` の固有値・固有ベクトルと対角化 `A = P D P⁻¹`

対応する人手証明（正本は `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`）:
- `TV1_hatZ_hatY_027_claim_eigenvector_A_theta`（ラベル `eigenvector_of_A_theta`）
- `TV1_hatZ_hatY_028_claim_P_mu_D_mu`（ラベル `diagonalization_P_D`）
- `TV1_hatZ_hatY_035_claim_det_A_theta`（ラベル `det_A_theta`）

## 形式化の方針

* **複素平方根の分枝を避ける。** 原文は `√(γ_2(θ)γ_2(-θ))` と `√(-γ_2(θ)γ_2(-θ))` を
  同時に使い、その関係（`√(-1·z) = -√(-1)√z`）を `arg^{[0,2π)}` の加法性から導いている。
  Lean では平方根関数を導入せず、
  `t : ℂ` が `t^2 = γ_2(θ)γ_2(-θ)` を満たす、という**仮定**の形で扱う。
  こうすると分枝の選択は「`t` と `-t` のどちらを取るか」だけになり、結論は
  どちらでも成立する（`P` の 2 列と `D` の 2 成分が同時に入れ替わるだけ）ことが明示される。
* 固有ベクトルは `s^2 = -(γ_2(θ)γ_2(-θ))` を満たす `s` に対して
  `v = (-s, γ_2(-θ))` が固有値 `γ_1(θ) + s` の固有ベクトルであることとして述べる
  （`AMat_mulVec_eigen`）。これは `γ_2 = 0` の場合も含めて**無条件**に成り立つ
  （`γ_2 = 0` なら零ベクトルになるだけで、等式自体は正しい）。

## 原文との符号・分枝の突き合わせ（検算結果）

原文は `λ_{±,μ} = γ_1 ± √(-γ_2(θ_μ)γ_2(-θ_μ))`、
`v_{±,μ} = c(±i√(γ_2(θ_μ)γ_2(-θ_μ)), γ_2(-θ_μ))` と対応させている。
`t := √(γ_2(θ)γ_2(-θ))` と書くと `v_+` の第 1 成分は `+i t` であり、
上の一般形 `v = (-s, γ_2(-θ))` と比べると `s = -i t`、対応する固有値は `γ_1 - i t` である。
一方 `λ_+ = γ_1 + √(-γ_2γ_2)` なので、両者が整合するのは
`√(-γ_2(θ)γ_2(-θ)) = -i√(γ_2(θ)γ_2(-θ))` のとき、すなわち
**原文が `arg^{[0,2π)}` 分枝で導いている `√(-1·z) = -√(-1)√z`（`z = γ_2γ_2(-θ)` は負の実数）**
が成り立つときに限る。したがって原文の符号対応は、その分枝規約の下で**正しい**。
本ファイルではその整合を `AMat_mulVec_col_pos` / `AMat_mulVec_col_neg` として
`t` の言葉で明示的に確認している（`i t` 側の固有値が `γ_1 - i t`）。

## 形式化の過程で見つかった原文の問題

1. **`det_A_theta`（`TV1_hatZ_hatY_035`）は `A(θ)` の定義からは直接出ない。**
   `A(θ)` の定義（`def_A_theta`）だけから無条件に言えるのは
   `det A(θ) = γ_1(θ)^2 + γ_2(θ)γ_2(-θ)`（`det_AMat`）までである。
   これが `1` になるには `c_1, s_1, c_2, c_2^*, s_2^*` の間の次の 3 つの関係が要る
   （`det_AMat_eq_one`）:
     (i) `c_1^2 - s_1^2 = 1`（`cosh^2(2K_1) - sinh^2(2K_1) = 1`）
     (ii) `(c_2^*)^2 - (s_2^*)^2 = 1`（`cosh^2(2K_2^*) - sinh^2(2K_2^*) = 1`）
     (iii) `c_2 s_2^* = c_2^*`（双対関係 `sinh(2K_2)sinh(2K_2^*) = 1` の帰結
           `cosh(2K_2)sinh(2K_2^*) = cosh(2K_2^*)`）
   原文は `A(θ_μ) = B_1(θ_μ)B_2B_1(θ_μ)`（`factorization_of_A_theta`）から
   `det A = (det B_1)^2 det B_2 = 1` を出しており、(i)(ii) はそこで使っている。
   **問題は (iii) が明示されていないこと**である。実際 `B_1, B_2` には `c_2^*, s_2^*` しか現れず、
   `def_A_theta` の `(1,2)` 成分に現れる `c_2` は `B_1B_2B_1` を展開すると `c_2^*/s_2^*` として
   出てくる。すなわち **`c_2 = c_2^*/s_2^*` すなわち (iii) は
   「`def_A_theta` の行列と `B_1B_2B_1` が一致する」という主張そのものに埋め込まれた前提**であり、
   その `factorization_of_A_theta` の proof は原文では TODO（Mathematica による数値確認のみ）である。
   (iii) を落とすと `det A(θ)` は `θ` に依存し `1` にならない（`c_2` を `c_2^*` に置き換えた
   数値例で確認済み）。
2. **固有値と固有ベクトルの符号対応には分枝規約が要る（statement 側に指定が無い）。**
   詳細は上の「原文との符号・分枝の突き合わせ」を参照。検算の結果 **原文の対応は正しい**が、
   それが成り立つのは原文が proof 中で導いている `arg^{[0,2π)}` 分枝の関係
   `√(-1·z) = -√(-1)√z` の下でのみである。statement には分枝の指定が無い。
3. **`P_μ` の可逆性が原文では確認されていない。**
   `diagonalization_P_D` は `A(θ_μ) = P_μ D_μ P_μ^{-1}` と書くが、`P_μ^{-1}` が存在すること
   （`det P_μ ≠ 0`）は述べていない。Lean 側では `det_Pmat` / `det_Pmat_ne_zero` で
   `det P_μ = i t/(2(√M)^2 γ_2(-θ_μ))` を計算し、`γ_2(θ_μ) ≠ 0`, `M ≠ 0` の下で非零を示した。

なお `eigenvector_of_A_theta` の場合分け 1) の「この場合 `A(θ_μ) = I`」は、原文が
`A_theta_is_identity_when_gamma2_zero`（`TV1_hatZ_hatY_045`）を参照しており、そこでは
`det A = 1` と `γ_1 ≥ 1`（`TV1_hatZ_hatY_036`）から `γ_1 = 1` を出している。**原文の穴ではない。**
本ファイルではその依存関係を機械的に分離して確認できるよう、
`AMat_of_gamma2_eq_zero`（`A = γ_1 I` まで）と
`gamma1_sq_eq_one_of_gamma2_eq_zero`（上の 3 関係から `γ_1^2 = 1`）に分けてある。
-/
import Ising2D.Part008.Definition019_ThetaGamma

namespace Ising2D

open Matrix

variable (K : IsingConst) (θ : ℝ)

/-! ## 特性多項式と固有値（原文 `eigenvector_of_A_theta` 前半） -/

/-- 原文の特性方程式 `λ^2 - 2γ_1 λ + (γ_1^2 + γ_2(θ)γ_2(-θ)) = 0`。 -/
theorem charPoly_expand (lam : ℂ) :
    (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)).det
      = lam ^ 2 - 2 * gamma1 K θ * lam + (gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ)) := by
  rw [AMat_eq, Matrix.det_fin_two]
  simp
  ring

/-- `s^2 = -(γ_2(θ)γ_2(-θ))` を満たす `s` に対し、`γ_1 + s` は特性方程式の根。
原文の「2 次方程式の解の公式」による `λ_± = γ_1 ± √(-γ_2γ_2)` に対応する。 -/
theorem charPoly_root (s : ℂ) (hs : s ^ 2 = -(gamma2 K θ * gamma2 K (-θ))) :
    (gamma1 K θ + s) ^ 2 - 2 * gamma1 K θ * (gamma1 K θ + s)
      + (gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ)) = 0 := by
  linear_combination hs

/-- 特性方程式の根は `γ_1 ± s` **に限る**（積が `γ_1^2 + γ_2γ_2(-θ)`、和が `2γ_1` の 2 根）。 -/
theorem charPoly_factor (s : ℂ) (hs : s ^ 2 = -(gamma2 K θ * gamma2 K (-θ))) (lam : ℂ) :
    lam ^ 2 - 2 * gamma1 K θ * lam + (gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ))
      = (lam - (gamma1 K θ + s)) * (lam - (gamma1 K θ - s)) := by
  linear_combination hs

/-! ## 固有ベクトル（原文 `eigenvector_of_A_theta` 後半） -/

/-- **原文 `eigenvector_of_A_theta` の固有ベクトル**（分枝を仮定の形にした版）。
`s^2 = -(γ_2(θ)γ_2(-θ))` のとき `(-s, γ_2(-θ))` は固有値 `γ_1(θ) + s` の固有ベクトル。
`γ_2 = 0` の場合も含めて無条件に成り立つ等式である。 -/
theorem AMat_mulVec_eigen (s : ℂ) (hs : s ^ 2 = -(gamma2 K θ * gamma2 K (-θ))) :
    AMat K θ *ᵥ ![-s, gamma2 K (-θ)] = (gamma1 K θ + s) • ![-s, gamma2 K (-θ)] := by
  rw [AMat_eq]
  funext i
  fin_cases i <;>
    simp [Matrix.mulVec, dotProduct] <;>
      first
        | linear_combination hs
        | ring

/-- もう一方の固有ベクトル `(γ_2(θ), s)`（`γ_2(-θ) = 0` でも消えない形）。 -/
theorem AMat_mulVec_eigen' (s : ℂ) (hs : s ^ 2 = -(gamma2 K θ * gamma2 K (-θ))) :
    AMat K θ *ᵥ ![gamma2 K θ, s] = (gamma1 K θ + s) • ![gamma2 K θ, s] := by
  rw [AMat_eq]
  funext i
  fin_cases i <;>
    simp [Matrix.mulVec, dotProduct] <;>
      first
        | linear_combination hs
        | linear_combination -hs
        | ring

/-- 原文の `v_{+,μ} = c(+i√(γ_2γ_2(-θ)), γ_2(-θ))` に対応する形。
固有値は `γ_1 - i t`（原文の `λ_{+,μ} = γ_1 + √(-γ_2γ_2)` は分枝規約
`√(-1·z) = -√(-1)√z` の下でこれに一致する。冒頭コメント参照）。 -/
theorem AMat_mulVec_col_pos (t : ℂ) (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ)) :
    AMat K θ *ᵥ ![Complex.I * t, gamma2 K (-θ)]
      = (gamma1 K θ - Complex.I * t) • ![Complex.I * t, gamma2 K (-θ)] := by
  have hs : (-(Complex.I * t)) ^ 2 = -(gamma2 K θ * gamma2 K (-θ)) := by
    linear_combination -ht + t ^ 2 * Complex.I_sq
  have := AMat_mulVec_eigen K θ (-(Complex.I * t)) hs
  simpa [sub_eq_add_neg] using this

/-- 原文の `v_{-,μ} = c(-i√(γ_2γ_2(-θ)), γ_2(-θ))` に対応する形（固有値 `γ_1 + i t`）。 -/
theorem AMat_mulVec_col_neg (t : ℂ) (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ)) :
    AMat K θ *ᵥ ![-(Complex.I * t), gamma2 K (-θ)]
      = (gamma1 K θ + Complex.I * t) • ![-(Complex.I * t), gamma2 K (-θ)] := by
  have hs : (Complex.I * t) ^ 2 = -(gamma2 K θ * gamma2 K (-θ)) := by
    linear_combination -ht + t ^ 2 * Complex.I_sq
  have := AMat_mulVec_eigen K θ (Complex.I * t) hs
  simpa using this

/-! ## `γ_2(θ) = 0` の場合（原文 `eigenvector_of_A_theta` の場合分け 1)） -/

/-- `γ_2(θ) = 0` のとき `A(θ) = γ_1(θ) I`。原文の「`A(θ_μ) = I`」はここまでしか言えない。 -/
theorem AMat_of_gamma2_eq_zero (h : gamma2 K θ = 0) :
    AMat K θ = gamma1 K θ • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  have h' : gamma2 K (-θ) = 0 := (gamma2_neg_eq_zero_iff K θ).2 h
  rw [AMat_eq, h, h']
  ext i j
  fin_cases i <;> fin_cases j <;> simp

/-! ## 行列式（原文 `det_A_theta`） -/

/-- 無条件に成り立つ形: `det A(θ) = γ_1(θ)^2 + γ_2(θ)γ_2(-θ)`。 -/
theorem det_AMat : (AMat K θ).det = gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ) := by
  rw [AMat_eq, Matrix.det_fin_two_of]
  ring

/-- `γ_2(θ)γ_2(-θ)` の実数表示。`e^{iθ}e^{-iθ} = 1` を使って指数因子を消したもの。 -/
theorem gamma2_mul_gamma2_neg :
    gamma2 K θ * gamma2 K (-θ)
      = -((K.s2star : ℂ) ^ 2 *
          (((K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) ^ 2
            + (Real.sin θ : ℂ) ^ 2)) := by
  have hexp : Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (-(Complex.I * (θ : ℂ))) = 1 := by
    rw [← Complex.exp_add]
    simp
  have hI : (Complex.I : ℂ) ^ 2 = -1 := Complex.I_sq
  rw [gamma2, gamma2_neg]
  linear_combination
    (Complex.I ^ 2 * (K.s2star : ℂ) ^ 2 *
        ((K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) ^ 2
      - Complex.I ^ 4 * (K.s2star : ℂ) ^ 2 * (Real.sin θ : ℂ) ^ 2) * hexp
    + ((K.s2star : ℂ) ^ 2 *
        ((K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) ^ 2
      + (K.s2star : ℂ) ^ 2 * (Real.sin θ : ℂ) ^ 2
      - Complex.I ^ 2 * (K.s2star : ℂ) ^ 2 * (Real.sin θ : ℂ) ^ 2) * hI

/-- **原文 `det_A_theta` の修正版**: `det A(θ) = 1` に必要な代数関係を明示した形。
(i) `c_1^2 - s_1^2 = 1`、(ii) `(c_2^*)^2 - (s_2^*)^2 = 1`、(iii) `c_2 s_2^* = c_2^*`。 -/
theorem det_AMat_eq_one
    (h1 : K.c1 ^ 2 - K.s1 ^ 2 = 1)
    (h2 : K.c2star ^ 2 - K.s2star ^ 2 = 1)
    (h3 : K.c2 * K.s2star = K.c2star) :
    (AMat K θ).det = 1 := by
  have H1 : (K.c1 : ℂ) ^ 2 - (K.s1 : ℂ) ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_sub, h1, Complex.ofReal_one]
  have H2 : (K.c2star : ℂ) ^ 2 - (K.s2star : ℂ) ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_sub, h2, Complex.ofReal_one]
  have H3 : (K.c2 : ℂ) * (K.s2star : ℂ) = (K.c2star : ℂ) := by
    rw [← Complex.ofReal_mul, h3]
  have HPy : (Real.cos θ : ℂ) ^ 2 + (Real.sin θ : ℂ) ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_add,
      Real.cos_sq_add_sin_sq, Complex.ofReal_one]
  rw [det_AMat, gamma2_mul_gamma2_neg, gamma1]
  simp only [Complex.ofReal_sub, Complex.ofReal_mul]
  linear_combination
    (2 * (K.c1 : ℂ) * (K.s1 : ℂ) * (K.s2star : ℂ) * (Real.cos θ : ℂ)
      - (K.s1 : ℂ) ^ 2 * ((K.c2 : ℂ) * (K.s2star : ℂ) + (K.c2star : ℂ))) * H3
    + ((K.c2star : ℂ) ^ 2 - (K.s2star : ℂ) ^ 2 * (Real.cos θ : ℂ) ^ 2) * H1
    + (-((K.s2star : ℂ) ^ 2)) * HPy + H2

/-- `γ_2(θ) = 0` のとき `γ_1(θ)^2 = 1`（したがって `A(θ) = ±I`）。 -/
theorem gamma1_sq_eq_one_of_gamma2_eq_zero
    (h1 : K.c1 ^ 2 - K.s1 ^ 2 = 1)
    (h2 : K.c2star ^ 2 - K.s2star ^ 2 = 1)
    (h3 : K.c2 * K.s2star = K.c2star)
    (h : gamma2 K θ = 0) :
    gamma1 K θ ^ 2 = 1 := by
  have hd := det_AMat_eq_one K θ h1 h2 h3
  rw [det_AMat, h, zero_mul, add_zero] at hd
  exact hd

/-- 固有値の積が `det A` に等しいこと（原文の `λ_{+,μ}λ_{-,μ} = 1` の無条件版）。 -/
theorem lambda_mul_lambda (t : ℂ) (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ)) :
    (gamma1 K θ - Complex.I * t) * (gamma1 K θ + Complex.I * t) = (AMat K θ).det := by
  rw [det_AMat, ← ht]
  have : Complex.I ^ 2 = -1 := Complex.I_sq
  linear_combination (-(t ^ 2)) * this

/-! ## 対角化（原文 `diagonalization_P_D`） -/

/-- 原文 `diagonalization_P_D` の `P_μ`。原文の `√(γ_2(θ)γ_2(-θ))` を `t`、`√M` を `sM`
というパラメータで表す。原文の任意定数の選択は `c = 1/(2√M γ_2(-θ))`。 -/
noncomputable def Pmat (t sM : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![Complex.I * t / (2 * sM * gamma2 K (-θ)), -(Complex.I * t) / (2 * sM * gamma2 K (-θ));
    1 / (2 * sM), 1 / (2 * sM)]

/-- 原文 `diagonalization_P_D` の `D_μ = diag(λ_{+,μ}, λ_{-,μ})`。
`λ_{+,μ} = γ_1 - i t`, `λ_{-,μ} = γ_1 + i t`（分枝の対応は冒頭コメント参照）。 -/
noncomputable def Dmat (t : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![gamma1 K θ - Complex.I * t, 0; 0, gamma1 K θ + Complex.I * t]

theorem det_Pmat (t sM : ℂ) (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    (Pmat K θ t sM).det = Complex.I * t / (2 * sM ^ 2 * gamma2 K (-θ)) := by
  rw [Pmat, Matrix.det_fin_two_of]
  field_simp
  ring

theorem det_Pmat_ne_zero (t sM : ℂ) (ht : t ≠ 0) (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    (Pmat K θ t sM).det ≠ 0 := by
  rw [det_Pmat K θ t sM hsM hh]
  exact div_ne_zero (mul_ne_zero Complex.I_ne_zero ht)
    (mul_ne_zero (mul_ne_zero two_ne_zero (pow_ne_zero 2 hsM)) hh)

/-- `A(θ) P = P D`（対角化の本体）。 -/
theorem AMat_mul_Pmat (t sM : ℂ) (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ))
    (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    AMat K θ * Pmat K θ t sM = Pmat K θ t sM * Dmat K θ t := by
  have hI : Complex.I ^ 2 = -1 := Complex.I_sq
  -- 除算を含まない骨格 `Q`（固有ベクトルを列に並べた行列）で計算し、
  -- 原文の任意定数 `c = 1/(2√M γ_2(-θ))` はスカラー倍として外に出す。
  set Q : Matrix (Fin 2) (Fin 2) ℂ :=
    !![Complex.I * t, -(Complex.I * t); gamma2 K (-θ), gamma2 K (-θ)] with hQ
  have hP : Pmat K θ t sM = (1 / (2 * sM * gamma2 K (-θ))) • Q := by
    ext i j
    fin_cases i <;> fin_cases j <;> simp [Pmat, hQ] <;> field_simp
  have hkey : AMat K θ * Q = Q * Dmat K θ t := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply, Fin.sum_univ_two, AMat_eq, Dmat, hQ] <;>
        first
          | linear_combination -ht + t ^ 2 * hI
          | ring
  rw [hP, Matrix.mul_smul, hkey, Matrix.smul_mul]

/-- **原文 `diagonalization_P_D`**: `γ_2(θ_μ) ≠ 0`, `M ≠ 0` の下で `A(θ_μ) = P_μ D_μ P_μ⁻¹`。 -/
theorem AMat_eq_Pmat_mul_Dmat_mul_inv (t sM : ℂ) (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ))
    (hg : gamma2 K θ ≠ 0) (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    AMat K θ = Pmat K θ t sM * Dmat K θ t * (Pmat K θ t sM)⁻¹ := by
  have ht0 : t ≠ 0 := by
    intro h
    apply hg
    have : (0 : ℂ) = gamma2 K θ * gamma2 K (-θ) := by rw [← ht, h]; ring
    rcases mul_eq_zero.1 this.symm with h1 | h1
    · exact h1
    · exact absurd h1 hh
  have hdet : IsUnit (Pmat K θ t sM).det :=
    isUnit_iff_ne_zero.2 (det_Pmat_ne_zero K θ t sM ht0 hsM hh)
  rw [← AMat_mul_Pmat K θ t sM ht hsM hh, Matrix.mul_nonsing_inv_cancel_right _ _ hdet]

/-- 原文の `√M` を `Real.sqrt M` で具体化した版（`M ≠ 0` が原文の `M ≠ 0` に対応）。 -/
theorem AMat_thetaMu_eq_Pmat_mul_Dmat_mul_inv (M : ℕ) (hM : M ≠ 0) (μ : ℤ) (t : ℂ)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0) :
    AMat K (thetaMu M μ)
      = Pmat K (thetaMu M μ) t (Real.sqrt M) * Dmat K (thetaMu M μ) t
        * (Pmat K (thetaMu M μ) t (Real.sqrt M))⁻¹ := by
  have hsM : ((Real.sqrt M : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact Real.sqrt_ne_zero'.2 (by exact_mod_cast Nat.pos_of_ne_zero hM)
  have hh : gamma2 K (-thetaMu M μ) ≠ 0 := fun h => hg ((gamma2_neg_eq_zero_iff K _).1 h)
  exact AMat_eq_Pmat_mul_Dmat_mul_inv K (thetaMu M μ) t (Real.sqrt M) ht hg hsM hh

end Ising2D
