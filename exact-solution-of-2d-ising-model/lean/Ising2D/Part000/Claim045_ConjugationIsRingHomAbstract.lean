/-
# 共役写像は環準同型 — 抽象版からの導出

対応する人手証明:
`parts/000_計算公式/045_claim_共役写像は環準同型.typ`
(`<conjugation_is_ring_homomorphism>`)

人手証明と 1 対 1 に対応する具体版は
`Ising2D/Part000/Claim045_ConjugationIsRingHom.lean`（`Ising2D.Conjugation.matrix_conj_*` ほか）にある。
抽象版は `Ising2D/Abstract/Conjugation.lean`（`Ising2D.Abstract.Conj.*`）にある。

本ファイルは、**具体版（`Mat(n,ℂ)` と `Matrix.inv` による共役）を抽象版の系として導出する**
（`exact-solution-of-2d-ising-model/README.md` 4 節の規約）。

導出の要点は、抽象版が仮定を最小まで削ってあるので、行列側で用意すべき事実が
次の 3 つに限られることである。

* 乗法性 (1) には `B⁻¹ * B = 1`（`Matrix.nonsing_inv_mul`）だけ。
* 単位性 (2) には `B * B⁻¹ = 1`（`Matrix.mul_nonsing_inv`）だけ。
* 合成則 (3) には**何も要らない**（結合律のみ）。`(AB)⁻¹ = B⁻¹A⁻¹`
  （`Matrix.mul_inv_rev`）は、右側に出てくる `B⁻¹A⁻¹` を `(AB)⁻¹` と書き直すためだけに使う。
  mathlib の `Matrix.inv` は特異行列に `0` を返す全域関数なので、この書き直しにも正則性は要らない。
-/
import Ising2D.Abstract.Conjugation
import Ising2D.Part000.Claim045_ConjugationIsRingHom
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

namespace Ising2D.Conjugation

open Ising2D.Abstract

/-- 既存の具体版 `T`（一般の環 `R` と単元 `B : Rˣ`）は、抽象版の挟み込み写像そのものである。 -/
theorem T_eq_sandwich {R : Type*} [Ring R] (B : Rˣ) (A : R) :
    T B A = Conj.sandwich (B : R) ((B⁻¹ : Rˣ) : R) A := rfl

/-- 既存の具体版 `T` は、抽象版のモノイド準同型としての共役と一致する
（乗法性・単位性がモノイドの構造だけで足りることの確認）。 -/
theorem T_eq_conjMonoidHom {R : Type*} [Ring R] (B : Rˣ) (A : R) :
    T B A = Conj.conjMonoidHom B A := rfl

section Matrix

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **(1) 乗法性**（原文の記法）を抽象版 `Conj.sandwich_mul` の系として得る。
使うのは `B⁻¹ * B = 1` の 1 本だけである。 -/
theorem matrix_conj_mul_of_abstract (B : Matrix n n ℂ) (hB : IsUnit B.det) (A C : Matrix n n ℂ) :
    B * (A * C) * B⁻¹ = (B * A * B⁻¹) * (B * C * B⁻¹) :=
  Conj.sandwich_mul (b := B) (u := B⁻¹) (nonsing_inv_mul B hB) A C

/-- **(2) 単位性**（原文の記法）を抽象版 `Conj.sandwich_one` の系として得る。
使うのは `B * B⁻¹ = 1` の 1 本だけである。 -/
theorem matrix_conj_one_of_abstract (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    B * 1 * B⁻¹ = 1 :=
  Conj.sandwich_one (b := B) (u := B⁻¹) (mul_nonsing_inv B hB)

/-- **(3) 合成則**（原文の記法）を抽象版 `Conj.sandwich_comp` の系として得る。
抽象版の側には仮定が無く、行列側で足すのは `(AB)⁻¹ = B⁻¹A⁻¹` の書き直しだけである
（これも正則性を要さない）。 -/
theorem matrix_conj_comp_of_abstract (A B X : Matrix n n ℂ) :
    A * (B * X * B⁻¹) * A⁻¹ = (A * B) * X * (A * B)⁻¹ := by
  rw [Matrix.mul_inv_rev]
  exact Conj.sandwich_comp A A⁻¹ B B⁻¹ X

/-- 正則行列 `B` を単元 `(Matrix n n ℂ)ˣ` として見たときの逆元は `Matrix.inv` と一致する。
抽象版（単元で述べてある）と原文の記法（`Matrix.inv`）をつなぐ橋。 -/
@[simp]
theorem coe_inv_nonsingInvUnit (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    (((B.nonsingInvUnit hB)⁻¹ : (Matrix n n ℂ)ˣ) : Matrix n n ℂ) = B⁻¹ := rfl

/-- **合成則 (3) の群準同型としての形**を行列で述べたもの。
`B ↦ T_B` は `(Mat(n,ℂ))ˣ` から `Mat(n,ℂ)` の環自己同型群への群準同型である
（抽象版 `Conj.conjRingAutHom` の特殊化）。 -/
def matrixConjRingAutHom : (Matrix n n ℂ)ˣ →* RingAut (Matrix n n ℂ) :=
  Conj.conjRingAutHom

@[simp]
theorem matrixConjRingAutHom_apply (B : (Matrix n n ℂ)ˣ) (A : Matrix n n ℂ) :
    matrixConjRingAutHom B A = (B : Matrix n n ℂ) * A * ((B⁻¹ : (Matrix n n ℂ)ˣ) : Matrix n n ℂ) :=
  rfl

/-- 正則行列 `B` に対して、原文の `T_B(A) = B A B⁻¹`（`Matrix.inv` 版）が
群準同型 `matrixConjRingAutHom` の値と一致すること。 -/
theorem matrixConjRingAutHom_nonsingInvUnit (B : Matrix n n ℂ) (hB : IsUnit B.det)
    (A : Matrix n n ℂ) :
    matrixConjRingAutHom (B.nonsingInvUnit hB) A = B * A * B⁻¹ := rfl

/-- **加法性**（原文は「環準同型」と呼ぶが明示していない）。
抽象版 `Conj.sandwich_add` の系であり、**正則性を一切使わない**。 -/
theorem matrix_conj_add_of_abstract (B : Matrix n n ℂ) (A C : Matrix n n ℂ) :
    B * (A + C) * B⁻¹ = B * A * B⁻¹ + B * C * B⁻¹ :=
  Conj.sandwich_add B B⁻¹ A C

end Matrix

end Ising2D.Conjugation
