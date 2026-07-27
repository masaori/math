/-
# 具体版: `A(θ) = B_1(θ) B_2 B_1(θ)`（`θ ∈ ℝ` 一般）

対応する人手証明のラベル: **`factorization_of_A_theta_general`**
（`structured-latex/content/014_even_sector_T_action.ts` の
`evensectorT_009_claim_factorization_A_theta`）

## Lean 側の既存の証明との関係

008 章の `factorization_of_A_theta` は `μ ∈ 𝓜` で量化されており、原文はそのままでは
`θ~_μ` に使えないので、本章で `θ ∈ ℝ` 一般の主張として立て直している。

**Lean 側の既存定理 `Ising2D.B1_mul_B2_mul_B1_eq_AMat`
（`Part008/Definition016_TV.lean`）は最初から `θ : ℝ` 一般で述べられている**ので、
本章の `factorization_of_A_theta_general` はそれそのものである。
本ファイルでは名前を原文のラベルに合わせて言い直し、`θ = θ~_μ` への特殊化を与える。

## 原文が明示していない前提（008 章と同じ）

`B_1(θ) B_2 B_1(θ)` を素朴に展開すると非対角成分に現れるのは `c_2^*` だが、
`def_A_theta` の `A(θ)` には `c_2` が現れる。一致には双対関係の帰結
`c_2^* = s_2^* c_2` が要る。**本章の原文 `factorization_of_A_theta_general` の proof は
Step 4 でこの等式を `duality_c2_star_eq_s2_star_c2` として明示的に引用しており、
008 章で欠けていた前提がここでは補われている。**
Lean 側では従来どおり仮定 `hdual` として持つ。
-/
import Ising2D.Part013.Claim002_AntiperiodicExpSum
import Ising2D.Part014.Definition007_B1B2

namespace Ising2D

variable {M : ℕ}

/-- **原文 `factorization_of_A_theta_general`**: `θ ∈ ℝ` について
`B_1(θ) B_2 B_1(θ) = A(θ)`。

仮定は `IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であることと、
双対関係の帰結 `hdual : s_2^* c_2 = c_2^*`（原文の
`duality_c2_star_eq_s2_star_c2`）だけである。 -/
theorem factorization_of_A_theta_general (K : IsingConst) (K1 K2star : ℂ) (θ : ℝ)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    B1mat K1 (θ : ℂ) * B2mat K2star * B1mat K1 (θ : ℂ) = AMat K θ :=
  B1_mul_B2_mul_B1_eq_AMat K K1 K2star θ hc1 hs1 hc2star hs2star hdual

/-- **原文の「とくに」の部分**: `θ = θ~_μ` としたもの。 -/
theorem factorization_of_A_thetaTilde (K : IsingConst) (K1 K2star : ℂ) (μ : ℤ)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) * B2mat K2star * B1mat K1 ((thetaTilde M μ : ℝ) : ℂ)
      = AMat K (thetaTilde M μ) :=
  factorization_of_A_theta_general K K1 K2star (thetaTilde M μ) hc1 hs1 hc2star hs2star hdual

end Ising2D
