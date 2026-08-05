/-
# 命題 W\* の残り 2 件のうち「$\mathbb{Q}[x]$ 側の無平方性への降下（Gauss）」— cycle 46 step 1

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の
  「$\rho$ は分離的なので Euler の双対基底公式より」の段

## この file が埋めるもの

本文は $\rho=\mathrm{rad}(\chi)$ の無平方性を $\mathbb{Z}[x]$ の側で述べている。
一方、$\mu$ の構成（`WStarMuGram.mu`）と $\det G$ の式（`WStarMuGram.det_weightedGram_mu_of_squarefree`）が
要求しているのは $\mathbb{Q}[x]$ 側の無平方性である。
**その降下を仮定として受け取ったままにしていたのが、この項目である。**

## 測ったこと（着手前の実測。2026-08-05）

**素材はこちらが 8 サイクル前に書いていた。** cycle 38 step 1 の
`WStarSquarefree.squarefree_map_of_monic`（整閉整域 $R$ の上のモニックな無平方多項式の像は
商体の上でも無平方）がちょうどこの降下そのものである。
**残っていたのは配線だけで、素材の側ではなかった。そう書く。**

台帳がこの項目を「残り」として立てたのは cycle 41 step 1 で、そのとき
$\mathbb{Q}[x]$ 側の無平方性を仮定として型に出した。
**その 3 サイクル前に降下は書けていたのに、書いた側と使う側が繋がっていなかった。**
これは cycle 35・36・40 で見つかった「数と実態がずれる」型ではなく、
**書いたものが在ることに気付かないまま仮定として立て直した**型である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。扱うのは $R[x]$（本論文では $\mathbb{Z}[x]$）と
その商体 $K$（$\mathbb{Q}$）の上の多項式の整除・微分だけである。$\mathbb{Q}$ は可算である。

## 書いたこと（4 段）

1. **降下そのもの**（`squarefree_map`）。cycle 38 step 1 の移送を、本文が使う形
   （$\rho$ がモニックで無平方）で名指しする。
2. **$\rho'(\theta)$ が $K[x]/(\rho_K)$ の単元であること**（`isUnit_aeval_derivative_of_integral`）。
3. **本文の $\eta=\mu\,\rho'(\theta)$**（`derivative_mul_mu_of_integral`）。
   $\mu$ の構成が $\mathbb{Z}[x]$ 側の仮定だけから出る形になる。
4. **本文の $\det G=\pm N_{A_K/K}(\eta)$**（`det_weightedGram_mu_of_integral`）。
   次数の移送には $\rho$ がモニックであることを使う（`Polynomial.Monic.natDegree_map`）。

## 形式化しなかったもの

* $\rho=\mathrm{rad}(\chi)$ が $\mathbb{Z}[x]$ の側で無平方であること自体は
  `WStarRadical.squarefree_rad` が与えるが、その仮定（$f_i$ が素で互いに割らない）を
  本文の $\chi$ の分解から出す段は本 file では扱っていない
  （`WStarFactorExtraction.exists_monic_prime_factorization` が別に持っている）。
-/
import Mathlib
import IntegrableLattice.WStarSquarefreeNonzero
import IntegrableLattice.WStarMuGram

namespace IntegrableLattice
namespace WStarGaussDescent

open Polynomial

variable {R : Type*} [CommRing R] [IsIntegrallyClosed R]
variable (K : Type*) [Field K] [PerfectField K] [Algebra R K] [IsFractionRing R K]

/-- **降下そのもの。** $\rho\in R[x]$ がモニックで無平方なら、商体 $K$ の上でも無平方である。

中身は cycle 38 step 1 の `WStarSquarefree.squarefree_map_of_monic` である。 -/
theorem squarefree_map {ρ : R[X]} (hmonic : ρ.Monic) (hsq : Squarefree ρ) :
    Squarefree (ρ.map (algebraMap R K)) :=
  WStarSquarefree.squarefree_map_of_monic K hmonic hsq

/-- **$\rho'(\theta)$ は $K[x]/(\rho_K)$ の単元である**（$\mathbb{Z}[x]$ 側の仮定だけから）。 -/
theorem isUnit_aeval_derivative_of_integral {ρ : R[X]} (hmonic : ρ.Monic) (hsq : Squarefree ρ) :
    IsUnit (aeval (AdjoinRoot.root (ρ.map (algebraMap R K)))
      (derivative (ρ.map (algebraMap R K)))) :=
  WStarMuGram.isUnit_aeval_derivative (squarefree_map K hmonic hsq)

/-- **本文の $\eta=\mu\,\rho'(\theta)$**（$\mathbb{Z}[x]$ 側の仮定だけから）。 -/
theorem derivative_mul_mu_of_integral {ρ : R[X]} (hmonic : ρ.Monic) (hsq : Squarefree ρ)
    (η : AdjoinRoot (ρ.map (algebraMap R K))) :
    aeval (AdjoinRoot.root (ρ.map (algebraMap R K))) (derivative (ρ.map (algebraMap R K)))
        * WStarMuGram.mu (ρ.map (algebraMap R K)) η = η :=
  WStarMuGram.derivative_mul_mu (squarefree_map K hmonic hsq) η

/-- **本文の $\det G=\pm N_{A_K/K}(\eta)$**（$\mathbb{Z}[x]$ 側の仮定だけから）。

次数の仮定も $R[x]$ 側で述べる。モニックなので像の次数は変わらない。 -/
theorem det_weightedGram_mu_of_integral {m : ℕ} {ρ : R[X]} (hmonic : ρ.Monic)
    (hsq : Squarefree ρ) (hdeg : ρ.natDegree = m + 1)
    (η : AdjoinRoot (ρ.map (algebraMap R K))) :
    (EulerDualBasis.weightedGram (R := K) (m := m)
        (AdjoinRoot.root (ρ.map (algebraMap R K)))
        (WStarMuGram.mu (ρ.map (algebraMap R K)) η)).det
      = (EulerDualBasis.eulerMatrix
          (WStarPowerBasis.adjoinRootBasis (hmonic.map (algebraMap R K))
            (by rwa [hmonic.natDegree_map]))
          (ρ.map (algebraMap R K)) (AdjoinRoot.root (ρ.map (algebraMap R K)))).det
        * Algebra.norm K η :=
  WStarMuGram.det_weightedGram_mu_of_squarefree (hmonic.map (algebraMap R K))
    (squarefree_map K hmonic hsq) (by rwa [hmonic.natDegree_map]) η

end WStarGaussDescent
end IntegrableLattice
